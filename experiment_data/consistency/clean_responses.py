import os
import re
import csv
from collections import defaultdict

def extract_answers(filepath):
    """Extract answers from a numbered list txt file using flexible regex for tail-end values."""
    answers = []
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            # Check if the line starts with a numbered item, e.g. "1.", "1:", "1)", "1-", or "1 A"
            prefix_match = re.match(r'^\s*\d+\s*(?:[\.\:\)\-]\s*|\s+)(.*)$', line)
            if prefix_match:
                # 1. Remove leading number marker
                content = prefix_match.group(1).strip()
                # Some outputs contain double numbering like "1. 1. no".
                # Remove any additional leading numeric prefixes.
                content = re.sub(r'^(?:\d+\s*[\.\:\)\-]\s*)+', '', content).strip()
                # Some outputs use markdown index labels like "**1:** A (...)"
                # after the outer numbered list marker.
                content = re.sub(r'^\**\d+\**\s*:\s*\**\s*', '', content).strip()
                
                # Name replacement as per your original logic
                content = re.sub(r'\bSerrano\b', 'Pete', content, flags=re.IGNORECASE)
                content = re.sub(r'\bBrown\b', 'Nick', content, flags=re.IGNORECASE)

                # NEW REGEX LOGIC:
                # We look for the prediction which is usually after a colon or bolded.
                # Pattern A: Matches **word** inside bolding (even if text follows in parens)
                # Pattern B: Matches the word immediately following a colon
                # Pattern C: Matches the very last word of the line if no parens exist
                
                found_match = None
                
                # Try to find bolded answer: **yes** or **no**
                bold_match = re.search(r'\*\*([a-zA-Z]+)\*\*', content)
                if bold_match:
                    found_match = bold_match.group(1)
                else:
                    # Try to find the word after the last colon (common in your example)
                    # This matches ": yes" or ": no" and ignores trailing parentheticals
                    colon_match = re.search(r':\s*\**\s*([a-zA-Z]+)\s*\**', content)
                    if colon_match:
                        found_match = colon_match.group(1)
                    else:
                        # Fallback: Just take the first word after the number if structure is "1. Yes"
                        fallback_match = re.match(r'^([a-zA-Z]+)', content)
                        if fallback_match:
                            found_match = fallback_match.group(1)

                if found_match:
                    answers.append(found_match.lower()) # Normalize to lowercase
                else:
                    answers.append("error") # Placeholder for debugging
                    
    return answers

def process_responses_folder(base_folder, output_folder):
    os.makedirs(output_folder, exist_ok=True)

    for folder_name in os.listdir(base_folder):
        folder_path = os.path.join(base_folder, folder_name)
        if not os.path.isdir(folder_path):
            continue

        file_groups = defaultdict(dict)
        for fname in os.listdir(folder_path):
            if not fname.endswith('.txt'):
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
            columns = []
            for num in sorted_numbers:
                answers = extract_answers(numbered_files[num])
                columns.append(answers)

            num_rows = max(len(col) for col in columns) if columns else 0

            csv_path = os.path.join(folder_output, f"{folder_name}_{base_name}.csv")
            with open(csv_path, 'w', newline='', encoding='utf-8') as csvfile:
                writer = csv.writer(csvfile)
                writer.writerow([f"{base_name}_{num}" for num in sorted_numbers])
                for i in range(num_rows):
                    row = [col[i] if i < len(col) else '' for col in columns]
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
