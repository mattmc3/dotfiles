curdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
export DOTFILES="${DOTFILES:-$HOME/$curdir}"
settings_home="$DOTFILES/settings/home"
settings_misc="$DOTFILES/settings/misc"

backup_dirs=(
    "$settings_home"
    "$settings_misc"
)

for d in "${backup_dirs[@]}" ; do
    mkdir -p "$d"
done

# determine OS. Darwin->macOS
if [ "$(uname -s)" = "Darwin" ] ; then
    which -s brew
    if [[ $? != 0 ]] ; then
        echo "installing homebrew you neanderthal..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "updating homebrew..."
        brew update && brew upgrade
    fi

    # accept xcode license
    which -s xcodebuild && sudo xcodebuild -license accept

    # get some utils
    utils=(git gpg zsh bash)
    for util in "${utils[@]}" ; do
        test -e /usr/local/bin/$util || (echo "installing $util..." && brew install $util)
    done
fi

# install oh-my-zsh
ZSH=${ZSH:-$HOME/.oh-my-zsh}
if [[ ! -d "$ZSH" ]] ; then
    echo 'Installing oh-my-zsh...'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install bash_it
if [[ ! -d $HOME/.bash_it ]] ; then
    echo 'Installing bash_it...'
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi
