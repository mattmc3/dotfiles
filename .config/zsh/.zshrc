#!/bin/zsh

if ! [[ -d "${ZDOTDIR:-$HOME/.config/zsh}"/custom ]]; then
  git clone https://github.com/mattmc3/zsh_custom "${ZDOTDIR:-$HOME/.config/zsh}"/custom
fi

if [[ -r "${ZDOTDIR:-$HOME/.config/zsh}/custom/rcs/zshrc.zsh" ]]; then
  source "${ZDOTDIR:-$HOME/.config/zsh}/custom/rcs/zshrc.zsh"
fi
