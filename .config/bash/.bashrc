#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null disable=SC2001,SC2002

# TODO: Hydro should show cmd duration (from ble.sh?)
# TODO: Hydro should show stashes
# TODO: Hydro should be async??

#region: [Early Init]
#

# Use XDG base dirs, or comment out to not.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Support an alternative BASH_HOME for some things, or comment out to not.
if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/bash" ]]; then
  BASH_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/bash"
fi

# Helper to source runcom files in bashrc.d.
function bashrc_d() {
  shopt -s nullglob
  local rc file ext
  # Loop thru .bashrc.d and source files that match the passed
  # in extension, excluding leading ~tilde files.
  for rc in "${BASH_HOME:-$HOME}"/.bashrc.d/*.*; do
    file="${rc##*/}"; ext=".${file#*.}"
    [[ "$file" != '~'* ]] || continue
    [[ "$ext" == "${1:-.bash}" ]] || continue
    source "$rc"
  done
  shopt -u nullglob
}

# Users can customize early-init activities with foo.pre.bash files. Skips ~tilde files.
bashrc_d .pre.bash

#
#endregion

#region: [Init]
#

# Initialize ble.sh for interactive shells. Do this near the beginning of .bashrc.
BLE_HOME="${BLE_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/blesh}"
if [[ -d "$BLE_HOME" ]] && [[ "${BASHPROFRC:-0}" -ne 1 ]]; then
  [[ $- == *i* ]] && source "$BLE_HOME/ble.sh" --noattach
else
  unset BLE_HOME
fi

#
#endregion

#region: [Path]
#

# Add common directories.
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Set up homebrew if the user didn't already in a .pre.bash file.
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brewcmd" ]] || continue
    eval "$("$brewcmd" shellenv)"
    break
  done
fi

# Add user directories.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#
#endregion

#region: [Environment]
#

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

#
#endregion

#region: [History]
#

shopt -s histappend       # Append to history, don't overwrite it.
HISTTIMEFORMAT='%F %T '   # Use standard ISO 8601 timestamp.
HISTSIZE=10000            # Remember the last x commands in memory during session
HISTFILESIZE=100000       # Start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups

# Keep the history file with data files, not configs.
if [[ -n "${XDG_DATA_HOME}" ]]; then
  [[ -d "${XDG_DATA_HOME}/bash" ]] || mkdir -p "${XDG_DATA_HOME}/bash"
  HISTFILE="${XDG_DATA_HOME}/bash/history"
fi

#
#endregion

#region: [Colors]
#

# Colorize man pages.
export LESS_TERMCAP_md=$'\E[01;34m'     # start bold
export LESS_TERMCAP_mb=$'\E[01;34m'     # start blink
export LESS_TERMCAP_so=$'\E[00;47;30m'  # start standout: white bg, black fg
export LESS_TERMCAP_us=$'\E[04;35m'     # start underline: underline magenta
export LESS_TERMCAP_se=$'\E[0m'         # end standout
export LESS_TERMCAP_ue=$'\E[0m'         # end underline
export LESS_TERMCAP_me=$'\E[0m'         # end bold/blink

# Set LS_COLORS using dircolors
if [[ -z "$LS_COLORS" ]]; then
  if type dircolors >/dev/null 2>&1; then
    eval "$(dircolors --sh)"
  elif type gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors --sh)"
  fi
fi

# Fallback, even for BSD systems
export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"

# For BSD systems, set LSCOLORS instead.
if ! type dircolors >/dev/null 2>&1; then
  export CLICOLOR=1
  export LSCOLORS="exfxcxdxbxGxDxabagacad"
fi

#
#endregion

#region: [Completion]
#

if [ -r "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh" ]; then
  . "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh"
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

#
#endregion

#region: [Editor]
#

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

#
#endregion

#region: [File System]
#

