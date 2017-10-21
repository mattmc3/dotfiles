DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_misc="$DOTFILES/settings/misc"

pips=(pip2 pip3)
for pip in "${pips[@]}" ; do
    if type $pip > /dev/null 2>&1 ; then
        mkdir -p "$settings_misc/python"
        echo "backing up python $pip package list..."
        $pip freeze > "$settings_misc/python/${pip}_requirements.txt"
    else
        echo "skipping $pip..."
    fi
done
