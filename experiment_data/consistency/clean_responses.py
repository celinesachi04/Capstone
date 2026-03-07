import csv
import os
import re
from collections import defaultdict


def normalize_prediction(content):
    """Normalize a raw prediction string to a comparable token."""
    content = content.strip()
    if not content:
        return "error"

    # Remove extra leading numbering if model outputs nested list markers.
    content = re.sub(r'^(?:\d+\s*[\.\:\)\-]\s*)+', '', content).strip()
    content = re.sub(r'^\**\d+\**\s*:\s*\**\s*', '', content).strip()

    # Candidate name normalization for attorney_general.
    content = re.sub(r'\bSerrano\b', 'Pete', content, flags=re.IGNORECASE)
    content = re.sub(r'\bBrown\b', 'Nick', content, flags=re.IGNORECASE)

    bold_match = re.search(r'\*\*([a-zA-Z]+)\*\*', content)
    if bold_match:
        return bold_match.group(1).lower()

    colon_match = re.search(r':\s*\**\s*([a-zA-Z]+)\s*\**', content)
    if colon_match:
        return colon_match.group(1).lower()

    token_match = re.match(r'^([a-zA-Z]+)', content)
    if token_match:
        return token_match.group(1).lower()

    return "error"


def extract_id_answer_pairs(filepath):
    """Extract (voter_id, prediction) pairs from lines like 'voter_id. response'."""
    pairs = []
    with open(filepath, "r", encoding="utf-8") as f:
        for raw_line in f:
            line = raw_line.strip()
            if not line:
                continue

            match = re.match(r'^\s*(\d+)\s*(?:[\.\:\)\-]\s*|\s+)(.*)$', line)
            if not match:
                continue

            voter_id = match.group(1)
            prediction_raw = match.group(2)
            prediction = normalize_prediction(prediction_raw)
            pairs.append((voter_id, prediction))

    return pairs


def process_responses_folder(base_folder, output_folder):
    os.makedirs(output_folder, exist_ok=True)

    for folder_name in os.listdir(base_folder):
        folder_path = os.path.join(base_folder, folder_name)
        if not os.path.isdir(folder_path):
            continue

        file_groups = defaultdict(dict)
        for fname in os.listdir(folder_path):
            if not fname.endswith(".txt"):
                continue
            match = re.match(r'^(.+)_(\d+)\.txt$', fname)
            if match:
                base_name = match.group(1)
                number = int(match.group(2))
                file_groups[base_name][number] = os.path.join(folder_path, fname)

        folder_output = os.path.join(output_folder, folder_name)
        os.makedirs(folder_output, exist_ok=True)

        for base_name, numbered_files in file_groups.items():
            sorted_numbers = sorted(numbered_files.keys())

            # loop_number -> {voter_id: prediction}
            per_loop_predictions = {}
            ordered_voter_ids = []
            seen_ids = set()

            for num in sorted_numbers:
                pairs = extract_id_answer_pairs(numbered_files[num])
                id_to_prediction = {}
                for voter_id, prediction in pairs:
                    if voter_id not in id_to_prediction:
                        id_to_prediction[voter_id] = prediction
                    if voter_id not in seen_ids:
                        seen_ids.add(voter_id)
                        ordered_voter_ids.append(voter_id)
                per_loop_predictions[num] = id_to_prediction

            csv_path = os.path.join(folder_output, f"{folder_name}_{base_name}.csv")
            with open(csv_path, "w", newline="", encoding="utf-8") as csvfile:
                writer = csv.writer(csvfile)
                header = ["voter_id"] + [f"{base_name}_{num}" for num in sorted_numbers]
                writer.writerow(header)

                for voter_id in ordered_voter_ids:
                    row = [voter_id]
                    for num in sorted_numbers:
                        row.append(per_loop_predictions[num].get(voter_id, ""))
                    writer.writerow(row)

            print(f"Created: {csv_path}")


if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    base_folder = os.path.join(script_dir, "responses")
    output_folder = os.path.join(script_dir, "clean_responses")

    if not os.path.isdir(base_folder):
        print(f"Folder '{base_folder}' not found.")
    else:
        process_responses_folder(base_folder, output_folder)
        print("Done!")