# Config for dirstack, globbing, special dirs, and general file system nav.
# CDPATH="."
set -o noclobber                   # Prevent file overwrite on stdout redirection; use `>|` to force
set -o pipefail                    # Return the rightmost non-zero code for piped commands if any fail
shopt -s checkwinsize 2> /dev/null # Update window size after every command
shopt -s cmdhist 2> /dev/null      # Save multi-line commands as one command
shopt -s extglob 2> /dev/null      # Turn on extended globbing
shopt -s globstar 2> /dev/null     # Turn on recursive globbing (enables ** to recurse all directories)
shopt -s nocaseglob 2> /dev/null   # Case-insensitive globbing (used in pathname expansion)
shopt -s autocd 2> /dev/null       # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null     # Correct spelling errors during tab-completion
# shopt -s cdspell 2> /dev/null      # Correct spelling errors in arguments supplied to cd
# shopt -s cdable_vars 2> /dev/null  # CD across the filesystem as if you're in that dir

#
#endregion

#region: [Aliases]
#

# ls shorthand.
alias ls='ls --color=auto'
alias la='ls -lah'
alias ll='ls -lh'
alias l='ls -F'
alias ldot='ls -ld .*'

# Single character shortcuts - be sparing!
alias _='sudo'
alias h='history'
alias v='vim'
alias c='clear'

# Mask built-ins with better defaults.
alias ping='ping -c 5'
alias vi=vim
alias grep='grep --color=auto --exclude-dir={.git,.hg,.svn,.vscode}'

# Fix typos.
alias get=git
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# Navigate directories faster.
alias "dirh"="dirs -v"
alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."
alias "....."="cd ../../../.."

# Tell gpg to store its keyring as data.
if [[ -d "$XDG_DATA_HOME" ]]; then
  export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
  alias gpg='gpg --homedir "$GNUPGHOME"'
fi

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# find
alias fd='find . -type d -name '
alias ff='find . -type f -name '

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias unixepoch="date +%s"

# Safer way to rm.
if type safe-rm >/dev/null 2>&1; then
  alias rm='safe-rm'
  alias del='safe-rm'
fi

# Homebrew
alias brewup="brew update && brew upgrade && brew cleanup"

# dotfiles
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
alias dotf='cd "$DOTFILES"'
alias rcs='cd "${BASH_HOME:-$HOME}"'
alias bashrc='"${EDITOR:-vim}" "${BASH_HOME:-$HOME}/.bashrc"'
alias reload='source "${BASH_HOME:-$HOME}/.bashrc"'

# Quick way to get back to your initial working directory.
IWD="${IWD:-PWD}"
alias iwd='cd "$IWD"'

# Misc aliases.
alias myip="curl ifconfig.me"
alias nv=nvim
alias curry="xargs -I{}"  # printf '%s\n' foo bar baz | curry touch {}.txt
alias ppath='echo $PATH | tr ":" "\n"'
alias cls="clear && printf '\e[3J'"
alias bench="for i in {1..10}; do /usr/bin/time bash -ic 'echo -n'; done"

#
#endregion

#region: [Functions]
#

function func/exists() {
  declare -F -- "$1" >/dev/null 2>&1
}

# A basic calculator.
function test_exitcode() {
  [[ "$#" -ne 0 ]] && return $1 || return 0
}

# A basic calculator.
function calc() {
  bc -l <<< "$@"
}

# Check strings for boolean values.
function is_true() {
  case "${1,,}" in
    (t|y|true|yes|on|1) return 0 ;;
    (*) return 1 ;;
  esac
}

# Print 256 terminal color codes.
function colormap() {
  local i bg fg reset
  reset=$'\E[00m'
  for i in {0..255}; do
    fg=$'\E[38;5;'$i'm'
    bg=$'\E[48;5;'$i'm'
    printf "%s  %s" "$bg" "$reset"
    printf "${fg}%03d${reset} " "$i"
    (( i <= 15 && (i + 1)  % 8 == 0 )) && echo
    (( i > 15  && (i - 15) % 6 == 0 )) && echo
  done
}

