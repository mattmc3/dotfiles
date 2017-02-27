# encrypt .gauth
echo "generating gauth.pgp..."
if [ -f $HOME/.gauth ]; then
    rm -f $DOTFILES/modules/alfred/gauth.pgp
    gpg --recipient "$PERS_EMAIL" --recipient "$WORK_EMAIL" --output $DOTFILES/modules/alfred/gauth.pgp --armor=ascii --encrypt ~/.gauth
fi
