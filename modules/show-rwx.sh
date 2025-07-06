#!/bin/bash

# Usage: ./show-rwx.sh [target_dir]
# Scans visible (non-dot) files and folders, groups by permission string, and allows export of a list for a selected variation.

# Permission legend for non-technical users
echo "" 
echo "File/Folder Permission Table (r=read, w=write, x=execute/-=none):"
echo "Each permission string is 10 characters:"
echo "  1st: type (d=directory, -=file)"
echo "  2-4: user (owner) permissions"
echo "  5-7: group permissions"
echo "  8-10: other (everyone else) permissions"
echo "Example: drwxr-xr-- means:"
echo "  d = directory"
echo "  rwx = user can read, write, execute"
echo "  r-x = group can read, execute"
echo "  r-- = others can only read"
echo ""
echo "A table will be shown below for each permission variation."
echo ""

target_dir="${1:-.}"
now_ts=$(date +"%Y%m%d%H%M%S")
repo_dir="$(dirname "$(dirname "$(realpath "$0")")")"
output_dir="$repo_dir/output"
mkdir -p "$output_dir"

# Find all visible files and folders, get their permission string and path
mapfile -t all_entries < <(find "$target_dir" \( -type f -o -type d \) -not -name ".*" -printf '%M %p\n')

total_entries=${#all_entries[@]}

# Build associative arrays for permission counts and file lists
declare -A perm_counts
declare -A perm_files

count=0
for entry in "${all_entries[@]}"; do
    perm="${entry%% *}"
    path="${entry#* }"
    ((perm_counts["$perm"]++))
    perm_files["$perm"]+="$path\n"
    ((count++))
    percent=$((count * 100 / total_entries))
    echo -ne "\rProcessing: $percent% ($count/$total_entries)"
done
echo -e "\rProcessing: 100% ($total_entries/$total_entries)\n"

# List all permission variations with counts in a table
perm_list=("${!perm_counts[@]}")
echo "Permission variations for visible files and folders in $target_dir:"
printf "\n%-4s %-10s %-8s %-8s %-8s %-8s\n" "No." "Type" "User" "Group" "Other" "Count"
echo "-------------------------------------------------------------"
for i in "${!perm_list[@]}"; do
    perm="${perm_list[$i]}"
    count=${perm_counts[$perm]}
    type_char="${perm:0:1}"
    user_perm="${perm:1:3}"
    group_perm="${perm:4:3}"
    other_perm="${perm:7:3}"
    printf "%-4s %-10s %-8s %-8s %-8s %-8s\n" "$((i+1))" "$type_char" "$user_perm" "$group_perm" "$other_perm" "$count"
done

echo
read -p "Enter the number of a variation to export a list, or press Enter to exit: " sel

if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel >= 1 && sel <= ${#perm_list[@]} )); then
    chosen_perm="${perm_list[$((sel-1))]}"
    out_file="$output_dir/${now_ts}_show-rwx.txt"
    # Remove trailing newline
    printf "%s" "${perm_files[$chosen_perm]}" > "$out_file"
    echo "List of files/folders with '$chosen_perm' saved to: $out_file"
else
    echo "No export. Exiting."
fi