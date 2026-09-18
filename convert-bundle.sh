#!/bin/bash
set -euo pipefail

curl -sL -o lab3-bundle.tar.gz https://s3.amazonaws.com/ds2002-resources/labs/lab3-bundle.tar.gz

tar -xzf lab3-bundle.tar.gz

awk '!/^[[:space:]]*$/' lab3_data.tsv > cleaned.tsv

tr '\t' ',' < cleaned.tsv > cleaned.csv

line_count=$(($(wc -l < cleaned.csv) - 1))
echo "Number of data lines (excluding header): $line_count"

tar -czf converted-archive.tar.gz cleaned.csv
