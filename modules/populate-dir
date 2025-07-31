#!/bin/bash

# Directory to search (default is current directory)
TARGET_DIR="${1:-.}"
PLACEHOLDER_MSG="Touched by superuserken, see https://github.com/superuserken/hoardkit for more info."

# Find all empty directories and add PLACEHOLDER.txt with message
find "$TARGET_DIR" -type d -empty -print0 | while IFS= read -r -d '' dir; do
    echo "$PLACEHOLDER_MSG" > "$dir/PLACEHOLDER.txt"
    echo "Created PLACEHOLDER.txt in: $dir"
done