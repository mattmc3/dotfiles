#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null disable=SC2002

#
#region: Init
#

# Users can customize.
[[ -r "$BASH_CONFIG_DIR/.bashrc.pre" ]] && . "$BASH_CONFIG_DIR/.bashrc.pre"

# Set XDG base dirs.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Set Bash dirs.
BASH_CONFIG_DIR="${BASH_CONFIG_DIR:-$XDG_CONFIG_HOME/bash}"
BASH_DATA_DIR="${BASH_DATA_DIR:-$XDG_DATA_HOME/bash}"
BASH_CACHE_DIR="${BASH_CACHE_DIR:-$XDG_CACHE_HOME/bash}"
mkdir -p "$BASH_CONFIG_DIR" "$BASH_DATA_DIR" "$BASH_CACHE_DIR"

# Initialize ble.sh for interactive shells early in config.
BLE_HOME="${BLE_HOME:-$XDG_DATA_HOME/blesh}"
[[ $- == *i* ]] && source "$BLE_HOME/ble.sh" --noattach

#
#endregion
#region: Path
#

# Add common directories.
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Set up homebrew.
for brewcmd in /opt/homebrew/bin/brew \
               /usr/local/bin/brew
do
  [[ -x "$brewcmd" ]] || continue
  eval "$("$brewcmd" shellenv)"
  break
done

# Add user directories.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#
#endregion
#region: Environment
#

# Locale
export LANG="${LANG:-en_US.UTF-8}"
export TZ="${TZ:-America/New_York}"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="${REMOTE_EDITOR:-vi}"
else
  export EDITOR="${EDITOR:-vim}"
fi
export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"

# Set browser.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER=${BROWSER:-open}
fi

# Set the default less options.
export LESS="-giMRSw -z-4"

# Reduce key delay
export KEYTIMEOUT="${KEYTIMEOUT:-1}"

#
#endregion
#region: History
#

shopt -s histappend       # Append to history, don't overwrite it.
HISTTIMEFORMAT='%F %T '   # Use standard ISO 8601 timestamp.
HISTSIZE=10000            # Remember the last x commands in memory during session
HISTFILESIZE=100000       # Start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups

# Keep the history file with data files, not configs.
HISTFILE="$BASH_DATA_DIR/history"

#
#endregion
#region: Colors
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
  if type dircolors &>/dev/null 2>&1; then
    eval "$(dircolors --sh)"
  elif type gdircolors &>/dev/null 2>&1; then
    eval "$(gdircolors --sh)"
  fi
fi

# Fallback, even for BSD systems
export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"

# For BSD systems, set LSCOLORS.
if ! type dircolors &>/dev/null 2>&1; then
  export CLICOLOR=1
  export LSCOLORS="exfxcxdxbxGxDxabagacad"
fi

#
#endregion
#region: Completion
#

# HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/opt/homebrew}
# [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

#
#endregion
#region: File System
#

# Config for dirstack, globbing, special dirs, and general file system nav.
CDPATH="."
set -o noclobber                 # Prevent file overwrite on stdout redirection; use `>|` to force
shopt -s checkwinsize            # Update window size after every command
shopt -s cmdhist                 # Save multi-line commands as one command
shopt -s extglob 2> /dev/null    # Turn on extended globbing
shopt -s globstar 2> /dev/null   # Turn on recursive globbing (enables ** to recurse all directories)
shopt -s nocaseglob              # Case-insensitive globbing (used in pathname expansion)
shopt -s autocd 2> /dev/null     # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null   # Correct spelling errors during tab-completion
shopt -s cdspell 2> /dev/null    # Correct spelling errors in arguments supplied to cd
shopt -s cdable_vars             # CD across the filesystem as if you're in that dir

# dotfiles
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
alias dotf='cd "$DOTFILES"'
alias rcs='cd "$BASH_CONFIG_DIR"'
alias bashrc='"${EDITOR:-vim}" "${BASH_CONFIG_DIR:-$HOME}/.bashrc"'
alias reload='source "${BASH_CONFIG_DIR:-$HOME}/.bashrc"'

# Quick way to get back to your initial working directory.
IWD="${IWD:-PWD}"
alias iwd='cd "$IWD"'

#
#endregion
#region: Aliases
#

# ls shorthand
alias ls='ls --color=auto'
alias la='ls -lah'
alias ll='ls -lh'
alias l='ls -F'
alias ldot='ls -ld .*'

