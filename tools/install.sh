#!/usr/bin/env bash
# dotfiles installer

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}

# You have to have ${HOME} set homie
if [[ -z $HOME ]]; then
    echo "You are \${HOME}less."
    exit 1
fi


### Install tools --------------------------------------------------------------
# ensure oh-my-zsh is installed
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    echo "getting oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# ensure bash-it is installed
if [[ ! -d "${HOME}/.bash_it" ]]; then
    echo "getting bash-it"
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
fi

# Set up macOS if its not already.
if [ "$(uname -s)" = "Darwin" ] ; then
    which -s brew
    if [[ $? != 0 ]] ; then
        echo "installing homebrew you neanderthal..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # accept xcode license
    #which -s xcodebuild && sudo xcodebuild -license accept
    which -s xcode-select || sudo xcode-select --install

    # get some utils
    utils=(bash git gpg python3 zsh)
    for util in "${utils[@]}" ; do
        test -e `brew --prefix`/bin/$util || (echo "installing $util..." && brew install $util)
    done
fi

### Backup and install ---------------------------------------------------------
# existing files are backed up. These files are excluded by gitignore and are
# only here for a *manual* restore.
dotfiles_backup_dir="${dotfiles_dir}/backups/$(date +"%Y%m%d_%H%M%S")"

function symlink_dotfile() {
    # args
    local source="$1"
    local target="$2"

    local exitcode=
    local backup_dir=

    if [[ -n "$dotfiles_backup_dir" ]]; then
        backup_dir=$dotfiles_backup_dir
    else
        backup_dir="${dotfiles_dir}/backups/$(date +"%Y%m%d_%H%M%S")"
    fi

    # backup
    if [[ -e "${target}" ]]; then
        mkdir -p "${backup_dir}"
        if [[ -d "${target}" ]]; then
            cp -r "${target}" "${backup_dir}"
        else
            cp "${target}" "${backup_dir}"
        fi
    fi

    # install symlink
    echo "symlinking \"${source}\" to \"${target}\""
    if [[ -d "${source}" ]]; then
        rm -rf "${target}"
    fi
    ln -sfn "${source}" "${target}"
    exitcode=$?
    if [[ $exitcode -ne 0 ]]; then
        echo "FAILED!"
        return 1
    else
        return 0
    fi
}

mkdir -p "${config_dir}"

# runcom
echo "Installing runcom symlinks..."
symlink_dotfile "${dotfiles_dir}/omz-custom"        "${config_dir}/omz-custom"
symlink_dotfile "${dotfiles_dir}/runcom"            "${config_dir}/runcom"
symlink_dotfile "${dotfiles_dir}/bash_profile"      "${HOME}/.bash_profile"
symlink_dotfile "${dotfiles_dir}/bashrc"            "${HOME}/.bashrc"
symlink_dotfile "${dotfiles_dir}/editorconfig"      "${HOME}/.editorconfig"
symlink_dotfile "${dotfiles_dir}/gitconfig"         "${HOME}/.gitconfig"
symlink_dotfile "${dotfiles_dir}/gitignore_global"  "${HOME}/.gitignore_global"
symlink_dotfile "${dotfiles_dir}/hushlogin"         "${HOME}/.hushlogin"
symlink_dotfile "${dotfiles_dir}/inputrc"           "${HOME}/.inputrc"
symlink_dotfile "${dotfiles_dir}/myrc"              "${HOME}/.myrc"
symlink_dotfile "${dotfiles_dir}/screenrc"          "${HOME}/.screenrc"
symlink_dotfile "${dotfiles_dir}/tmux.conf"         "${HOME}/.tmux.conf"
symlink_dotfile "${dotfiles_dir}/vimrc"             "${HOME}/.vimrc"
symlink_dotfile "${dotfiles_dir}/zshrc"             "${HOME}/.zshrc"
