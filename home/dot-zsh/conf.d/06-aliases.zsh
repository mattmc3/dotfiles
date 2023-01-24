# mask built-ins with better defaults
alias mkdir='mkdir -p'
alias ping='ping -c 5'
alias type='type -a'
alias vi=vim
# if [[ "$OSTYPE" == darwin* ]]; then
#   alias ls="ls -G"
# else
#   alias ls="ls --group-directories-first --color=auto"
# fi
# alias grep="grep --color=auto --exclude-dir={.git,.svn}"

# more ways to ls
alias ll='ls -lh'
alias la='ls -lAh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# tar sux
alias tarls="tar -tvf"
alias untar="tar -xf"

# Set initial working directory.
IWD=${IWD:-$PWD}
alias iwd='cd $IWD'
