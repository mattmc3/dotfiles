#!/usr/bin/env zsh

if [[ $# -ne 3 ]]; then
  echo "Usage: $(basename $0) <hist1> <hist2> <output>" >&2
  exit 1
fi

HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS

HISTFILE="$3"

builtin fc -R -I "$1"
builtin fc -R -I "$2"

builtin fc -W "$HISTFILE"

echo "Merged to $HISTFILE ($(wc -l < "$HISTFILE") lines)"

