# shellcheck shell=bash

# Enable fzf bash integration.
if type fzf >/dev/null 2>&1; then
  cached_eval fzf --bash
  #eval "$(fzf --bash)"
fi
