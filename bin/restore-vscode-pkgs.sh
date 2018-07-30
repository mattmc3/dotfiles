#!/usr/bin/env bash

function main() {
    command -v code >/dev/null 2>&1 || { echo >&2 "vscode not found."; exit 1; }

    restore_file="${1:-$PWD/vscode-extensions.txt}"
    [[ -f "$restore_file" ]] || { echo >&2 "vscode extensions file not found: $restore_file"; exit 1; }

    echo "restoring vscode packages..."
    cat "$restore_file" | xargs -L 1 code --install-extension
}
main $@
