# shellcheck shell=bash

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

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# find
#alias fd='find . -type d -name '
#alias ff='find . -type f -name '

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

# Misc aliases.
alias myip="curl ifconfig.me"
alias nv=nvim
alias curry="xargs -I{}"  # printf '%s\n' foo bar baz | curry touch {}.txt
alias ppath='echo $PATH | tr ":" "\n"'
alias cls="clear && printf '\e[3J'"
alias bench="for i in {1..10}; do /usr/bin/time bash -ic 'echo -n'; done"
alias secrets="cd \"\${XDG_DATA_HOME:-\$HOME/.local/share}\"/secrets"
