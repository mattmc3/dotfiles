#!/usr/bin/env bash
# dotfiles uninstaller

function unsymlink_dotfile() {
    local symlink=$1
    if [[ -L "${symlink}" ]]; then
        echo "uninstalling ${symlink}"
        target=$(readlink "$symlink")

        if [[ -d "${symlink}" ]]; then
            unlink "${symlink}"
            cp -r "$target" "$symlink"
        else
            rm -f "$symlink"
            cp "$target" "$symlink"
        fi
    else
        echo "File is not a symlink: ${symlink}. Skipping..."
    fi
}

function main() {
    local dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
    local config_dir=${XDG_CONFIG_HOME:-$HOME/.config}

    # You have to have ${HOME} set homie
    if [[ -z $HOME ]]; then
        echo "You are \${HOME}less."
        exit 1
    fi

    ### Uninstall ------------------------------------------------------------------
    # runcom
    echo "Uninstalling symlinks..."
    unsymlink_dotfile "${config_dir}/fish"
    unsymlink_dotfile "${config_dir}/git"
    unsymlink_dotfile "${config_dir}/nvim"
    unsymlink_dotfile "${config_dir}/xonsh"
    unsymlink_dotfile "${config_dir}/pep8"
    unsymlink_dotfile "${HOME}/.todo"
    unsymlink_dotfile "${HOME}/bin"
    unsymlink_dotfile "${HOME}/.bash_profile"
    unsymlink_dotfile "${HOME}/.bashrc"
    unsymlink_dotfile "${HOME}/.editorconfig"
    unsymlink_dotfile "${HOME}/.gitconfig"
    unsymlink_dotfile "${HOME}/.hushlogin"
    unsymlink_dotfile "${HOME}/.inputrc"
    unsymlink_dotfile "${HOME}/.screenrc"
    unsymlink_dotfile "${HOME}/.tmux.conf"
    unsymlink_dotfile "${HOME}/.zshrc"
}
main
