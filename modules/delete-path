#!/bin/bash

# Usage: ./delete-paths.sh [-y] <list_file>
# -y : skip confirmation prompt
# Permanently deletes files/folders listed in the text file

# Parse -y flag
auto_yes=false
if [ "$1" = "-y" ]; then
    auto_yes=true
    shift
fi

list_file="$1"

if [[ -z "$list_file" || ! -f "$list_file" ]]; then
    echo "Usage: $0 [-y] <list_file>"
    exit 1
fi

# Read paths from file
mapfile -t paths < "$list_file"

file_count=0
dir_count=0
total_size=0

for path in "${paths[@]}"; do
    if [ -f "$path" ]; then
        ((file_count++))
        size=$(stat -c%s "$path" 2>/dev/null || stat -f%z "$path")
        total_size=$((total_size + size))
    elif [ -d "$path" ]; then
        ((dir_count++))
        size=$(du -sb "$path" 2>/dev/null | awk '{print $1}')
        total_size=$((total_size + size))
    fi
    # Ignore non-existent paths
done

size_human=$(numfmt --to=iec --suffix=B $total_size 2>/dev/null || echo "$total_size bytes")

echo "About to permanently delete:"
echo "  $file_count files"
echo "  $dir_count folders"
echo "  Total size: $size_human ($total_size bytes)"

delete_confirmed=false
if $auto_yes; then
    delete_confirmed=true
else
    read -p "Proceed with permanent deletion? [y/N]: " confirm
    if [[ "$confirm" =~ ^[yY]$ ]]; then
        delete_confirmed=true
    fi
fi

if $delete_confirmed; then
    for path in "${paths[@]}"; do
        if [ -e "$path" ]; then
            rm -rf -- "$path"
        fi
    done
    echo "Permanent deletion complete."
else
    echo "Operation cancelled."
fi
