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
# libs
#

for zlib in $ZDOTDIR/lib/*.zsh(N); do
  [[ $zlib:t != '~'* ]] || continue
  . $zlib
done
unset zlib

#
# plugins
#

# prezto pre-req
pmodload() {}

fpath_plugins=(
  # prompts
  sindresorhus/pure
  romkatv/powerlevel10k
)

path_plugins=(
  romkatv/zsh-bench
)

macos_plugins=()
if [[ $OSTYPE == darwin* ]]; then
  macos_plugins=(
    mattmc3/zephyr/plugins/homebrew
    mattmc3/zephyr/plugins/macos
  )
fi

zsh_plugins=(
  # oh-my-zsh
  ohmyzsh/ohmyzsh/plugins/extract
  ohmyzsh/ohmyzsh/plugins/magic-enter
  ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z

  # zephyr
  mattmc3/zephyr/plugins/zfunctions
  $macos_plugins
  mattmc3/zephyr/plugins/clipboard
  mattmc3/zephyr/plugins/environment
  mattmc3/zephyr/plugins/terminal
  mattmc3/zephyr/plugins/editor
  mattmc3/zephyr/plugins/history
  mattmc3/zephyr/plugins/directory
  mattmc3/zephyr/plugins/color
  mattmc3/zephyr/plugins/utility
  mattmc3/zephyr/plugins/completion
  mattmc3/zephyr/plugins/confd
  mattmc3/zephyr/plugins/prompt

  # custom
  python

  # utils
  mattmc3/zman
  ajeetdsouza/zoxide
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)

plugin-clone $path_plugins $fpath_plugins $zsh_plugins
plugin-load --kind path $path_plugins
plugin-load --kind fpath $fpath_plugins
plugin-load $zsh_plugins

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
