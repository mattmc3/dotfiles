# shellcheck shell=bash

# Enable atuin bash integration.
if type atuin >/dev/null 2>&1; then
  # Disable up arrow with --disable-up-arrow.
  # Disabling up arrow means that we need to use C-r for search.
  eval "$(atuin init bash)"
fi
