DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type brew > /dev/null 2>&1 ; then
    echo "restoring apps from Brewfile..."
    (cd "$settings_misc/brew" && brew bundle)
fi
