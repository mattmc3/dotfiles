DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type code > /dev/null 2>&1 ; then
    echo "restoring vscode packages"
    cat "$settings_misc/vscode/extensions.txt" | xargs -L 1 code --install-extension
fi
