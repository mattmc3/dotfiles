DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

# node.js
if type npm > /dev/null 2>&1 ; then
    echo "restoring node.js packages"
    # the npm export has version numbers that packages-file does not need
    cat "$settings_misc/node.js/npm-list.txt" | awk 'NR>1{ print $2 }' | awk -F'@' '{ print $1 }' | xargs npm install -g
fi
