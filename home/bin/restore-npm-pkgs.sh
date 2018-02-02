#!/usr/bin/env bash

function main() {
    restore_file="${1:-$PWD/npm-list.txt}"

    command -v npm >/dev/null 2>&1 || { echo >&2 "npm not found."; exit 1; }
    if [[ -f "$restore_file" ]]; then
        echo "restoring node.js packages..."
        # the npm export has version numbers that packages-file does not need
        cat "$restore_file" | awk 'NR>1{ print $2 }' | awk -F'@' '{ print $1 }' | xargs npm install -g
    else
        echo >&2 "npm pkg list file not found!"
        exit 1
    fi
}
main $@
