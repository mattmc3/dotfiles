################################################################################
# Variables
export EDITOR="subl_wait.sh"
export GIT_EDITOR='subl_wait.sh'
export LPASS_AGENT_TIMEOUT=0
export MONO_GAC_PREFIX="/usr/local"


################################################################################
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
alias la="ls -lAFh"
alias l="ls -lah"
alias ll='ls -lh'
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
alias cleands="find . -type f -name '*.DS_Store' -delete"
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

################################################################################
# functions
function cdl () {
    cd "$@" && ls
}

function zsh-load-benchmark() {
    for i in $(seq 1 10); do
        /usr/bin/time zsh -i -c exit
    done
}

function bash-load-benchmark() {
    for i in $(seq 1 10); do
        /usr/bin/time bash -i -c exit
    done
}


################################################################################
# Misc

# add ssh key
ssh-add ~/.ssh/id_rsa &> /dev/null

# z is an awesome utility for remembering paths
if [ -e `brew --prefix`/etc/profile.d/z.sh ]; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='subl'
fi


################################################################################
# sourcing

# .myenv secrets
if [[ -f $HOME/.myenv ]] ; then
    . ~/.myenv
fi

# source modules
find $DOTFILES/modules -name "*rc.sh" | while read file; do
    . $file
done
