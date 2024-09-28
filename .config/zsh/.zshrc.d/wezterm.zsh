[[ "$TERM_PROGRAM" == "WezTerm" ]] || return 1

wezterm_sh="${REPO_HOME:-?}/wez/wezterm/assets/shell-integration/wezterm.sh"
if [[ ! -r $wezterm_sh ]]; then
  mkdir -p ${wezterm_sh:h}
  curl -fsSL https://raw.githubusercontent.com/wez/wezterm/main/assets/shell-integration/wezterm.sh -o $wezterm_sh
fi
source $wezterm_sh

function __wezterm_my_precmd() {
  __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh $ZSH_VERSION"
}

# Emit an OSC 1337 sequence to define vars that terminals like WezTerm/iTerm2 can use.
precmd_functions+=(__wezterm_my_precmd)
