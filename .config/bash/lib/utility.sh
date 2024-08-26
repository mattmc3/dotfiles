# shellcheck shell=bash source=/dev/null

#
# Utilities
#

# Open
if ! command -v open >/dev/null; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  else
    alias open='xdg-open'
  fi
fi

# WezTerm
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  if [[ -r "$REPO_HOME/wez/wezterm/assets/shell-integration/wezterm.sh" ]]; then
    source "$REPO_HOME/wez/wezterm/assets/shell-integration/wezterm.sh"
    __wezterm_set_user_var "WEZTERM_CURRENT_SHELL" "bash $BASH_VERSION"
  fi
fi

eval "$(zoxide init bash)"
eval "$(fzf --bash)"
