#!/usr/bin/env bash

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings="$DOTFILES/settings"

rm -rf "$settings/home"
rm -rf "$settings/misc"
