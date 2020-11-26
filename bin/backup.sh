#!/usr/bin/env bash

thisdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$thisdir"/..

backup_dir=./_bak/home_$(date +"%Y%m%d_%H%M%S")
mkdir -p "$backup_dir"
echo "backing up existing dotfiles from your home to ${backup_dir}..."
rsync -aL --include-from="$thisdir/backup.rsync" "$HOME/" "$backup_dir"
