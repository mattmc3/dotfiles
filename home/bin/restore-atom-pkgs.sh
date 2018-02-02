#!/usr/bin/env bash

function main() {
    command -v apm >/dev/null 2>&1 || { echo >&2 "apm not found."; exit 1; }

    restore_file="${1:-$PWD/apm-list.txt}"
    [[ -f "$restore_file" ]] || { echo >&2 "apm file not found: $restore_file"; exit 1; }

    echo "restoring atom apm packages..."
    lines=`cat "$restore_file"`
    for line in $lines ; do
        # the apm export has version numbers that packages-file does not need
        atom_pkg=`echo $line | awk -F'@' '{ print $1 }'`
        if [[ ! -d "$HOME/.atom/packages/$atom_pkg" ]]; then
            apm install $atom_pkg --compatible
        else
            echo "$atom_pkg package already installed"
        fi
    done
}
main $@