# cd upward X directories.
function up() {
  local lvls cdstr
  lvls="${1:-1}"
  cdstr=".."
  while (( --lvls > 0 )); do
    cdstr+="/.."
  done
  cd "$cdstr" || return
}

# Extract all the things.
function extract() {
  case "$1" in
    *.tar.bz2)  tar xjf "$1"  ;;
    *.tar.gz)   tar xzf "$1"  ;;
    *.bz2)      bunzip2 "$1"  ;;
    *.gz)       gunzip "$1"   ;;
    *.tar.xz)   tar xJf "$1"  ;;
    *.xz)       unxz "$1"     ;;
    *.zip)      unzip "$1"    ;;
    *.7z)       7z x "$1"     ;;
    *)          echo "'$1' cannot be extracted via extract()" ;;
  esac
}

# Join strings with a delimiter.
function str/join() {
  local sep ret arg
  [[ $# -ne 0 ]] || return 1
  [[ $# -ne 1 ]] || return 0
  sep="$1"; shift
  ret="$1"; shift
  for arg; do ret+="${sep}${arg}"; done
  echo "$ret"
}

# Split strings on a delimiter.
function str/split() {
  local sep str
  [[ $# -ne 0 ]] || return 1
  sep=$(echo "$1" | sed 's/[]\/\\$*.^|[]/\\&/g')
  shift
  for str; do
    echo "$str" | sed "s/${sep}/\n/g"
  done
}

# Trims whitespace from start and end of string.
function str/trim() {
  local arg
  for arg; do
    echo "$str" | sed 's/^[ \t]*//;s/[ \t]*$//'
  done
}

# Convert to UPPERCASE string.
function str/upper() {
  local arg
  for arg; do
    echo "$arg" | tr '[:lower:]' '[:upper:]'
  done
}

# Convert to lowercase string.
function str/lower() {
  local arg
  for arg; do
    echo "$arg" | tr '[:upper:]' '[:lower:]'
  done
}

# Sum an array.
function arr/sum() {
  local i tot=0
  for i; do (( tot+=i )); done
  echo "$tot"
}

# Check if an element is in an array.
function arr/contains() {
  local arg find="$1"; shift
  for arg; do
    [[ "$find" == "$arg" ]] && return 0
  done
  return 1
}

# Get the index of an element is in an array.
function arr/index_of() {
  local arg find="$1" i=0; shift
  for arg; do
    if [[ "$find" == "$arg" ]]; then
      echo "$i"
      return
    fi
    ((i++))
  done
  return 1
}

#
#endregion

#region: [Prompt]
#

# Enable promptvars so that ${GITSTATUS_PROMPT} in PS1 is expanded.
shopt -s promptvars

function shorten_path() {
  local OPTIND OPTARG opt o_len
  while getopts "l:" flg; do
    case "$flg" in
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
if ! command -v gitstatus_start >/dev/null 2>&1; then
  if [[ -r "$REPO_HOME/romkatv/gitstatus/gitstatus.plugin.sh" ]]; then
    source "$REPO_HOME/romkatv/gitstatus/gitstatus.plugin.sh"
  fi
fi

if command -v gitstatus_start >/dev/null 2>&1; then
  # Start gitstatusd in the background.
  gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1
fi

function set_vcs_vars() {
  VCS_STATUS_RESULT="error"

  # Use gitstatus if it's available
  if func/exists gitstatus_query; then
    gitstatus_query "$@" || return 1
    if (( VCS_STATUS_NUM_STAGED + VCS_STATUS_NUM_UNSTAGED + VCS_STATUS_NUM_UNTRACKED > 0 )); then
      VCS_STATUS_IS_DIRTY=1
    else
      VCS_STATUS_IS_DIRTY=0
    fi
    return 0
  fi

  command -v git > /dev/null 2>&1 || return 1
  [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return 1

  VCS_STATUS_RESULT="ok-manual"
  VCS_STATUS_LOCAL_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null)"
  VCS_STATUS_COMMITS_AHEAD="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
  VCS_STATUS_COMMITS_BEHIND="$(git rev-list --count HEAD..@{upstream} 2>/dev/null)"
  VCS_STATUS_TAG="$(git describe --tags --exact-match HEAD 2>/dev/null)"
  VCS_STATUS_COMMIT="$(git rev-parse HEAD 2>/dev/null)"
  local gitstatus_porcelain="$(git status --porcelain 2>/dev/null)"
  [[ -n "$gitstatus_porcelain" ]] && VCS_STATUS_IS_DIRTY=1 || VCS_STATUS_IS_DIRTY=0
  VCS_STATUS_STASHES="$(git rev-list --walk-reflogs --count refs/stash 2>/dev/null || echo 0)"
}

# Fish-like path shortener: $HOME/.config/bash/.docs/cheatsheet => ~/.c/b/.d/cheatsheet
function prompt_hydro_short_path() {
  local dirname ancestor_path shortened_path
  local color_reset color_brblack color_bold_blue
  color_reset="\[\e[00m\]"
  color_darkgrey="\[\e[38;5;243m\]"
  color_bold_blue="\[\e[34;1m\]"
  shortened_path="$(shorten_path $PWD)"
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

#
#endregion

#region: [Utils]
#

# Cross-platform support for an 'open' command.
if ! type open >/dev/null 2>&1; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif type explorer.exe >/dev/null 2>&1; then
    alias open='explorer.exe'
  elif type xdg-open >/dev/null 2>&1; then
    alias open='xdg-open'
  fi
fi

# Cross-platform support for clipboard commands (clipcopy/clippaste).
if [[ "$OSTYPE" == darwin* ]]; then
  alias clipcopy='pbcopy'
  alias clippaste='pbpaste'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias clipcopy='tee > /dev/clipboard'
  alias clippaste='cat /dev/clipboard'
elif type clip.exe >/dev/null 2>&1 && type powershell.exe >/dev/null 2>&1; then
  alias clipcopy='clip.exe'
  alias clippaste='powershell.exe -noprofile -command Get-Clipboard'
elif [[ -n "$WAYLAND_DISPLAY" ]] && type wl-copy >/dev/null 2>&1 && type wl-paste >/dev/null 2>&1; then
  alias clipcopy='wl-copy'
  alias clippaste='wl-paste'
elif [[ -n "$DISPLAY" ]] && type xclip >/dev/null 2>&1; then
  alias clipcopy='xclip -selection clipboard -in'
  alias clippaste='xclip -selection clipboard -out'
elif [[ -n "$DISPLAY" ]] && type xsel >/dev/null 2>&1; then
  alias clipcopy='xsel --clipboard --input'
  alias clippaste='xsel --clipboard --output'
fi

# Enable z command.
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# Enable fzf bash integration.
# if type fzf >/dev/null 2>&1; then
#   eval "$(fzf --bash)"
# fi

# Enable atuin bash integration.
if type atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi

#
#endregion

#region: [Post]
#

# Users can add to bashrc with *.bash files in ~/.bashrc.d. Skips ~tilde files.
bashrc_d

# Pick a default theme.
if type starship >/dev/null 2>&1; then
  BASH_THEME="${BASH_THEME:-starship}"
else
  BASH_THEME="${BASH_THEME:-hydro}"
fi

# Set the prompt theme.
if [[ "$BASH_THEME" == "starship" ]]; then
  eval "$(starship init bash)"
elif [[ "$(type -t "prompt_${BASH_THEME}_setup")" == function ]]; then
  export PROMPT_COMMAND="prompt_${BASH_THEME}_setup;${PROMPT_COMMAND}"
else
  PS1='[\u@\h \W]\$ '
fi

# Clean up '$PATH'.
PATH="$(
  printf %s "$PATH" |
  awk -vRS=: -vORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }'
)"

# Attach ble.sh last.
[[ ${BLE_VERSION-} ]] && ble-attach

# Users can customize post-activities with foo.post.bash files. Skips ~tilde files.
bashrc_d .post.bash

# Success
true

#
#endregion
