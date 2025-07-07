#!/bin/bash

# Usage: ./_find-extention.sh <directory> <extension|none>
# Example: ./_find-extention.sh /home/user/Documents jpg
#          ./_find-extention.sh /home/user/Documents none

output_dir="$(dirname "$0")/../output"
mkdir -p "$output_dir"
timestamp=$(date +"%Y%m%d%H%M%S")
output_file="$output_dir/${timestamp}_find-extention.txt"

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <extension|none>"
    exit 1
fi

search_dir="$1"
ext="$2"

if [ ! -d "$search_dir" ]; then
    echo "Error: Directory not found: $search_dir"
    exit 1
fi

shopt -s nocaseglob

if [ "$ext" = "none" ]; then
    # Find files without an extension
    mapfile -t files < <(find "$search_dir" -type f ! -name "*.*")
else
    # Find files with the given extension (case-insensitive)
    mapfile -t files < <(find "$search_dir" -type f -iname "*.$ext")
fi

count="${#files[@]}"

{
    echo "find-extention output"
    echo "Directory: $search_dir"
    echo "Extension: $ext"
    echo "Total files found: $count"
    echo ""
    for file in "${files[@]}"; do
        echo "$file"
    done
} > "$output_file"

echo "Output written to: $output_file"
