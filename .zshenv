#!/bin/zsh
export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}
[[ -e $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
