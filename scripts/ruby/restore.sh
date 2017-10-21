DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

# ruby
if type gem > /dev/null 2>&1 ; then
    echo "restoring ruby gems..."
    cat "$settings_misc/ruby/gemlist.txt" | awk '{ print $1 }' | xargs gem install --conservative
fi
