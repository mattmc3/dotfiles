#!/usr/bin/env bash
# dotfiles uninstaller

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}

# You have to have ${HOME} set homie
if [[ -z $HOME ]]; then
    echo "You are \${HOME}less."
    exit 1
fi

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

### Uninstall ------------------------------------------------------------------
# runcom
echo "Uninstalling runcom symlinks..."
unsymlink_dotfile "${config_dir}/omz-custom"
unsymlink_dotfile "${config_dir}/runcom"
unsymlink_dotfile "${HOME}/.bash_profile"
unsymlink_dotfile "${HOME}/.bashrc"
unsymlink_dotfile "${HOME}/.editorconfig"
unsymlink_dotfile "${HOME}/.gitconfig"
unsymlink_dotfile "${HOME}/.gitignore_global"
unsymlink_dotfile "${HOME}/.hushlogin"
unsymlink_dotfile "${HOME}/.inputrc"
unsymlink_dotfile "${HOME}/.myrc"
unsymlink_dotfile "${HOME}/.screenrc"
unsymlink_dotfile "${HOME}/.tmux.conf"
unsymlink_dotfile "${HOME}/.vimrc"
unsymlink_dotfile "${HOME}/.zshrc"
