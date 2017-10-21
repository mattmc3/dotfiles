DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type npm > /dev/null 2>&1 ; then
    mkdir -p "$settings_misc/node.js"
    echo "backing up node.js global package list..."
    npm ls -g --depth=0 > "$settings_misc/node.js/npm-list.txt"
fi
