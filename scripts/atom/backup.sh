DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

if type apm > /dev/null 2>&1 ; then
    mkdir -p "$settings_misc/atom"
    echo "backing up atom package list..."
    apm list --installed --bare > "$settings_misc/atom/apm-list.txt"
    # cat "$settings_misc/atom/apm-list.txt"
else
    echo "skipping atom..."
fi
