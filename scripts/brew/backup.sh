DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type brew > /dev/null 2>&1 ; then
    mkdir -p "$settings_misc/brew"
    echo "backing up Brewfile..."
    (cd "$settings_misc/brew" && brew bundle dump --force)
    # cat "$settings_misc/brew/Brewfile"
fi
