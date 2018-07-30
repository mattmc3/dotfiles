# dotfiles
My dotfiles

## Intro
This repo is for keeping changes to *nix dot files and other configs just a `git clone`
away. Some of the techniques and code are based on concepts from
[this article](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th)
and the zillions of other [dotfile repos on GitHub](https://dotfiles.github.io/).

This mainly targets macOS, and leverages antigen/oh-my-zsh with zsh.

### Prereqs

- Get [homebrew](https://brew.sh)
- Get [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- Get [bash_it](https://github.com/Bash-it/)
- Get [antigen](https://github.com/zsh-users/antigen)

If you don't have these, `make install` will grab them.

**WARNING**: `make install` will automatically perform a backup of your existing
`$HOME` dotfiles before it symlinks in new ones. If you decide you want to revert
back, `make uninstall` will not return them to the previous state. All `make uninstall`
does is replaces the symlinks with the actual files in this repo. To revert, you'll
want to execute the following:

```zsh
cd bak/CCYYMMDD_HHMMSS
cp -i .* $HOME
```

### How it works

This dofiles repo backs up and replaces your shell config files with symlinks
from this repo. This also utilizes your `$XDG_CONFIG_HOME` to store runcom
and custom oh-my-zsh plugins directories. By using `$XDG_CONFIG_HOME`, nothing
needs to import from your dotfiles project, so you can `make uninstall` cleanly.

The symlinks on your machine following `make install` will be things like:

**$HOME:**

- ~/.todo/
- ~/bin/
- ~/.bash_profile
- ~/.bashrc
- ~/.editorconfig
- ~/.gitconfig
- ~/.hushlogin
- ~/.inputrc
- ~/.screenrc
- ~/.tmux.conf
- ~/.vimrc
- ~/.zshrc
- ~/.zshenv

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

## How to use?

This project uses a makefile to do its work, because why not? Scripts are stored
in the _scripts_ directory if you'd prefer to not use `make` and run them
yourself.

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
        0.12 real         0.07 user         0.03 sys
        0.13 real         0.08 user         0.03 sys
        0.12 real         0.07 user         0.03 sys
        0.13 real         0.08 user         0.04 sys
        0.12 real         0.07 user         0.03 sys
        0.13 real         0.08 user         0.04 sys
        0.13 real         0.08 user         0.04 sys
        0.14 real         0.08 user         0.04 sys
        0.12 real         0.07 user         0.03 sys
        0.12 real         0.07 user         0.03 sys
```

## Other resources

- [Sensible bash](https://github.com/mrzool/bash-sensible) (oxymoron?)
