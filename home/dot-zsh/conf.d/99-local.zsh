# local overrides
[[ ! -f $ZDOTDIR/.zshrc_local ]] || source $ZDOTDIR/.zshrc_local

# dotfiles local overrides from dotfiles
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh
