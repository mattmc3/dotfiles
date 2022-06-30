# Emacs

## Prelude

```zsh
export PRELUDE_INSTALL_DIR="$HOME/.config/emacs" && curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
```

```zsh
# Fixes for GPG signature errors
EMACS_GPG_DIR=~/.config/emacs/elpa/gnupg
mkdir -p $EMACS_GPG_DIR
gpg --homedir $EMACS_GPG_DIR --list-keys
chmod 700 $EMACS_GPG_DIR
chmod 600 $EMACS_GPG_DIR/*
```
