# show this message
default:
    @just --list

# update all submodules
submodules:
    git submodule update --remote --recursive --merge
    git submodule foreach 'git checkout main && git pull origin main'

# create symlinks to dotfiles
stow:
    mkdir -p ~/.config
    stow -d home -t ~ --verbose --dotfiles .

# remove symlinks to dotfiles
unstow:
    stow -d home -t ~ --verbose --dotfiles -D .
