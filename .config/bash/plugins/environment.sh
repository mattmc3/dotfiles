# shellcheck shell=bash

# Set locale.
export LANG="${LANG:-en_US.UTF-8}"
export TZ="${TZ:-America/New_York}"

# Set preferred editors, pagers, and launchers.
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"
export BROWSER="${BROWSER:-open}"

# Set flags for less command.
export LESS="-giMRSw -z-4"

# Reduce key delay.
export KEYTIMEOUT="${KEYTIMEOUT:-1}"
