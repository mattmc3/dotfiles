# atom
if [ -d $HOME/.atom ]; then
    # atom configs
    find $DOTFILES/modules/atom/config -type f | while read file; do
        basefile=$(basename $file)
        install_dotfile "$file" "$HOME/.atom/$basefile"
    done
fi
