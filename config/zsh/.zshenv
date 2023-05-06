#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

export ZDOTDIR=~/.config/zsh
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s $ZDOTDIR/.zprofile ]]; then
  source $ZDOTDIR/.zprofile
fi
