#!/usr/bin/env bash

#
# Utilities
#

# Open
if ! command -v open >/dev/null; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  else
    alias open='xdg-open'
  fi
fi

eval "$(zoxide init bash)"
eval "$(fzf --bash)"
