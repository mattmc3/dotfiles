# git

Reference for common stuff I never remember in git

## submodules

### add a submodule

```zsh
cd ~/.dotfiles
git submodule add git@github.com:mattmc3/zdotdir.git ./zsh/.config/zsh
```

### update submodules

```zsh
git submodule update --recursive --remote
```
