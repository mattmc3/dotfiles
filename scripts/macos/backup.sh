DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

echo "backing up list of mac apps..."
mkdir -p "$settings_misc/macos"
ls -1 /Applications > "$settings_misc/macos/macapps.txt"
