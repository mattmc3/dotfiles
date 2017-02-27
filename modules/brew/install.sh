# install brew apps
echo "installing missing brew apps..."
cd $DOTFILES/modules/brew
brew bundle check
if [ $? -ne 0 ]; then
    brew bundle install
fi
cd - > /dev/null
