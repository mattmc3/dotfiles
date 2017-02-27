# python
pips=(pip2 pip3)
for pip in "${pips[@]}" ; do
    if which -s $pip ; then
        echo "genertating python $pip package list..."
        $pip freeze > $DOTFILES/modules/python/$pip.txt
    fi
done
