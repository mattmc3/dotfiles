# dotfiles

My dotfiles

## Intro

This repo is for storing my public config files, canonically called "dotfiles". Having dotfiles in a repo makes setup on a new machine just a simple `git clone` away. Some of the techniques and code are based on concepts from [this article][dotfiles-getting-started], [this article on bare repos](https://www.atlassian.com/git/tutorials/dotfiles), and the zillions of other [dotfile repos on GitHub][github-dotfiles].

![Terminal][terminal_gif]

### Prereqs

- git

## Bare repo

```zsh
alias dotf='GIT_WORK_TREE=~ GIT_DIR=~/.dotfiles'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
git clone --bare git@github.com:mattmc3/dotfiles $HOME/.dotfiles
dotfiles checkout
if [[ $? == 0 ]]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles.bak/{}
fi
```

Local

```zsh
alias dotloc='git --git-dir=$HOME/.dotfiles/.local --work-tree=$HOME'
git clone --bare git@github.com:mattmc3/dotfiles.local $HOME/.dotfiles/.local
dotloc checkout
if [[ $? == 0 ]]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  dotloc checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles.local.bak/{}
fi
```

## Edit

```zsh
alias dotty="GIT_WORK_TREE=~ GIT_DIR=~/.dotfiles"
IDE=${VISUAL:-${EDITOR:-vim}}
dotty $IDE ~
```

## Notes

Certain legacy apps don't properly use .config, so anything that doesn't has a simple wrapper in `$HOME` that then sources the real files from `~/.config`.

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
