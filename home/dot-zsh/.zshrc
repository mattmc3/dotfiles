#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# initialize antidote
ANTIDOTE_HOME=${XDG_CACHE_HOME:=~/.cache}/repos
if [[ ! -d $ANTIDOTE_HOME/mattmc3/antidote ]]; then
  git clone https://github.com/mattmc3/antidote $ANTIDOTE_HOME/mattmc3/antidote
fi
zstyle ':antidote:bundle' use-friendly-names 'yes'
source $ANTIDOTE_HOME/mattmc3/antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# Prompt
export STARSHIP_CONFIG=${XDG_CONFIG_HOME:=~/.config}/starship/hydro.toml
eval "$(starship init zsh)"

# Aliases.
[[ -f ${ZDOTDIR:-~}/.aliases ]] && . ${ZDOTDIR:-~}/.aliases

# Local settings/overrides.
[[ -f $DOTFILES/local/zsh/zshrc_local.zsh ]] && . $DOTFILES/local/zsh/zshrc_local.zsh

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true
