#!/bin/bash

timestamp=$(date +"%Y%m%d%H%M%S")

repo_dir="$(dirname "$(dirname "$(realpath "$0")")")"
default_output_dir="$repo_dir/output"

target_dir="${1:-.}"

output_dir="${2:-$default_output_dir}"

mkdir -p "$output_dir"

output_file="$output_dir/find-dots_$timestamp.txt"

find "$target_dir" -mindepth 1 -name ".*" >> "$output_file"

echo "Hidden files and directories list saved to: $output_file"
