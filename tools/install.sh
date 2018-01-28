#!/usr/bin/env bash
# dotfiles installer

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

function main() {
    # You have to have ${HOME} set homie
    if [[ -z $HOME ]]; then
        echo "You are \${HOME}less." 1>&2
        exit 1
    fi

    local dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
    local config_dir=${XDG_CONFIG_HOME:-$HOME/.config}


    ### Install tools --------------------------------------------------------------
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
        local utils=(bash git gpg python3 zsh)
        for util in "${utils[@]}" ; do
            test -e `brew --prefix`/bin/$util || (echo "installing $util..." && brew install $util)
        done
    fi

    ### Backup and install ---------------------------------------------------------
    # existing files are backed up. These files are excluded by gitignore and are
    # only here for a *manual* restore.
    local dotfiles_backup_dir="${dotfiles_dir}/backups/$(date +"%Y%m%d_%H%M%S")"

    mkdir -p "${config_dir}"

    # TODO: figure this out... I have no idea if this will work with uninstall
    # dotfiles_dir="~/${dotfiles_dir#*$HOME/}"
    # config_dir="~/${config_dir#*$HOME/}"

    # runcom
    echo "Installing runcom symlinks..."
    symlink_dotfile "${dotfiles_dir}/config/nvim"       "${config_dir}/nvim"
    symlink_dotfile "${dotfiles_dir}/config/omz-custom" "${config_dir}/omz-custom"
    symlink_dotfile "${dotfiles_dir}/config/runcom"     "${config_dir}/runcom"
    symlink_dotfile "${dotfiles_dir}/bash_profile"      ~/.bash_profile
    symlink_dotfile "${dotfiles_dir}/bashrc"            ~/.bashrc
    symlink_dotfile "${dotfiles_dir}/editorconfig"      ~/.editorconfig
    symlink_dotfile "${dotfiles_dir}/gitconfig"         ~/.gitconfig
    symlink_dotfile "${dotfiles_dir}/gitignore_global"  ~/.gitignore_global
    symlink_dotfile "${dotfiles_dir}/hushlogin"         ~/.hushlogin
    symlink_dotfile "${dotfiles_dir}/inputrc"           ~/.inputrc
    symlink_dotfile "${dotfiles_dir}/screenrc"          ~/.screenrc
    symlink_dotfile "${dotfiles_dir}/tmux.conf"         ~/.tmux.conf
    symlink_dotfile "${dotfiles_dir}/zshrc"             ~/.zshrc

    # neovim ftw!
    ln -sf "${config_dir}/nvim/init.vim" ~/.vimrc
}
main
