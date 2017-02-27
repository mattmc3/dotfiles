# homebrew
echo "generating brewfile..."
(cd $DOTFILES/modules/brew && brew bundle dump --force)
