#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ -n "$ZPROFRC" ]] && zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

#
# zstyles
#

# Load .zstyles file if one exists.
[[ -e $ZDOTDIR/.zstyles ]] && . $ZDOTDIR/.zstyles

#
# plugins
#

# use antidote for plugin management
export ANTIDOTE_HOME=${XDG_CACHE_HOME:=~/.cache}/repos
[[ -d $ANTIDOTE_HOME/mattmc3/antidote ]] ||
  git clone --depth 1 --quiet https://github.com/mattmc3/antidote $ANTIDOTE_HOME/mattmc3/antidote

# keep all 3 for different test scenarios
# . $ANTIDOTE_HOME/mattmc3/antidote/antidote.zsh
# . ~/Projects/mattmc3/antidote/antidote.zsh
# . ${HOMEBREW_PREFIX:=/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
source $ANTIDOTE_HOME/mattmc3/antidote/antidote.zsh
antidote load

#
# prompt
#

prompt zephyr

#
# local
#

# Local settings/overrides.
[[ -f $ZDOTDIR/.zshrc.local ]] && . $ZDOTDIR/.zshrc.local

#
# wrap up
#

# Done profiling.
[[ -n "$ZPROFRC" ]] && zprof
unset ZPROFRC
true
