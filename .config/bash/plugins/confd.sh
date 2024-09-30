# shellcheck shell=bash

# Load every script in conf.d
shopt -s nullglob
for _rc in "$BASH_HOME"/conf.d/*.sh; do
  source "$_rc"
done
shopt -u nullglob
unset _rc
