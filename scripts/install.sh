#!/usr/bin/env bash

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

install_dotfile() {
    local source="$1"
    local target="$2"
    # if symlinking a dir
    if [[ ! -L $target && -d $target ]]; then
        rm -rf $target
    fi
    echo "linking ${target}"
    ln -sf ${source} ${target}
    local exitcode=$?
    if [ $exitcode -ne 0 ]; then
        echo "FAILED!"
        return 1
    else
        return 0
    fi
}

# macOS?
if [ "$(uname -s)" = "Darwin" ]; then
    OS="macOS"
else
    OS=$(uname -s)
fi

if [[ $OS = "macOS" ]] ; then
    # gotta rely on having some macOS utils
    echo "OSX!"
    if ! which -s brew ; then
        echo 'Installing Homebrew...'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if ! which -s gpg ; then
        echo 'Installing gpg...'
        brew install gpg
    fi

    if ! which -s git ; then
        echo 'Installing git...'
        brew install git
    fi
fi

# install zim
# ZDOTDIR=${ZDOTDIR:-${HOME}}
# if [[ ! -d $ZDOTDIR/.zim ]] ; then
#     echo 'Installing zim...'

#     # https://github.com/Eriner/zim
#     zsh $DOTFILES/scripts/install_zim.zsh
# fi

# install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# get bash_it
# if [[ ! -d $HOME/.zim ]] ; then
#     git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
#     ~/.bash_it/install.sh
# fi

cd $DOTFILES

# symlink runcom files
install_dotfile $DOTFILES/runcom/bashrc.bash $HOME/.bashrc
install_dotfile $DOTFILES/runcom/bash_profile.bash $HOME/.bash_profile
install_dotfile $DOTFILES/runcom/zshrc.zsh $HOME/.zshrc
install_dotfile $DOTFILES/runcom/inputrc.sh $HOME/.inputrc

# source install.sh in modules
find $DOTFILES/modules -name "install.sh" | while read file; do
    . $file
done

echo "dotfiles installed!"
