# shellcheck shell=bash

# Enable fzf bash integration.
if type fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi
