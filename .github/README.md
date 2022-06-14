# dotfiles

My dotfiles

## Install

These dotfiles use a bare repo.

First, alias `dotf`:

```shell
alias dotf='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
```

Next, back up anything that might get overwritten by the repo and remove those files and dirs.

Then, clone the bare repo:

```shell
git clone --bare git@github.com:mattmc/dotfiles $HOME/.dotfiles.git
```

Now, you can use the `dotf` command in place of `git` commands.

## Intro

This repo is for storing my public config files, canonically called "dotfiles". Having dotfiles in a repo makes setup on a new machine just a simple `git clone` away. Some of the techniques and code are based on concepts from [this article][dotfiles-getting-started], [this article on bare repos](https://www.atlassian.com/git/tutorials/dotfiles), and the zillions of other [dotfile repos on GitHub][github-dotfiles].

![Terminal][terminal_gif]

### Prereqs

- git

## Resources

- [Managing dotfiles with a bare git repo](https://www.atlassian.com/git/tutorials/dotfiles))
- [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)

[dotfiles-getting-started]:  https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
[github-dotfiles]:           https://dotfiles.github.io/
[homebrew]:                  https://brew.sh
[rsync]:                     http://man7.org/linux/man-pages/man1/rsync.1.html
[stow]:                      https://www.gnu.org/software/stow/
[terminal]:                  https://raw.githubusercontent.com/mattmc3/dotfiles/resources/images/zsh_terminal.png
[terminal_gif]:              https://raw.githubusercontent.com/mattmc3/dotfiles/resources/img/zdotdir.gif
