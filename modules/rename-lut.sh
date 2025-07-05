#!/bin/bash

echo "Choose a renaming option:"
echo "1) lowercase"
echo "2) UPPERCASE"
echo "3) Title Case"
read -p "Enter your choice [1-3]: " choice

to_title_case() {
    echo "$1" | sed -E 's/(^|[^[:alpha:]])([[:alpha:]])/\1\u\2/g'
}

case "$choice" in
    1)
        transform_type="lower"
        ;;
    2)
        transform_type="upper"
        ;;
    3)
        transform_type="title"
        ;;
    *)
        echo "Invalid choice. Run the script again."
        exit 1
        ;;
esac

target_dir="${1:-.}"

if [[ ! -d "$target_dir" ]]; then
    echo "Directory '$target_dir' does not exist."
    exit 1
fi

shopt -s nullglob
for item in "$target_dir"/*; do
    base_name=$(basename "$item")

    case "$transform_type" in
        lower)
            new_name=$(echo "$base_name" | tr '[:upper:]' '[:lower:]')
            ;;
        upper)
            new_name=$(echo "$base_name" | tr '[:lower:]' '[:upper:]')
            ;;
        title)
            new_name=$(to_title_case "$base_name")
            ;;
    esac

    if [[ "$base_name" != "$new_name" ]]; then
        src="$item"
        dst="$target_dir/$new_name"

        if [[ -e "$dst" ]]; then
            echo "Skipping '$base_name' -> '$new_name' (target exists)"
        else
            echo "Renaming '$base_name' -> '$new_name'"
            mv -- "$src" "$dst"
        fi
    fi
done