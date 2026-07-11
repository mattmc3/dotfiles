# dotfiles

My dotfiles

## Intro

This repo is for storing my public config files, canonically called
"dotfiles". Having dotfiles in a repo makes setup on a new machine just a
simple `git clone` away. Things meant to be symlinked into `$HOME` live
under `home/`; everything else here (docs, scripts, this README) is just
project scaffolding.

![Terminal][terminal_gif]

### Prereqs

- homebrew
- git
- just

## New machine setup

```zsh
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install stow and just
brew install stow just git

# generate a new SSH key (skip if this machine already has one)
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# copy the public key, then add it at https://github.com/settings/ssh/new
pbcopy < ~/.ssh/id_ed25519.pub

# confirm GitHub accepts the key before cloning
ssh -T git@github.com

# clone the repo (with submodules, .local is private) and symlink into $HOME
git clone --recurse-submodules git@github.com:mattmc3/dotfiles ~/.dotfiles
cd ~/.dotfiles
just stow

# symlink the private .local submodule too
cd .local
just stow
```

## Git submodules

Run this to make .local always track the main branch.

```sh
cd .local
git checkout main
git pull origin main  # Ensure it's up to date
cd ..
git config -f .gitmodules submodule..local.branch main
```

Adding these configs helps with push/pull on the .local submodule.

```sh
git config push.recurseSubmodules on-demand
git config submodule.recurse true
```

## Notes

Certain legacy apps don't properly use .config, so anything that doesn't
has a simple wrapper in `$HOME` that then sources the real files from
`~/.config`.

## Resources

- [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)
- [Using GNU Stow to Manage Symbolic Links for Your Dotfiles](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/)

[homebrew]: https://brew.sh
[stow]: https://www.gnu.org/software/stow/
[terminal]: https://raw.githubusercontent.com/mattmc3/dotfiles/resources/images/zsh_terminal.png
[terminal_gif]: https://raw.githubusercontent.com/mattmc3/dotfiles/resources/img/zdotdir.gif
