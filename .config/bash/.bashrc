#!/bin/bash

#
# XDG
#

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_DATA_HOME:-$HOME/.local/state}"
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME

#
# ble.sh
#

export REPO_HOME=$HOME/.cache/repos

# Use ble.sh
BLE_HOME="$XDG_DATA_HOME/blesh"
if [ ! -d "$BLE_HOME" ]; then
  if [ ! -d $REPO_HOME/akinomyoga/ble.sh ]; then
    git clone --recursive --depth 1 --shallow-submodules \
      https://github.com/akinomyoga/ble.sh $REPO_HOME/akinomyoga/ble.sh
  fi
  make -C $REPO_HOME/akinomyoga/ble.sh install PREFIX=~/.local
fi

# Add this lines at the top of .bashrc:
[[ $- == *i* ]] && source $BLE_HOME/ble.sh --noattach


#
# Path
#

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -e "$brewcmd" ]]; then
    eval "$("$brewcmd" shellenv)"
    break
  fi
done

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#
# Options
#

# http://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching
set -o noclobber                 # Prevent file overwrite on stdout redirection; use `>|` to force
shopt -s histappend              # append to history, don't overwrite it
shopt -s checkwinsize            # Update window size after every command
shopt -s cmdhist                 # Save multi-line commands as one command
shopt -s extglob 2> /dev/null    # Turn on extended globbing
shopt -s globstar 2> /dev/null   # Turn on recursive globbing (enables ** to recurse all directories)
shopt -s nocaseglob              # Case-insensitive globbing (used in pathname expansion)
shopt -s autocd 2> /dev/null     # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null   # Correct spelling errors during tab-completion
shopt -s cdspell 2> /dev/null    # Correct spelling errors in arguments supplied to cd
shopt -s cdable_vars             # CD across the filesystem as if you're in that dir
# set -o vi                        # Set vi editing mode

#
# History
#

HISTTIMEFORMAT='%F %T '   # use standard ISO 8601 timestamp
HISTSIZE=10000            # remember the last x commands in memory during session
HISTFILESIZE=100000       # start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups
HISTFILE=$XDG_DATA_HOME/bash/history
[[ -f $HISTFILE ]] || mkdir -p $(dirname $HISTFILE)
#PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

#
# Variables
#

export LSCOLORS=ExFxBxDxCxegedabagacad
export TZ="America/New_York"
CDPATH="."

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR="vim"
fi
export VISUAL='code'
export PAGER='less'

#
# Aliases
#

if type gawk &>/dev/null; then
  alias awk="gawk"
fi
alias ls='ls -G'
alias grep='grep --color=auto --exclude-dir={.git,.hg,.svn}'
export GNUPGHOME=$XDG_DATA_HOME/gnupg
alias gpg='gpg --homedir "$GNUPGHOME"'

alias rcs="cd ~/.config/bash"
alias reload="source ~/.bashrc"
if type safe-rm &>/dev/null; then
  alias rm='safe-rm'
  alias del='safe-rm'
fi
alias la='ls -laGh'
alias ll='ls -lGh'
alias l='ls -G'
alias ldot='ls -ld .*'
alias zz='exit'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias dotf='cd ~/.dotfiles'
alias bench="for i in {1..10}; do /usr/bin/time bash -ic 'echo -n'; done"

# single character shortcuts - be sparing!
alias _='sudo'
alias h='history'
alias v='vim'
alias c='clear'

#
# Plugins
#

# TODO:

#
# Utilities
#

eval "$(zoxide init bash)"
eval "$(fzf --bash)"

#
# Functions
#

# Only add things here we cannot live without. Otherwise, use ~/bin.

# 'up 3' is a shortcut to cd 3 directories up
# you can't cd from an external script, thus it lives here
up() {
  if [[ "$#" -eq 0 ]] ; then
    cd ..
  else
    local cdstr=""
    for i in {1..$1}; do
      cdstr="../$cdstr"
    done
    cd $cdstr
  fi
}

#
# Prompt
#

# starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/bash.toml
eval "$(starship init bash)"

#
# Local
#

[ ! -f ~/.bashrc.local ] || . ~/.bashrc.local

#
# Post
#

# Add this line at the end of .bashrc:
[[ ${BLE_VERSION-} ]] && ble-attach

# Uncomment to profile:
# if [[ ${BLE_VERSION-} ]]; then
#   ble/debug/profiler/start profile
#   ble-attach
#   ble/debug/profiler/stop
# fi
