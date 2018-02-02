#!/usr/bin/env bash

function main() {
    command -v code >/dev/null 2>&1 || { echo >&2 "gem not found."; exit 1; }

    restore_file="${1:-$PWD/gemlist.txt}"
    [[ -f "$restore_file" ]] || { echo >&2 "gem list file not found: $restore_file"; exit 1; }

    echo "restoring ruby gems... $restore_file"
    cat "$restore_file" | awk '{ print $1 }' | xargs gem install --conservative
}
main $@
