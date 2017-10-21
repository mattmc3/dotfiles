DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

pips=(pip2 pip3)
for pip in "${pips[@]}" ; do
    if type $pip > /dev/null 2>&1 ; then
        echo "restoring python $pip packages..."
        $pip install -r "$settings_misc/python/${pip}_requirements.txt"
    fi
done
