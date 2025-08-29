# shellcheck shell=bash

# Tell gpg to store its keyring as data.
if [[ -d "$XDG_DATA_HOME" ]]; then
  export GPG_HOME="${GPG_HOME:-$XDG_DATA_HOME/gnupg}"
  alias gpg='gpg --homedir "$GPG_HOME"'
fi
