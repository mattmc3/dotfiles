DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

# atom
if type apm > /dev/null 2>&1 ; then
    echo "restoring atom packages"
    # the apm export has version numbers that packages-file does not need
    cat "$settings_misc/atom/apm-list.txt" | awk -F'@' '{ print $1 }' | xargs apm install --compatible
fi
