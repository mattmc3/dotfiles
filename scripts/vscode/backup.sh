DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type code > /dev/null 2>&1 ; then
    mkdir -p "$settings_misc/vscode"
    echo "backing up visual-studio-code extentions..."
    code --list-extensions > "$settings_misc/vscode/extensions.txt"
    # cat "$settings_misc/vscode/extensions.txt"
else
    echo "skipping visual-studio-code..."
fi
