# shellcheck shell=bash

#
# __init__: Run this first
#

#
# XDG
#

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_DATA_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

export BASH_HOME="$XDG_CONFIG_HOME/bash"

#
# Path
#

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -e "$brewcmd" ]]; then
    eval "$("$brewcmd" shellenv)"
    break
  fi
done

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#
# Repos
#

export REPO_HOME=$XDG_CACHE_HOME/bash/repos
mkdir -p "$REPO_HOME"

repos=(
  bash-it/bash-it
  akinomyoga/ble.sh
  wez/wezterm
)
for repo in "${repos[@]}"; do
  [ ! -d "$REPO_HOME/$repo" ] || continue
  git clone --depth 1 --recurse-submodules --shallow-submodules \
    "https://github.com/$repo" "$REPO_HOME/$repo"
done

# Build ble.sh
BLE_HOME="$XDG_DATA_HOME/blesh"
if [ ! -d "$BLE_HOME" ]; then
  make -C "$REPO_HOME/akinomyoga/ble.sh" install PREFIX=~/.local
fi
