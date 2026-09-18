#!/bin/bash
set -euo pipefail

# Usage: ./analyze-moby-dick.sh SEARCH_PATTERN [OUTPUT]
SEARCH_PATTERN="$1"
OUTPUT="${2:-results.txt}"

if [ -f "$OUTPUT" ]; then
  echo "Error: output file '$OUTPUT' already exists. Aborting." >&2
  exit 1
fi

MOBY_DICK_URL="https://gist.githubusercontent.com/StevenClontz/4445774/raw/1722a289b665d940495645a5eaaad4da8e3ad4c7/mobydick.txt"

curl -s -o mobydick.txt "$MOBY_DICK_URL"

OCCURRENCES=$(grep -oi "$SEARCH_PATTERN" mobydick.txt | wc -l | tr -d ' ')

{
  echo "The search pattern $SEARCH_PATTERN was found $OCCURRENCES time(s)."
  echo ""
  echo "Line numbers where it was found:"
  grep -ni "$SEARCH_PATTERN" mobydick.txt | cut -d: -f1
} > "$OUTPUT"
