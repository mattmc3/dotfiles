DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

echo "backing up crontab.txt..."
mkdir -p "$settings_misc/cron"
crontab -l > "$settings_misc/cron/crontab.txt"
