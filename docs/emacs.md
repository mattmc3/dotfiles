# Emacs

## Install

### Emacs Mac Port

* [Emacs Mac port](https://github.com/railwaycat/homebrew-emacsmacport)

```sh
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-native-comp --with-emacs-big-sur-icon --with-starter
```

Install in `/Applications`:

```sh
osascript -e 'tell application "Finder" to make alias file to POSIX file "/opt/homebrew/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
```

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
