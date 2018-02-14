# aliases

# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases

# zsh only aliases
if [[ -n $ZSH_VERSION ]]; then
    alias -2='cd -2'
    alias -3='cd -3'
    alias -4='cd -4'
    alias cd..='cd ..'
    alias -g ...='../..'
    alias -g ....='../../..'
    alias -g .....='../../../..'
    alias -g ......='../../../../..'
    alias s="source ~/.zshrc"
    alias reload="source ~/.zshrc"

    # zsh pipes
    alias -g H='| head'
    alias -g T='| tail'
    alias -g G='| grep'

elif [[ -n $BASH_VERSION ]]; then
    alias s="source ~/.bashrc"  # quick sourcing
    alias reload="source ~/.bashrc"
fi

# macOS only
if [[ "$OSTYPE" == darwin* ]]; then
    alias lmk="say 'Process complete.'"
    alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
    # use the trash can
    alias del="trash"
fi


# be safe
alias cpi='cp -i'
alias mvi='mv -i'
alias rmi='rm -i'

# single character shortcuts - be sparing!
alias _='sudo'
alias c='clear'
alias g='git'
alias v='nvim'
alias h='history'
alias x='exit'

# shortcuts
alias cl='clear'
alias py2='python2'
alias py3='python3'
alias py='python3'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir

# ls
alias ll='ls -lFh'
alias l='ls -F'
alias la='ls -lAFh'
alias ldot='ls -ld .*'

# fix typos
alias cs='cd'  # darn colemak
alias dir='ls'  # darn Windows
alias quit='exit'

# tools
alias te='$EDITOR .'
alias ide='$EDITOR .'
alias juno='jupyter notebook'

# quick edit for projects
alias ohmyzsh="cd \"\${ZSH}\"; $EDITOR ."
alias dotfiles="cd \"\${DOTFILES}\"; $EDITOR ."
alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias speedtest="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias ping="ping -c 5"
alias pinging="command ping"


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
alias venvactivate="source .venv/bin/activate"
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias path='echo -e ${PATH//:/\\n}'
alias linecount="grep -c '^'"
alias ex="exit"
alias ts="date +%Y%m%d%H%M%S"
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"

alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias dud='du -d 1 -h'
alias duf='du -sh *'

### git ###
alias get="git"
alias g="git"
alias sourcetree='open -a SourceTree'
alias gcm="git checkout master"
alias gadd="git add ."
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpristine='git reset --hard && git clean -dfx'
alias gsrh='git stash && git reset --hard'


### jupyter ###
alias juno="jupyter notebook"


### macOS ###
# brew
# alias bcu="brew cask list | xargs brew cask install --force"  # there's now a better way
alias bcu="brew cu"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to clipboard.'"


### todo.txt ###
alias t="todo.sh"
alias todo="te ~/Dropbox/notes/todo/todo.txt"
