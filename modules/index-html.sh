#!/bin/bash

if [ "$1" = "-h" ]; then
    show_hidden=true
    shift
else
    show_hidden=false
fi

target_dir="${1:-.}"
now_ts=$(date +"%Y%m%d%H%M%S")
repo_dir="$(dirname "$(dirname "$(realpath "$0")")")"
default_output_file="$repo_dir/output/${now_ts}_index-html.html"
output_file="${2:-$default_output_file}"

escape_html() {
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'\''/\&#39;/g'
}

generate_index() {
    local dir="$1"
    local rel_path="$2"
    echo "<ul>"

    if $show_hidden; then
        shopt -s dotglob nullglob
        entries=("$dir"/*)
        shopt -u dotglob nullglob
    else
        shopt -s nullglob
        entries=("$dir"/*)
        shopt -u nullglob
    fi

    for entry in "${entries[@]}"; do
        [ -e "$entry" ] || continue
        name="$(basename "$entry")"
        esc_name="$(echo "$name" | escape_html)"
        path="$rel_path/$name"
        if [ -d "$entry" ]; then
            echo "  <li><strong>$esc_name/</strong>"
            generate_index "$entry" "$path"
            echo "  </li>"
        else
            size=$(stat -c%s "$entry" 2>/dev/null || stat -f%z "$entry")
            echo "  <li><a href=\"$path\">$esc_name</a> ($size bytes)</li>"
        fi
    done
    echo "</ul>"
}

size_bytes=$(du -sb "$target_dir" | awk '{print $1}')
size_human=$(du -sh "$target_dir" | awk '{print $1}')
size_disk_bytes=$(du -sB1 "$target_dir" | awk '{print $1}')
size_disk_human=$(du -sh "$target_dir" | awk '{print $1}')

file_count=$(find "$target_dir" -type f | wc -l)
dir_count=$(find "$target_dir" -type d | wc -l)
total_count=$((file_count + dir_count - 1))

echo "<html><head><meta charset=\"UTF-8\"><title>Index of $target_dir</title></head><body>" > "$output_file"
echo "<h1>Index of $target_dir</h1>" >> "$output_file"
echo "<p><strong>Size:</strong> $size_human ($size_bytes bytes)<br>" >> "$output_file"
echo "<strong>Size on Disk:</strong> $size_disk_human ($size_disk_bytes bytes)<br>" >> "$output_file"
echo "<strong>Content:</strong> ${total_count} items (${file_count} files, $((dir_count - 1)) folders)</p>" >> "$output_file"

generate_index "$target_dir" "$(basename "$target_dir")" >> "$output_file"

echo "</body></html>" >> "$output_file"
echo "HTML index created at: $output_file"