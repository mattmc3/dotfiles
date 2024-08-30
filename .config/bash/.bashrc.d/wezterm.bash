[[ "$TERM_PROGRAM" == "WezTerm" ]] || return 1
if [[ -r "${REPO_HOME:?}/wez/wezterm/assets/shell-integration/wezterm.sh" ]]; then
  source "${REPO_HOME:?}/wez/wezterm/assets/shell-integration/wezterm.sh"
else
  return 1
fi

function __wezterm_my_precmd() {
  __wezterm_set_user_var "TERM_CURRENT_SHELL" "bash $BASH_VERSION"
}

# Emit an OSC 1337 sequence to define vars that terminals like WezTerm/iTerm2 can use.
if [[ -n "$BLE_VERSION" ]]; then
  blehook PRECMD+=__wezterm_my_precmd
else
  precmd_functions+=(__wezterm_my_precmd)
fi
