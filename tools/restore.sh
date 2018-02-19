#!/usr/bin/env bash

function main() {
    local root="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../misc" && pwd )"
    find "$root" -type f -name 'restore*.sh' -exec {} \;
}
main
