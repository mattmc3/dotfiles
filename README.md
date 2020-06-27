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
Having dotfiles in a repo makes setup on a new machine just a simple `git clone`
away. Some of the techniques and code are based on concepts from
[this article][dotfiles-getting-started] and the zillions of other
[dotfile repos on GitHub][github-dotfiles].

## What's here

In all the dotfiles repos, in all of GitHub, in all the world, you walked into
mine. What makes this one so special?!

- Simple and minimal setup leveraging using [stow][stow].
- [rsync][rsync] magic to back up your existing config.
- Pairs nicely with a private dotfiles.local repo for configs you don't want to
  share with the world.

![Terminal][terminal]

## What's not here (but really is)

My [fish][fish] and [zsh][zsh] configs are in their own repos, but are
referenced here as submodules. I prefer the option to work on my shell
separately from other dotfiles. It's no fun when everything is
broken at the same time when I'm messing with this repo.

My machine specific files are stored in their own private repo, dotfiles.local.

### Prereqs

- git & [zsh][zsh] & rsync (for backups)

## How to use

This project uses a makefile to do its work, because... why not? Run
`make help` for details. Or, skip the makefile and run "make install" to get
started. A backup of your dotfiles is taken automatically if you have rsync.

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
# stow the dotfiles
make install
```

If you decide you want to revert back, you'll want to copy your files
out of the backup location. Luckily, `rsync` makes everything smooth as silk.

```shell
# rsync can help you revert!
# always use --dry-run first... then remove it when you are satisfied
# change CCYYMMDD_HHMMSS to the actual dir name
REVERT_DIR="$DOTFILES/_bak/home_CCYYMMDD_HHMMSS"; rsync -av --dry-run "$HOME/" "$REVERT_DIR"
```

If you want to remove all these dotfiles, `make uninstall` is your friend.
However, if you do this, remember that your shell might not work without
replacing the files.

## Performance

A snappy shell is very important. My dotfiles include benchmark scripts in the
bin directory that run bash/fish/zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # 2.5 GHz i7 MacBook Pro
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
```

```fish
><> for i in (seq 1 10); /usr/bin/time fish -i -c exit; end
        0.02 real         0.01 user         0.00 sys
        0.01 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.01 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.01 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
```

[dotfiles-getting-started]:  https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
[fish]:                      https://fishshell.com/
[github-dotfiles]:           https://dotfiles.github.io/
[homebrew]:                  https://brew.sh
[rsync]:                     http://man7.org/linux/man-pages/man1/rsync.1.html
[stow]:                      https://www.gnu.org/software/stow/
[terminal]:                  https://raw.githubusercontent.com/mattmc3/dotfiles/resources/images/zsh_terminal.png
[zsh]:                       https://sourceforge.net/p/zsh/code/ci/master/tree/
