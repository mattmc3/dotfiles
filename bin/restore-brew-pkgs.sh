#!/usr/bin/env bash

function main() {
    command -v brew >/dev/null 2>&1 || { echo >&2 "brew not found."; exit 1; }

    echo "restoring brew packages..."
    (brew bundle)
}
main $@
