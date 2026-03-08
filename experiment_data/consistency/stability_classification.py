#!/usr/bin/env python3
"""Add stability classification columns to cleaned response CSV files."""

from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path


BASE_DIR = Path("experiment_data/consistency/clean_responses")
TARGET_DIRS = [
    "all_covariates",
    "demo_covariates",
    "family_covariates",
    "ses_covariates",
]


def consistency_level(score: float) -> str:
    if score >= 0.75:
        return "high"
    if score >= 0.45:
        return "medium"
    return "low"


def stability_vector(values: list[str], label_to_int: dict[str, int]) -> str:
    # Some rows may contain empty cells if a voter_id is missing in a run.
    # Keep pipeline running by encoding unknown/blank entries as -1.
    encoded = [label_to_int.get(val, -1) for val in values]
    return "[" + ",".join(str(v) for v in encoded) + "]"


def binary_score(top_count: int) -> float:
    return top_count / 5.0


def multilabel_score(values: list[str]) -> float:
    # Use normalized concentration (HHI) for 3+ label tasks.
    counts = Counter(values)
    n = len(values)
    hhi = sum((count / n) ** 2 for count in counts.values())
    min_hhi = 1.0 / n
    return (hhi - min_hhi) / (1.0 - min_hhi)


def classify(values: list[str], num_labels: int) -> tuple[float, str]:
    counts = Counter(values)
    ordered = sorted(counts.items(), key=lambda x: (-x[1], x[0]))
    top_label, top_count = ordered[0]
    second_label = ordered[1][0] if len(ordered) > 1 else None
    second_count = ordered[1][1] if len(ordered) > 1 else 0

    if num_labels <= 2:
        score = binary_score(top_count)
    else:
        score = multilabel_score(values)

    if top_count == 5:
        label = f"perfectly_stable_{top_label}"
    elif top_count == 4:
        label = f"strongly_{top_label}_slightly_unstable"
    elif top_count == 3:
        if second_count == 2 and second_label is not None:
            label = f"weak_{top_label}_over_{second_label}_unstable"
        else:
            label = f"weak_{top_label}_mixed_unstable"
    elif top_count == 2:
        label = "very_unstable_split"
    else:
        label = "highly_unstable_all_different"

    return score, label


def process_csv(path: Path) -> tuple[str, str, str] | None:
    with path.open("r", newline="", encoding="utf-8") as infile:
        reader = csv.reader(infile)
        rows = list(reader)

    if not rows:
        return None

    full_header = rows[0]
    has_voter_id = len(full_header) >= 6 and full_header[0].strip().lower() == "voter_id"

    if has_voter_id:
        base_header = full_header[:6]  # voter_id + 5 response columns
        data_rows = [r[:6] for r in rows[1:] if len(r) >= 6]
        response_rows = [r[1:6] for r in data_rows]
    else:
        base_header = full_header[:5]  # legacy format without voter_id
        data_rows = [r[:5] for r in rows[1:] if len(r) >= 5]
        response_rows = data_rows

    labels = sorted({v.strip() for row in response_rows for v in row if v.strip()})
    label_to_int = {label: idx for idx, label in enumerate(labels)}

    new_header = base_header + ["stability", "stability_score", "consistency_level"]
    new_rows = [new_header]

    for row, responses in zip(data_rows, response_rows):
        score, _classification = classify(responses, len(labels))
        vec = stability_vector(responses, label_to_int)
        new_rows.append(row + [vec, f"{score:.2f}", consistency_level(score)])

    with path.open("w", newline="", encoding="utf-8") as outfile:
        writer = csv.writer(outfile)
        writer.writerows(new_rows)

    mapping_text = "; ".join(f"{label}={idx}" for label, idx in label_to_int.items())
    if len(labels) <= 2:
        rules_text = (
            "score=max(count(X))/5; "
            "perfectly_stable_X: 5X/0other; "
            "strongly_X: 4X/1other; "
            "weak_X: 3X/2other; "
            "very_unstable_split: top count=2; "
            "highly_unstable_all_different: top count=1"
        )
    else:
        rules_text = (
            "score=normalized HHI concentration for 5 responses; "
            "perfectly_stable_X: 5 of same label; "
            "strongly_X: top count=4; "
            "weak_X: top count=3; "
            "very_unstable_split: top count=2; "
            "highly_unstable_all_different: top count=1"
        )
    return path.name, mapping_text, rules_text


def main() -> None:
    csv_paths = []
    for dirname in TARGET_DIRS:
        csv_paths.extend(sorted((BASE_DIR / dirname).glob("*.csv")))

    rules_rows = [["csv_file", "response_to_number", "classification_rules"]]
    for csv_path in csv_paths:
        result = process_csv(csv_path)
        if result is not None:
            rules_rows.append(list(result))

    rules_path = BASE_DIR / "stability_classification_rules.csv"
    with rules_path.open("w", newline="", encoding="utf-8") as outfile:
        writer = csv.writer(outfile)
        writer.writerows(rules_rows)

    print(f"Processed {len(csv_paths)} CSV files.")


if __name__ == "__main__":
    main()
