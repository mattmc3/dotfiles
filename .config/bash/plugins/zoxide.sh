# shellcheck shell=bash

# Enable z command.
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi
