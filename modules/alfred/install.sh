# add gauth
if [[ ! -f $HOME/.gauth ]]; then
    gpg --decrypt-files $DOTFILES/modules/alfred/gauth.pgp
    mv $DOTFILES/modules/alfred/gauth $HOME/.gauth
else
    echo "there's an existing ~/.gauth file. if you want to install this dotfile, run 'rm ~/.gauth && make install'"
fi
