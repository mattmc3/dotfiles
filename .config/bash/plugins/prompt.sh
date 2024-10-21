# shellcheck shell=bash disable=SC2155 source=/dev/null

# TODO: Hydro should show cmd duration (from ble.sh?)
# TODO: Hydro should show stashes
# TODO: Hydro should be async??

HYDRO_COLOR_PROMPT="$(tput setaf 206)"
HYDRO_USE_GITSTATUS=${HYDRO_USE_GITSTATUS:-0}

# Enable promptvars so that ${GITSTATUS_PROMPT} in PS1 is expanded.
shopt -s promptvars

function shorten_path() {
  local OPTIND OPTARG opt o_len
  while getopts "l:" opt; do
    case "$opt" in
      l) o_len="${OPTARG}" ;;
      *) return 1  ;;
    esac
  done
  shift $(( OPTIND - 1 ))
  if [[ "${o_len:-1}" -gt 0 ]]; then
    echo "$1" | sed -E -e "s:${HOME}:~:" -e 's:([^/\.]{1,'"${o_len:-1}"'})[^/]*/:\1/:g'
  else
    basename "$1"
  fi
}

# Load gitstatus if available
if [[ $HYDRO_USE_GITSTATUS -eq 1 ]]; then
  # Start gitstatusd in the background.
  source "$REPO_HOME/romkatv/gitstatus/gitstatus.plugin.sh"
  gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1
fi

function set_vcs_vars() {
  VCS_STATUS_RESULT="error"
  command -v git > /dev/null 2>&1 || return 1
  [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return 1

  # Use gitstatus if it's available
  if [[ $HYDRO_USE_GITSTATUS -eq 1 ]]; then
    gitstatus_query || return 1
    if (( VCS_STATUS_NUM_STAGED + VCS_STATUS_NUM_UNSTAGED + VCS_STATUS_NUM_UNTRACKED > 0 )); then
      VCS_STATUS_IS_DIRTY=1
    else
      VCS_STATUS_IS_DIRTY=0
    fi
    return 0
  fi

  # Otherwise, do the git status calls ourself
  VCS_STATUS_RESULT="ok-manual"
  VCS_STATUS_LOCAL_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null)"
  VCS_STATUS_COMMITS_AHEAD="$(git rev-list --count '@{upstream}..HEAD' 2>/dev/null)"
  VCS_STATUS_COMMITS_BEHIND="$(git rev-list --count 'HEAD..@{upstream}' 2>/dev/null)"
  VCS_STATUS_TAG="$(git describe --tags --exact-match HEAD 2>/dev/null)"
  VCS_STATUS_COMMIT="$(git rev-parse HEAD 2>/dev/null)"
  local gitstatus_porcelain="$(git status --porcelain 2>/dev/null)"
  [[ -n "$gitstatus_porcelain" ]] && VCS_STATUS_IS_DIRTY=1 || VCS_STATUS_IS_DIRTY=0
  VCS_STATUS_STASHES="$(git rev-list --walk-reflogs --count refs/stash 2>/dev/null || echo 0)"
}

# Fish-like path shortener: $HOME/.config/bash/.docs/cheatsheet => ~/.c/b/.d/cheatsheet
function prompt_hydro_short_path() {
  local dirname ancestor_path shortened_path
  local color_reset color_darkgrey color_bold_blue
  color_reset="\[\e[00m\]"
  color_darkgrey="\[\e[38;5;243m\]"
  color_bold_blue="\[\e[34;1m\]"
  shortened_path="$(shorten_path "$PWD")"
  dirname="${shortened_path##*/}"
  [[ "$shortened_path" == */* ]] && ancestor_path="${shortened_path%/*}/"
  printf '%s' "${HYDRO_COLOR_SHORTENED_PWD:-$color_darkgrey}" "$ancestor_path" \
              "${HYDRO_COLOR_PWD:-$color_bold_blue}" "$dirname" "${color_reset}"
}

# Set the " main• ↑1 ↓2" part of the Hydro prompt.
function prompt_hydro_git_string() {
  local git_branch git_dirty git_behind git_ahead color_green

  # Fail fast.
  set_vcs_vars
  [[ "$VCS_STATUS_RESULT" == ok-* ]] || return 1

  # Set the git branch name.
  git_branch=" ${VCS_STATUS_LOCAL_BRANCH:-${VCS_STATUS_TAG:-${VCS_STATUS_COMMIT:0:8}}}"

  # Set ahead/behind string: ↑1 ↓2 (notice git gives the reverse order from what we want).
  # Helpful symbols: ⇕⇡⇣↑↓
  # shellcheck disable=SC2207
  if [[ "$VCS_STATUS_COMMITS_AHEAD" -gt 0 ]]; then
    git_ahead=" ${HYDRO_SYMBOL_GIT_AHEAD:-⇡}${VCS_STATUS_COMMITS_AHEAD}"
  fi
  if [[ "$VCS_STATUS_COMMITS_BEHIND" -gt 0 ]]; then
    git_behind=" ${HYDRO_SYMBOL_GIT_BEHIND:-⇣}${VCS_STATUS_COMMITS_BEHIND}"
  fi

  # Set the dirty symbol.
  if [[ "$VCS_STATUS_IS_DIRTY" -eq 1 ]]; then
    git_dirty="${HYDRO_SYMBOL_GIT_DIRTY:-•}"
  fi

  # Print the git part of the prompt.
  color_green="\[\e[32m\]"
  printf '%s' "${HYDRO_COLOR_GIT:-$color_green}" "${git_branch}" \
              "${git_dirty}" "${git_ahead}" "${git_behind}"
}

# Bash version of Hydro - https://github.com/jorgebucaran/hydro
# ~/p/hydro main• ↑1 ↓2 | 0 1 1 ❱
function prompt_hydro_setup() {
  local -a last_pipestatus=("${BLE_PIPESTATUS[@]:-${PIPESTATUS[@]}}")
  local prompt_error prompt_char

  color_red="\[\e[31m\]"
  color_magenta="\[\e[35m\]"
  color_reset="\[\e[00m\]"

  if [[ "${last_pipestatus[*]}" =~ [1-9] ]]; then
    prompt_error=" ${HYDRO_COLOR_ERROR:-$color_red}[${last_pipestatus[*]}]"
  fi
  prompt_char=" ${HYDRO_COLOR_PROMPT:-$color_magenta}${HYDRO_SYMBOL_PROMPT:-❱}"
  if [[ "${HYDRO_MULTILINE:-false}" != false ]]; then
    prompt_char="\n${prompt_char}"
  fi

  PS1=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    PS1+="(${VIRTUAL_ENV##*/}) "
  fi

  PS1+="$(prompt_hydro_short_path)$(prompt_hydro_git_string)${prompt_error}${prompt_char} ${color_reset}"
}

# A minimal bash prompt.
function prompt_minimal_setup() {
  PS1='[\u@\h \W]\$ '
}

# Set the prompt theme.
if [[ "$BASH_THEME" == "starship" ]]; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/bash.toml"
  eval "$(starship init bash)"
elif [[ "$(type -t "prompt_${BASH_THEME}_setup")" == function ]]; then
  export PROMPT_COMMAND="prompt_${BASH_THEME}_setup;${PROMPT_COMMAND}"
else
  PS1='[\u@\h \W]\$ '
fi
