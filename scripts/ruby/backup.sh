DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type gem > /dev/null 2>&1 ; then
    mkdir -p "$settings_misc/ruby"
    echo "backing up ruby gem list..."
    gem list --local > "$settings_misc/ruby/gemlist.txt"
fi
