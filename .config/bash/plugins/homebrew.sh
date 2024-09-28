# shellcheck shell=bash

[ -d /opt/homebrew/bin ] || return 1

# Add common directories.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Set up homebrew if the user didn't already in a .pre.bash file.
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brewcmd" ]] || continue
    eval "$("$brewcmd" shellenv)"
    break
  done
fi

# Add user directories.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
