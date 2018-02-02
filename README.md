# dotfiles
My dotfiles

## Intro
This repo is for keeping changes to *nix dot files and other configs just a `git clone`
away. Some of the techniques and code are based on concepts from
[this article](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th)
and the zillions of other [dotfile repos on GitHub](https://dotfiles.github.io/).

This mainly targets macOS, and leverages oh-my-zsh with zsh, or bash_it for bash.
This repo contains just my customizations on top of that.

### Prereqs

- Get [homebrew](https://brew.sh)
- Get [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- Get [bash_it](https://github.com/Bash-it/)

If you don't have these, `make install` will grab them.

**WARNING**: `make install` will automatically perform a backup of your existing
`$HOME` dotfiles before it symlinks in new ones. If you decide you want to revert
back, `make uninstall` will not return them to the previous state. All `make uninstall`
does is replaces the symlinks with the actual files in this repo. To revert, you'll
want to execute the following:

```zsh
cd backups/CCYYMMDD_HHMMSS
cp -i .* $HOME
```

### How it works

This dofiles repo backs up and replaces your shell config files with symlinks
from this repo. This also utilizes your `$XDG_CONFIG_HOME` to store runcom
and custom oh-my-zsh plugins directories. By using `$XDG_CONFIG_HOME`, nothing
needs to import from your dotfiles project, so you can `make uninstall` cleanly.

The symlinks on your machine following `make install` will be:

**$HOME:**
- ~/.todo/
- ~/.bin/
- ~/.bash_profile
- ~/.bashrc
- ~/.editorconfig
- ~/.gitconfig
- ~/.hushlogin
- ~/.inputrc
- ~/.screenrc
- ~/.tmux.conf
- ~/.vimrc
- ~/.xonshrc
- ~/.zshrc

**.config:**
- Various

### Gitting

```zsh
# go home
cd
# get project
git clone git@github.com:mattmc3/dotfiles.git ~/.dotfiles
# install
make install
```

## Project structure notes

- **home**: Contains dotfiles to be symlinked into `$HOME` upon running `make install`
- **includes**: Files that can be included from your shellrc file
- **tools:** The shell scripts that make the dotfiles project go!
- **backups:** Snapshots of your `$HOME` prior to completing `make install`. _Excluded
from repo to protect against secrets being committed._

## How to use?

This project uses a makefile to do its work, because why not? Scripts are stored
in the _tools_ directory if you'd prefer to not use `make` and run them yourself.

- Run `make help` for detals, but the main actions are:
  - `make install`
  - `make uninstall`

## Performance

A snappy shell is very important. My dotfiles include a `benchmark-zsh` command
that runs zsh 10 times and presents the timings. (There's also a `benchmark-bash`
command too, but I only care about tuning my primary shell, zsh).

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% benchmark-zsh
        0.18 real         0.10 user         0.05 sys
        0.19 real         0.11 user         0.05 sys
        0.18 real         0.10 user         0.05 sys
        0.19 real         0.10 user         0.05 sys
        0.19 real         0.10 user         0.06 sys
        0.19 real         0.10 user         0.05 sys
        0.19 real         0.11 user         0.05 sys
        0.18 real         0.10 user         0.05 sys
        0.18 real         0.10 user         0.05 sys
        0.18 real         0.10 user         0.05 sys
```

## Other resources

- [Sensible bash](https://github.com/mrzool/bash-sensible) (oxymoron?)
