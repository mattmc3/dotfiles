# shellcheck shell=bash

# dotfiles
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
alias dotf='cd "$DOTFILES"'
alias fdot="cd ~/.config/fish"
alias zdot="cd ~/.config/zsh"
alias bdot="cd ~/.config/bash"
alias rcs='cd "${BASH_HOME:-$HOME}"'
alias bashrc='"${EDITOR:-vim}" "${BASH_HOME:-$HOME}/.bashrc"'
alias reload='source "${BASH_HOME:-$HOME}/.bashrc"'
