[[ -n "$BLE_VERSION" ]] || return 1

# Default commands
: ${MAGIC_ENTER_GIT_COMMAND:="git status -sb ."} # run when in a git repository
: ${MAGIC_ENTER_OTHER_COMMAND:="ls ."}           # run anywhere else

# This can be changed to handle all manner of magic-commands.
function ble/widget/blerc/magic-enter-command {
  # In a git directory, run a git command. Otherwise, run other command.
  local magic_cmd
  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    magic_cmd="$MAGIC_ENTER_GIT_COMMAND"
  else
    magic_cmd="$MAGIC_ENTER_OTHER_COMMAND"
  fi

  # Run the command magically.
  ble/widget/execute-command "$magic_cmd"

  # Or, run the command more explicitly.
  # ble/widget/insert-string "$magic_cmd"
  # ble/widget/accept-line
}

function ble/widget/blerc/magic-enter {
  # If no command is given, run magic-enter-command. Otherwise, run the
  # ble.sh default binding for C-m/RET.
  if [[ ! $_ble_edit_str ]]; then
    ble/widget/blerc/magic-enter-command
  else
    ble/widget/accept-single-line-or-newline
  fi
}
ble-bind -f C-m blerc/magic-enter    # for traditional keyboard protocol
ble-bind -f RET blerc/magic-enter    # for advanced keyboard protocol

function ble/widget/blerc/fancy-ctrl-z {
  local running_jobs="$(jobs | wc -l | xargs)"
  if [[ ! $_ble_edit_str ]] && [[ "$running_jobs" -gt 0 ]]; then
    ble/widget/insert-string "fg"
    ble/widget/accept-line
  else
    ble/widget/insert-string "echo :: $_ble_edit_str :: $running_jobs"
    ble/widget/accept-line
    #ble/widget/vi-editing-mode  # default
  fi
}
ble-bind -m emacs -f C-z blerc/fancy-ctrl-z
