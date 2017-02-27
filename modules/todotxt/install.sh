# symlink ~/.todo
if [ -e $HOME/.todo ]; then
    rm -rf $HOME/.todo
fi
install_dotfile $DOTFILES/modules/todotxt/todo $HOME/.todo
