#!/usr/bin/env python3
"""Create per-folder stability summary CSVs from classified prompt files."""

from __future__ import annotations

import csv
from pathlib import Path
from statistics import mean, stdev


BASE_DIR = Path("experiment_data/consistency/clean_responses/stability_summary")
TARGET_DIRS = [
    "all_covariates",
    "demo_covariates",
    "family_covariates",
    "ses_covariates",
]


def summarize_file(path: Path) -> tuple[str, float, float]:
    scores: list[float] = []
    with path.open("r", newline="", encoding="utf-8") as infile:
        reader = csv.DictReader(infile)
        for row in reader:
            scores.append(float(row["stability_score"]))

    if not scores:
        return path.name, 0.0, 0.0

    avg = mean(scores)
    sd = stdev(scores) if len(scores) > 1 else 0.0
    return path.name, avg, sd


def write_summary(directory_name: str) -> None:
    folder = BASE_DIR / directory_name
    files = sorted(folder.glob("*.csv"))
    rows = [["csv_file", "mean_stability_score", "std_stability_score"]]

    for file_path in files:
        file_name, avg, sd = summarize_file(file_path)
        rows.append([file_name, f"{avg:.4f}", f"{sd:.4f}"])

    output_path = BASE_DIR / f"{directory_name}_stability_summary.csv"
    with output_path.open("w", newline="", encoding="utf-8") as outfile:
        writer = csv.writer(outfile)
        writer.writerows(rows)


def main() -> None:
    for directory_name in TARGET_DIRS:
        write_summary(directory_name)

    print(f"Wrote {len(TARGET_DIRS)} summary CSV files.")


if __name__ == "__main__":
    main()
