#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pkgctrl="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
settings_file="$pkgctrl/Package Control.sublime-settings"

if [[ -f "$settings_file" ]] ; then
    echo "backing up Sublime Text extensions..."
    cp -f "$settings_file" .
else
    echo "Sublime Text not found... skipping..."
fi
