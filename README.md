# dotfiles

My dotfiles

## Install

### GNU Stow

The bin directory contains a `stow-dotfiles` script. At its core, it essentially runs:

```shell
stow -v --dotfiles --target=$HOME bash
stow -v --dotfiles --target=$HOME bin
stow -v --dotfiles --target=$HOME vim
stow -v --dotfiles --target=$HOME zsh
stow -v --dotfiles --target=$HOME/.config config
```

Certain legacy apps don't properly use .config, so anything that doesn't has a simple wrapper in `$HOME` that then sources the real files from `~/.config`.

## Intro

This repo is for storing my public config files, canonically called "dotfiles". Having dotfiles in a repo makes setup on a new machine just a simple `git clone` away. Some of the techniques and code are based on concepts from [this article][dotfiles-getting-started], [this article on bare repos](https://www.atlassian.com/git/tutorials/dotfiles), and the zillions of other [dotfile repos on GitHub][github-dotfiles].

![Terminal][terminal_gif]

### Prereqs

- git
- stow (if using that method)

## Resources

- [Managing dotfiles with a bare git repo](https://www.atlassian.com/git/tutorials/dotfiles)
- [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)
- [Using GNU Stow to Manage Symbolic Links for Your Dotfiles](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/)

[dotfiles-getting-started]:  https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
[github-dotfiles]:           https://dotfiles.github.io/
[homebrew]:                  https://brew.sh
[rsync]:                     http://man7.org/linux/man-pages/man1/rsync.1.html
[stow]:                      https://www.gnu.org/software/stow/
[terminal]:                  https://raw.githubusercontent.com/mattmc3/dotfiles/resources/images/zsh_terminal.png
[terminal_gif]:              https://raw.githubusercontent.com/mattmc3/dotfiles/resources/img/zdotdir.gif
