#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

export ZDOTDIR=~/.zsh
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
export XDG_RUNTIME_DIR=~/.xdg

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s $ZDOTDIR/.zprofile ]]; then
  source $ZDOTDIR/.zprofile
fi
