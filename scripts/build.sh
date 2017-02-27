#!/usr/bin/env bash

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# source build.sh in modules
find $DOTFILES/modules -name "*build.sh" | while read file; do
    . $file
done

echo "dotfiles build done."
