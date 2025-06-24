# shellcheck shell=bash

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Use vi editing mode
set -o vi

# Do ble.sh things from here on.
[ -n "$BLE_VERSION" ] || return 1

# https://github.com/akinomyoga/ble.sh/wiki/Vi-(Vim)-editing-mode
#bleopt keymap_vi_mode_show=
bleopt keymap_vi_mode_string_nmap:=$'\e[1m-- NORMAL --\e[m'

# Strip leading dollar signs. Fixes commands pasted from markdown.
# shellcheck disable=SC2016
ble/function#advice around ble/widget/default/accept-line '
  if [[ "${_ble_edit_str:0:2}" == "$ " ]]; then
    ble/widget/beginning-of-logical-line
    ble/widget/insert-string "${_ble_edit_str:2}"
    ble/widget/kill-forward-logical-line
  fi
  ble/function#advice/do
'
