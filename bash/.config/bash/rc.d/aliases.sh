#
# aliases - Zsh and bash aliases
#
# References
# - https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# - https://github.com/webpro/dotfiles/blob/master/system/.alias
# - https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
#

# directory aliases
alias dirh='dirs -v'
if [[ -n "$ZSH_VERSION" ]]; then
  alias -- -='cd -'
  for index in {1..9}; do
    alias "$index"="cd +${index}"
    alias -g "..$index"=$(printf '../%.0s' {1..$index})
  done
  unset index
fi

# single character shortcuts - be sparing!
alias _=sudo
alias l=ls
alias g=git

# mask built-ins with better defaults
alias ping='ping -c 5'
alias vi=vim
alias nv=nvim
alias grep="command grep --exclude-dir={.git,.vscode}"
export GNUPGHOME=${XDG_DATA_HOME:=~/.local/share}/gnupg
alias gpg="command gpg --homedir \"\$GNUPGHOME\""

# brew
alias brewup="brew update && brew upgrade && brew cleanup"

# directories
alias secrets="cd ${XDG_DATA_HOME:=~/.local/share}/secrets"

# more ways to ls
alias ll='ls -lh'
alias la='ls -lAh'
alias lsa="ls -aG"
alias ldot='ls -ld .*'

# fix typos
alias get=git
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias unixepoch="date +%s"

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# disk usage
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias cls="clear && printf '\e[3J'"

# print things
alias print-fpath='for fp in $fpath; do echo $fp; done; unset fp'
alias print-path='echo $PATH | tr ":" "\n"'
alias print-functions='print -l ${(k)functions[(I)[^_]*]} | sort'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

# set initial working directory
: ${IWD:=$PWD}
alias iwd='cd $IWD'

# dotfiles
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'
alias dotfl="cd \$DOTFILES/local"
alias fdot='cd ${XDG_CONFIG_HOME:=$HOME/.config}/fish'
alias fconf=fdot
alias zdot='cd $ZDOTDIR'

# java
alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

# python
alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pipup="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# todo-txt
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"
