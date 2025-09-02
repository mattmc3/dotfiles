# shellcheck shell=bash
#
# nim
#

if [ -d $HOME/.nimble/bin ]; then
  export PATH="$PATH:$HOME/.nimble/bin"
fi
