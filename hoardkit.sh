#!/bin/bash

MODULES_DIR="$(dirname "$0")/modules"

make_modules_executable() {
    for script in "$MODULES_DIR"/*.sh; do
        [ -f "$script" ] && chmod +x "$script"
    done
}

show_modules() {
    echo "Available modules:"
    for script in "$MODULES_DIR"/*.sh; do
        [ -f "$script" ] && echo "  $(basename "$script" .sh)"
    done
    echo
}

if [ -z "$1" ]; then
    make_modules_executable
    show_modules
    echo "Usage: $0 <module> [args...]"
    exit 1
fi

MODULE_SCRIPT="$MODULES_DIR/$1.sh"

if [ ! -f "$MODULE_SCRIPT" ]; then
    echo "Module '$1' not found."
    exit 1
fi

shift

display_loading() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\\'
    echo -n "Loading "
    while kill -0 $pid 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\b${spinstr:$i:1}"
            sleep $delay
        done
    done
    echo -ne "\bDone\n"
}

(bash "$MODULE_SCRIPT" "$@") &
module_pid=$!
display_loading $module_pid
wait $module_pid