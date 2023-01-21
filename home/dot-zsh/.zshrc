#!/bin/zsh

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Autoload functions directory.
_zfuncdir=$_zhome/functions
if [[ -d $_zfuncdir ]]; then
  fpath=($_zfuncdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
fi

# Add zfuncdir sub directories.
ZFUNCDIR=$ZDOTDIR/functions
for _subdir in $ZFUNCDIR/*(/N); do
  if [[ "$_subdir:t" == macos ]] && [[ "$OSTYPE" != darwin* ]]; then
    continue
  fi
  fpath=($_subdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done

# Pre-Zebrafish
ZPLUGINDIR=$ZDOTDIR/plugins
fpath+=($ZPLUGINDIR/pure)

# Use Zebrafish to drive config
source $ZDOTDIR/.zebrafish.zsh

# TODO:
# - add PS2 to prompt
# - zf - generate core plugins
# - zf - support omz plugins
# - zf - support path/fpath plugins

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
