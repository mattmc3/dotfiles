# shellcheck shell=bash

# Tell gpg to store its keyring as data.
if [[ -d "$XDG_DATA_HOME" ]]; then
  export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
  alias gpg='gpg --homedir "$GNUPGHOME"'
fi
