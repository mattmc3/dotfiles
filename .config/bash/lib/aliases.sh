# shellcheck shell=bash

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

BASH_HOME="${BASH_HOME:-$XDG_CONFIG_HOME/bash}"
alias rcs='cd $BASH_HOME'
alias reload='source "${BASH_HOME:-$HOME}/.bashrc"'
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

# initial working directory
IWD="${IWD:-PWD}"
alias iwd='cd "$IWD"'

# brew
alias brewup="brew update && brew upgrade && brew cleanup"

# single character shortcuts - be sparing!
alias _='sudo'
alias h='history'
alias v='vim'
alias c='clear'
