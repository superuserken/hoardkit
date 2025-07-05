#!/bin/bash

MODULES_DIR="$(dirname "$0")/modules"

echo "Available modules:"
for script in "$MODULES_DIR"/*.sh; do
    [ -f "$script" ] && echo "  $(basename "$script" .sh)"
done

echo

if [ -z "$1" ]; then
    echo "Usage: $0 <module> [args...]"
    exit 1
fi

MODULE_SCRIPT="$MODULES_DIR/$1.sh"

if [ ! -f "$MODULE_SCRIPT" ]; then
    echo "Module '$1' not found."
    exit 1
fi

shift
bash "$MODULE_SCRIPT" "$@"