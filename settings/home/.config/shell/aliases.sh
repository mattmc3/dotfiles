# aliases

# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases

# Shortcuts
alias _="sudo"
alias g="git"
alias v="vim"
alias c="clear"
alias h="history"
alias py2="python2"
alias py3="python3"
alias quit="exit"
alias rmi="rm -i"
alias cs="cd"  # darn colemak
alias ll="ls -lAFh"
alias l="ls -lh"
alias la='ls -lah'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir

# Tools
alias te='subl'
alias juno="jupyter notebook"


# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias speedtest="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias ping="ping -c 5"


# Recursively clean files
alias cleands="find . -name '.DS_Store' -depth -exec rm {} \;"
alias cleanpyc="find . -type f -name '*.py[co]' -delete"


# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# other aliases
alias venv="source .venv/bin/activate"
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias path="echo $(echo \$PATH) | tr ':' '\n'"
alias linecount="grep -c '^'"
alias ex="exit"

alias dotfiles="cd $DOTFILES; $EDITOR ."