# single character shortcuts - be sparing!
alias _='sudo'
alias h='history'
alias v='vim'
alias c='clear'

# mask built-ins with better defaults
alias ping='ping -c 5'
alias vi=vim
alias nv=nvim
alias grep='grep --color=auto --exclude-dir={.git,.hg,.svn,.vscode}'

# fix typos
alias get=git
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# gpg needs to store its keyring in XDG locations
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
alias gpg='gpg --homedir "$GNUPGHOME"'

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
if type safe-rm &>/dev/null; then
  alias rm='safe-rm'
  alias del='safe-rm'
fi

# Homebrew
alias brewup="brew update && brew upgrade && brew cleanup"

# Misc aliases.
alias ppath='echo $PATH | tr ":" "\n"'
alias cls="clear && printf '\e[3J'"
alias bench="for i in {1..10}; do /usr/bin/time bash -ic 'echo -n'; done"

#
#endregion
#region: Functions
#

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

# Emit an OSC 1337 sequence to set vars your terminal app (WezTerm) can use.
function set_terminal_var() {
  hash base64 2>/dev/null || return 1
  local val
  val="$(echo -n "$2" | base64)"

  # https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it
  # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
  if [[ -n "${TMUX}" ]] ; then
    printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$1" "$val"
  else
    printf "\033]1337;SetUserVar=%s=%s\007" "$1" "$val"
  fi
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

#
#endregion
#region: Prompt
#

function prompt_hydro_git_string() {
  local git git_branch git_dirty git_behind git_ahead color_reset
  local -a git_behind_ahead_counts

  # fail fast
  git="${HYDRO_GIT_COMMAND:-git}"
  type -p "$git" > /dev/null 2>&1 || return 1
  [ -d .git ] || "$git" rev-parse --is-inside-work-tree > /dev/null 2>&1 || return

  # Set hydro vars.
  color_reset="\[\e[0m\]"
  HYDRO_SYMBOL_GIT_DIRTY="${HYDRO_SYMBOL_GIT_DIRTY:-•}"
  HYDRO_SYMBOL_GIT_AHEAD="${HYDRO_SYMBOL_GIT_AHEAD:-↑}"
  HYDRO_SYMBOL_GIT_BEHIND="${HYDRO_SYMBOL_GIT_BEHIND:-↓}"
  HYDRO_COLOR_GIT="${HYDRO_COLOR_GIT:-\[\e[32;1m\]}" # 32-green

  # Set the git branch name.
  git_branch="$("$git" symbolic-ref --short HEAD)"

  # Set ahead/behind string: ↑1 ↓2 (notice git gives the reverse order from what we want)
  git_behind_ahead_counts=($("$git" rev-list --count --left-right @{upstream}...@ 2>/dev/null))
  if [[ ${git_behind_ahead_counts[0]} -gt 0 ]]; then
    git_behind=" ${HYDRO_SYMBOL_GIT_BEHIND}${git_behind_ahead_counts[0]}"
  fi
  if [[ ${git_behind_ahead_counts[1]} -gt 0 ]]; then
    git_ahead=" ${HYDRO_SYMBOL_GIT_AHEAD}${git_behind_ahead_counts[1]}"
  fi

  # Set the dirty symbol.
  if [[ -n "$("$git" status --porcelain 2>/dev/null)" ]]; then
    git_dirty="$HYDRO_SYMBOL_GIT_DIRTY"
  fi

  # Print the git part of the prompt
  echo -n "${HYDRO_COLOR_GIT}${git_branch}${git_dirty}${git_ahead}${git_behind}${color_reset}"
}

function prompt_hydro_setup() {
  LAST_EXIT_STATUS="$?"  # Must be first!

  local git_prompt

  HYDRO_SYMBOL_PROMPT="${HYDRO_SYMBOL_PROMPT:-❱}"
  HYDRO_MULTILINE="${HYDRO_MULTILINE:-false}"
  #HYDRO_CMD_DURATION_THRESHOLD="${HYDRO_CMD_DURATION_THRESHOLD:-1000}"
  HYDRO_COLOR_PWD="${HYDRO_COLOR_PWD:-\[\e[34;1m\]}"           # 34-blue
  HYDRO_COLOR_ERROR="${HYDRO_COLOR_ERROR:-\[\e[31;1m\]}"       # 31-red
  HYDRO_COLOR_PROMPT="${HYDRO_COLOR_PROMPT:-\[\e[35;1m\]}"     # 35-magenta
  HYDRO_COLOR_DURATION="${HYDRO_COLOR_DURATION:-\[\e[33;1m\]}" # 33-yellow

  # Color codes for easy prompt building
  COLOR_DIVIDER="\[\e[30;1m\]"
  COLOR_CMDCOUNT="\[\e[34;1m\]"
  COLOR_USERNAME="\[\e[34;1m\]"
  COLOR_USERHOSTAT="\[\e[34;1m\]"
  COLOR_HOSTNAME="\[\e[34;1m\]"
  COLOR_GITBRANCH="\[\e[33;1m\]"
  COLOR_VENV="\[\e[33;1m\]"
  COLOR_GREEN="\[\e[32;1m\]"
  COLOR_OK="\[\e[32;1m\]"
  COLOR_ERR="\[\e[31;1m\]"
  COLOR_NONE="\[\e[0m\]"

  # Change the path color based on return value.
  if [[ "$LAST_EXIT_STATUS" -eq 0 ]]; then
    PATH_COLOR=${COLOR_OK}
  else
    PATH_COLOR=${COLOR_ERR}
  fi

  # Set the PS1 to be "[commandcount:workingdirectory:gitinfo"
  PS1="${COLOR_DIVIDER}[${COLOR_CMDCOUNT}\#:${PATH_COLOR}\w"
  git_prompt="$(prompt_hydro_git_string)"
  [[ -n "$git_prompt" ]] && PS1="${PS1}:${git_prompt}"

  # Add Python VirtualEnv portion of the prompt, this adds ":venvname"
  if ! test -z "$VIRTUAL_ENV" ; then
    PS1="${PS1}:${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${COLOR_DIVIDER}"
  fi
  # Close out the prompt, this adds "]\n[username@hostname] "
  PS1="${PS1}${COLOR_DIVIDER}]\n${COLOR_DIVIDER}[${COLOR_USERNAME}\u${COLOR_USERHOSTAT}@${COLOR_HOSTNAME}\h${COLOR_DIVIDER}] ${HYDRO_COLOR_PROMPT}${HYDRO_SYMBOL_PROMPT}${COLOR_NONE} "
}

# starship
if type starship2 &>/dev/null; then
  eval "$(starship init bash)"
else
  # Tell Bash to set the hydro prompt
  export PROMPT_COMMAND="prompt_hydro_setup;${PROMPT_COMMAND}"
fi

#
#endregion
#region: Utilities
#

# Cross-platform support for an 'open' command.
if ! type open &>/dev/null; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif type explorer.exe &>/dev/null; then
    alias open='explorer.exe'
  elif type xdg-open &>/dev/null; then
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
elif type clip.exe &>/dev/null && type powershell.exe &>/dev/null; then
  alias clipcopy='clip.exe'
  alias clippaste='powershell.exe -noprofile -command Get-Clipboard'
elif [[ -n "$WAYLAND_DISPLAY" ]] && type wl-copy &>/dev/null && type wl-paste &>/dev/null; then
  alias clipcopy='wl-copy'
  alias clippaste='wl-paste'
elif [[ -n "$DISPLAY" ]] && type xclip &>/dev/null; then
  alias clipcopy='xclip -selection clipboard -in'
  alias clippaste='xclip -selection clipboard -out'
elif [[ -n "$DISPLAY" ]] && type xsel &>/dev/null; then
  alias clipcopy='xsel --clipboard --input'
  alias clippaste='xsel --clipboard --output'
fi

# Enable z command.
if type zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# Enable fzf bash integration.
if type fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

#
#endregion
#region: Plugins
#

plugins=(
  editor
  macos
)
for _plugin in ${plugins[@]}; do
  source "$BASH_CONFIG_DIR/plugins/${_plugin}.sh"
done
unset _plugin

#
#endregion
#region: Post
#

# Set vars that terminals like WezTerm/iTerm2 can use.
if [[ -n "$TERM_PROGRAM" ]]; then
  set_terminal_var "TERM_CURRENT_SHELL" "bash $BASH_VERSION"
fi

# Users can customize.
[[ -r "$BASH_CONFIG_DIR/.bashrc.post" ]] && . "$BASH_CONFIG_DIR/.bashrc.post"

# Clean up '$PATH'.
PATH="$(
  printf %s "$PATH" |
  awk -vRS=: -vORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }'
)"

# Attach ble.sh last.
[[ ${BLE_VERSION-} ]] && ble-attach

# Success
true

#
#endregion
