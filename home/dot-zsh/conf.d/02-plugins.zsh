repos=(
  mattmc3/zman
  ohmyzsh/ohmyzsh
  romkatv/gitstatus
  romkatv/zsh-bench
  romkatv/zsh-defer
  sindresorhus/pure
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
)
plugin-clone $repos

omz_plugins=(
  extract
  fancy-ctrl-z
  magic-enter
)
plugin-source --dir $ZDOTDIR/plugins/ohmyzsh/plugins $omz_plugins

plugins=(
  zman
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-defer
  fast-syntax-highlighting
)
plugin-source $plugins

path+=($ZPLUGINDIR/zsh-bench)

MAGIC_ENTER_GIT_COMMAND="ls; git status -sb"
MAGIC_ENTER_OTHER_COMMAND="ls"
