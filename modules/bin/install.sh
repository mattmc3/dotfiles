# symlink bin
if [ -e $HOME/bin ]; then
    rm -rf $HOME/bin
fi
install_dotfile $DOTFILES/modules/bin/bin $HOME/bin
