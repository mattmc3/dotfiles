# dotfiles
My CMM dotfiles

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

- ~/.config/runcom/
- ~/.config/omz-custom/
- ~/.bash_profile
- ~/.bashrc
- ~/.editorconfig
- ~/.gitconfig
- ~/.gitignore_global
- ~/.hushlogin
- ~/.inputrc
- ~/.myrc
- ~/.screenrc
- ~/.tmux.conf
- ~/.vimrc
- ~/.zshrc

### Gitting

```zsh
# go home
cd
# get project
git clone git@git.innova-partners.com:mmcelheny/dotfiles.git ~/.dotfiles
# install
make install
```

## Project structure

- **root**: Contains dotfiles to be symlinked into `$HOME` upon running `make install`
  - **myrc:** My custom runcom file that should be bash/zsh agnostic. Called
  by bashrc and zshrc after shell specific stuff is loaded. `$CURRENT_SHELL`
  holds `bash` or `zsh` for any custom if/else logic in myrc not handled in
  each shell's default rc file.
- **omz-custom:** My custom plugins that run from oh-my-zsh. `$ZSH_CUSTOM` should
point here.
- **runcom:** Contains shell includes used by dotfiles. Divided into following
sections:

  - **aliases:** shell aliases
  - **variables:** environment variables
  - **functions:** common functions
  - **options:** shell options
  - **history:** history settings
  - **prompt:** shell prompt settings
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

The latest batch run shows that we load in ~200 ms, which is plenty
snappy enough.

```zsh
% benchmark-zsh
        0.23 real         0.11 user         0.08 sys
        0.20 real         0.10 user         0.06 sys
        0.20 real         0.10 user         0.06 sys
        0.21 real         0.11 user         0.06 sys
        0.20 real         0.10 user         0.06 sys
        0.21 real         0.10 user         0.06 sys
        0.19 real         0.10 user         0.06 sys
        0.21 real         0.11 user         0.06 sys
        0.21 real         0.10 user         0.06 sys
        0.21 real         0.10 user         0.07 sys
```

## Other resources

- [Sensible bash](https://github.com/mrzool/bash-sensible) (oxymoron?)
