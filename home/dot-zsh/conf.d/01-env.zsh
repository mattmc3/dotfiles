export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'

# ensure path arrays do not contain duplicates
typeset -gU path fpath cdpath

path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# /usr/bin/less --help
export LESS='-g -i -M -R -S -w -z-4'

# Use `< file` to quickly view the contents of any file.
READNULLCMD=$PAGER

# Go fast
KEYTIMEOUT=1

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
  export SHELL_SESSIONS_DISABLE=1
fi
