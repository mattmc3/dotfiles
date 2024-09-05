#!/usr/bin/env zsh
# shellcheck shell=bash source=/dev/null disable=SC2001,SC2002

#region: [Init]
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Fish-like dirs
__zsh_config_dir="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
__zsh_user_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
__zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$__zsh_config_dir" "$__zsh_user_data_dir" "$__zsh_cache_dir"

# Set critical Zsh options
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS

# Helper to source runcom files in zshrc.d.
function zshrc_d {
  setopt NULL_GLOB
  local rc file ext
  # Loop thru .zshrc.d and source files that match the passed
  # in extension, excluding leading ~tilde files.
  for rc in "${ZDOTDIR:-$HOME}"/.zshrc.d/*.*; do
    file="${rc##*/}"; ext=".${file#*.}"
    [[ "$file" != '~'* ]] || continue
    [[ "$ext" == "${1:-.zsh}" ]] || continue
    source "$rc"
  done
  unsetopt NULL_GLOB
}

# zstyles
[[ -r ${ZDOTDIR:-$HOME}/.zstyle ]] && . ${ZDOTDIR:-$HOME}/.zstyle

# Users can customize early-init activities with foo.pre.zsh files. Skips ~tilde files.
zshrc_d .pre.zsh

#
#endregion

#region: [Path]
#

# Ensure path arrays do not contain duplicates.
# shellcheck disable=SC2034
typeset -gU cdpath fpath mailpath path

# Add common directories.
path=(
  /usr/local/bin
  /usr/local/sbin
  $path
)

# Set up homebrew if the user didn't already in a .pre.zsh file.
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brewcmd" ]] || continue
    eval "$("$brewcmd" shellenv)"
    break
  done
fi

# Add user directories.
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "${path[@]}"
)

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

# Set history options.
setopt bang_hist               # Treat the '!' character specially during expansion.
setopt extended_history        # Write the history file in the ':start:elapsed;command' format.
setopt hist_expire_dups_first  # Expire a duplicate event first when trimming history.
setopt hist_find_no_dups       # Do not display a previously found event.
setopt hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_dups        # Do not record an event that was just recorded again.
setopt hist_ignore_space       # Do not record an event starting with a space.
setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
setopt hist_save_no_dups       # Do not write a duplicate event to the history file.
setopt hist_verify             # Do not execute immediately upon history expansion.
setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
setopt share_history           # Share history between all sessions.
setopt NO_hist_beep            # Don't beep when accessing non-existent history.

# Set history vars.
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
mkdir -p "${HISTFILE:h}"  # ensure directory exists

# shellcheck disable=SC2034
SAVEHIST=100000           # history file entries
HISTSIZE=20000            # session entries

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

# Standard style used by default for 'list-colors'
LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}

#
#endregion

#region: [Completion]
#

# Set completion options.
setopt always_to_end        # Move cursor to the end of a completed word.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_menu            # Show completion menu on a successive tab press.
setopt auto_param_slash     # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word     # Complete from both ends of a word.
setopt path_dirs            # Perform path search even on command names with slashes.
setopt NO_flow_control      # Disable start/stop characters in shell editor.
setopt NO_menu_complete     # Do not autoselect the first completion entry.

autoload -Uz compinit && compinit -d "$__zsh_cache_dir/zcompdump"

#
#endregion

#region: [Editor]
#

# Allow ctrl-S for history navigation (with ctrl-R)
# stty -ixon

#
#endregion

#region: [File System]
#

# Set Zsh options related to directories, globbing, and I/O.
setopt auto_pushd         # Make cd push the old directory onto the dirstack.
setopt pushd_minus        # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent       # Do not print the directory stack after pushd or popd.
setopt pushd_to_home      # Push to home directory when no argument is given.
setopt multios            # Write to multiple descriptors.
setopt extended_glob      # Use extended globbing syntax (#,~,^).
setopt glob_dots          # Don't hide dotfiles from glob patterns.
setopt NO_clobber         # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent  # Ask for confirmation for `rm *' or `rm path/*'

# Set directory aliases.
alias -- -='cd -'
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias dirh='dirs -v'

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
alias rcs='cd "${ZDOTDIR:-$HOME}"'
alias zshrc='"${EDITOR:-vim}" "${ZDOTDIR:-$HOME}/.zshrc"'
alias reload='source "${ZDOTDIR:-$HOME}/.zshrc"'

# Quick way to get back to your initial working directory.
IWD="${IWD:-PWD}"
alias iwd='cd "$IWD"'

# Misc aliases.
alias myip="curl ifconfig.me"
alias nv=nvim
alias curry="xargs -I{}"  # printf '%s\n' foo bar baz | curry touch {}.txt
alias ppath='echo $PATH | tr ":" "\n"'
alias cls="clear && printf '\e[3J'"
alias zbench="for i in {1..10}; do /usr/bin/time zsh -ic 'echo -n'; done"

#
#endregion

#region: [Functions]
#

# A basic calculator.
function calc {
  bc -l <<< "$@"
}

