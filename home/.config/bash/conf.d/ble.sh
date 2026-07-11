# shellcheck shell=bash source=/dev/null

# Customizations for ble.sh, kept out of blesh/init.sh so that file can stay
# close to the stock blerc template. Sourced before ble-attach (see zzz.sh),
# so bleopt/ble-bind/ble-face are already available.
declare -F bleopt > /dev/null || return 0

# Visible bell.
ble-face vbell=
bleopt vbell_default_message=' ding '
bleopt edit_bell=vbell

# Prompt.
bleopt prompt_ps1_final="$(tput setaf 005)❯$(tput sgr0) "
bleopt prompt_ps1_transient=trim
bleopt prompt_rps1_transient='true'

# History.
bleopt history_share=1

# Completion.
bleopt complete_auto_complete=1
bleopt complete_menu_complete=1
bleopt complete_menu_filter=1
bleopt complete_menu_style=desc

# Color scheme and face overrides.
bleopt color_scheme=base16
ble-face auto_complete=fg=240                # fg=black,bg=silver
ble-face command_builtin=fg=teal
ble-face command_builtin_dot=fg=teal,bold
ble-face command_jobs=fg=teal,bold
ble-face menu_filter_input=none              # fg=black,bg=yellow
ble-face region_insert=none
ble-face region_match=none
ble-face region_target=none
ble-face syntax_command=fg=teal
ble-face syntax_error=fg=red,bold            # fg=white,bg=red

# Smart accept-line: submit whenever the buffer is syntactically complete,
# even if it already spans multiple lines. Otherwise insert a newline.
function ble/widget/blerc/accept-line-if-complete {
  if bash -n <<< "$_ble_edit_str" 2> /dev/null; then
    ble/widget/accept-line
  else
    ble/widget/insert-string $'\n'
  fi
}

# Vi keymap customizations.
function blerc/vim-load-hook-custom {
  bleopt keymap_vi_mode_show=
  bleopt keymap_vi_mode_string_nmap:=$'\e[1m-- NORMAL --\e[m'

  ble-bind -m vi_nmap --cursor 2
  ble-bind -m vi_imap --cursor 6

  ble-bind -m vi_imap -f 'C-m' blerc/accept-line-if-complete
  ble-bind -m vi_imap -f 'RET' blerc/accept-line-if-complete
  ble-bind -m vi_nmap -f 'C-m' blerc/accept-line-if-complete
  ble-bind -m vi_nmap -f 'RET' blerc/accept-line-if-complete
}
blehook/eval-after-load keymap_vi blerc/vim-load-hook-custom
