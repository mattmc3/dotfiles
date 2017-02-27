# atom
if [ -d $HOME/.atom ]; then
    # atom configs
    find $DOTFILES/modules/atom/config -type f | while read file; do
        basefile=$(basename $file)
        uninstall_dotfile "$HOME/.atom/$basefile"
    done
fi
