#!/bin/zsh
export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}
[[ -e $ZDOTDIR/.zprofile ]] && . $ZDOTDIR/.zprofile

# Created by `pipx`
export PATH="$PATH:$HOME/.local/bin"
