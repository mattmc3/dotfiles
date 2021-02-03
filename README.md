# dotfiles

My dotfiles

## Install

```shell
export DOTFILES=~/.config/dotfiles
git clone --recursive git@github.com:mattmc3/dotfiles.git $DOTFILES
cd $DOTFILES
make install
```

## Intro

This repo is for storing my public config files, canonically called "dotfiles".
Having dotfiles in a repo makes setup on a new machine just a simple `git clone` away.
Some of the techniques and code are based on concepts from [this article][dotfiles-getting-started] and the zillions of other [dotfile repos on GitHub][github-dotfiles].

## What's here

In all the dotfiles repos, in all of GitHub, in all the world, you walked into
mine. What makes this one so special?!

- [rsync][rsync] magic to back up your existing config.
- Simple and minimal setup by favoring symlinks in ~/.config
- Pairs nicely with a private dotfiles.local repo for configs you don't want to
  share with the world.

![Terminal][terminal]

### Prereqs

- git
- rsync (for backups)

## How to use

This project uses a makefile to do its work, because... why not?
Run `make help` for details.
Or, skip the makefile and run the `dotfiles` script yourself to get started.

### Commands

**Help:**

```shell
# run 'make help' for info
make help
```

**Backup your dotfiles:**

```shell
# rsync backup of existing dotfiles
make backup
```

**Install these dotfiles:**

```shell
make install
```

If you decide you want to revert back, you'll want to copy your files out of the backup location.
Luckily, `rsync` makes everything smooth as silk.

```shell
# rsync can help you revert!
# always use --dry-run first... then remove it when you are satisfied
# change CCYYMMDD_HHMMSS to the actual dir name
REVERT_DIR="$DOTFILES/_bak/home_CCYYMMDD_HHMMSS"; rsync -av --dry-run "$HOME/" "$REVERT_DIR"
```

If you want to remove all these dotfiles, `make uninstall` is your friend.
However, if you do this, remember that your shell might not work without replacing the files.

[dotfiles-getting-started]:  https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
[fish]:                      https://fishshell.com/
[github-dotfiles]:           https://dotfiles.github.io/
[homebrew]:                  https://brew.sh
[rsync]:                     http://man7.org/linux/man-pages/man1/rsync.1.html
[stow]:                      https://www.gnu.org/software/stow/
[terminal]:                  https://raw.githubusercontent.com/mattmc3/dotfiles/resources/images/zsh_terminal.png
[zsh]:                       https://sourceforge.net/p/zsh/code/ci/master/tree/
