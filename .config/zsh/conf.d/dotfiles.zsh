# dotfiles are managed with a bare repo
alias dotf='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

export DOTFILES=~/.config/dotfiles
export DOTFILES_LOCAL=~/.config/dotfiles.local
if [[ ! -d $DOTFILES_LOCAL ]]; then
  git clone git@github.com:mattmc3/dotfiles.local $DOTFILES_LOCAL
fi
if [[ ! -e $ZDOTDIR/.zshrc.local ]]; then
  ln -sf $DOTFILES_LOCAL/zsh/zshrc_local.zsh $ZDOTDIR/.zshrc.local
fi