# Check strings for boolean values.
function is_true {
  case "${1,,}" in
    (t|y|true|yes|on|1) return 0 ;;
    (*) return 1 ;;
  esac
}

# Print 256 terminal color codes.
function colormap {
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
function up {
  local lvls cdstr
  lvls="${1:-1}"
  cdstr=".."
  while (( --lvls > 0 )); do
    cdstr+="/.."
  done
  cd "$cdstr" || return
}

# Extract all the things.
function extract {
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
function str/join {
  local sep ret arg
  [[ $# -ne 0 ]] || return 1
  [[ $# -ne 1 ]] || return 0
  sep="$1"; shift
  ret="$1"; shift
  for arg; do ret+="${sep}${arg}"; done
  echo "$ret"
}

# Split strings on a delimiter.
function str/split {
  local sep str
  [[ $# -ne 0 ]] || return 1
  sep=$(echo "$1" | sed 's/[]\/\\$*.^|[]/\\&/g')
  shift
  for str; do
    echo "$str" | sed "s/${sep}/\n/g"
  done
}

# Trims whitespace from start and end of string.
function str/trim {
  local arg
  for arg; do
    echo "$str" | sed 's/^[ \t]*//;s/[ \t]*$//'
  done
}

# Convert to UPPERCASE string.
function str/upper {
  local arg
  for arg; do
    echo "$arg" | tr '[:lower:]' '[:upper:]'
  done
}

# Convert to lowercase string.
function str/lower {
  local arg
  for arg; do
    echo "$arg" | tr '[:upper:]' '[:lower:]'
  done
}

# Sum an array.
function arr/sum {
  local i tot=0
  for i; do (( tot+=i )); done
  echo "$tot"
}

# Check if an element is in an array.
function arr/contains {
  local arg find="$1"; shift
  for arg; do
    [[ "$find" == "$arg" ]] && return 0
  done
  return 1
}

# Get the index of an element is in an array.
function arr/index_of {
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
  eval "$(zoxide init zsh)"
fi

# Enable fzf zsh integration.
if type fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

#
#endregion

#region: [Plugins]
#

REPO_HOME="${REPO_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh/repos}"

function plugin-clone {
  emulate -L zsh; setopt local_options extended_glob no_monitor no_glob

  local repo plugdir initfile; local -a repos initfiles=()
  if [[ "$1" == --missing ]]; then
    shift
    # Remove bare words ${(M)@:#*/*} and paths with leading slash ${@:#/*}.
    # Then split/join to keep the 2-part user/repo form to bulk-clone repos.
    for repo in ${${(M)@:#*/*}:#/*}; do
      repo=${(@j:/:)${(@s:/:)repo}[1,2]}
      [[ -e $REPO_HOME/$repo ]] || repos+="$repo"
    done
  else
    repos=($@)
  fi

  for repo in "$@"; do
    plugdir="$REPO_HOME/${repo:h:t}/${repo:t}"
    initfile="$plugdir/${repo:t}.plugin.zsh"
    if [[ ! -d "$plugdir" ]]; then
      echo "Cloning $repo..."
      (
        git clone -q --depth 1 --recursive --shallow-submodules "https://github.com/$repo" "$plugdir"
        if [[ ! -e "$initfile" ]]; then
          initfiles=("$plugdir"/*.{plugin.zsh,zsh-theme,zsh,sh})
          (( $#initfiles )) && ln -sf "${initfiles[1]}" "$initfile"
        fi
      ) &
    fi
  done
  wait
}

function plugin-load {
  local plugin initfile
  for plugin in "$@"; do
    [[ $plugin == /* ]] || plugin=$REPO_HOME/$plugin
    [[ -f $plugin ]] || plugin=$plugin/${plugin:t}.plugin.zsh
    fpath+=("${plugin:t}")
    [[ -r "$plugin" ]] && source "$plugin"
  done
}

function plugin-update {
  local plugin
  for plugin in "$REPO_HOME"/*/*/.git; do
    plugin="${plugin:a:h}"
    echo "Updating ${plugin:h:t}/${plugin:t}..."
    git -C "$plugin" pull --quiet --ff --depth 1 --rebase --autostash &
  done
  wait
}

# Add list of essential repos
if [[ $#plugins -eq 0 ]]; then
  plugins=(
    romkatv/zsh-bench
    #romkatv/powerlevel10k
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
  )
fi

# Load plugins
plugin-clone --missing $plugins
plugin-load $plugins

# Plugin settings
if [[ -d $REPO_HOME/romkatv/zsh-bench ]]; then
  path+=($REPO_HOME/romkatv/zsh-bench)
fi

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Prompt config
if (( $plugins[(Ie)romkatv/powerlevel10k] )); then
  [[ -r "${ZDOTDIR:-$HOME}/.p10k.zsh" ]] && source "${ZDOTDIR:-$HOME}/.p10k.zsh"
elif (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

#
#endregion

#region: [Post]
#

# Users can add to bashrc with *.zsh files in ~/.zshrc.d. Skips ~tilde files.
zshrc_d
zshrc_d .post.zsh

# Success
true

#
#endregion
