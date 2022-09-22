# XDG ---------------------------------------------------------------------- {{{
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"


# opts --------------------------------------------------------------------- {{{
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


# history ------------------------------------------------------------------ {{{
HISTTIMEFORMAT='%F %T '   # use standard ISO 8601 timestamp
HISTSIZE=100000           # remember the last x commands in memory during session
HISTFILESIZE=100000       # start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups
HISTFILE=$XDG_DATA_HOME/bash/history
[[ -f $HISTFILE ]] || mkdir -p $(dirname $HISTFILE)
PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"


# env ---------------------------------------------------------------------- {{{
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export LSCOLORS=ExFxBxDxCxegedabagacad
export TZ="America/New_York"

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
fi

CDPATH="."

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR="vim"
fi
export VISUAL='code'
export PAGER='less'


# aliases ------------------------------------------------------------------ {{{
alias ls='ls -G'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias reload="source ~/.bashrc"
alias rm='safe-rm'
alias del='safe-rm'
alias la='ls -laGh'
alias ll='ls -lGh'
alias l='ls -G'
alias ldot='ls -ld .*'
alias zz='exit'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# single character shortcuts - be sparing!
alias _='sudo'
alias h='history'
alias v='vim'
alias c='clear'


# functions ---------------------------------------------------------------- {{{
# Only put things here that you cannot live without, or that have to be in the
# current shell context to function properly. Otherwise, it probably belongs in
# ~/bin

# 'up 3' is a shortcut to cd 3 directories up
# you can't cd from an external script, thus it lives here
up() {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    local cdstr=""
    for i in {1..$1}; do
      cdstr="../$cdstr"
    done
    cd $cdstr
  fi
}


# prompt ------------------------------------------------------------------- {{{
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
PROMPT_DIRTRIM=2

reset="\e[1;0m";
black="\e[1;30m";
blue="\e[1;34m";
cyan="\e[1;36m";
green="\e[1;32m";
orange="\e[1;33m";
purple="\e[1;35m";
red="\e[1;31m";
violet="\e[1;35m";
white="\e[1;37m";
yellow="\e[1;33m";

# __git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }

# you can use git-prompt too if you want
if [[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  # export PS1='[\u@\h \w$(__git_ps1)]\n\$ '
  export PS1="\[${red}\]\t \[${green}\]$USER \[${cyan}\]\h \[${blue}\]\w \[${yellow}\]$(__git_ps1)\[${reset}\]\n\$ "
  export PS2='\[\033[01;36m\]>'
else
  export PS1="\[${red}\]\t \[${green}\]$USER \[${cyan}\]\h \[${blue}\]\w \[${reset}\]\n\$ "
  export PS2='\[\033[01;36m\]>'
fi

# local -------------------------------------------------------------------- {{{
[ ! -f ~/.bashrc.local ] || . ~/.bashrc.local
