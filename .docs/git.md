# git

Reference for common stuff I never remember in git

## submodules

### add a submodule

```zsh
cd ~/.dotfiles
git submodule add git@github.com:mattmc3/zdotdir.git ./config/zsh
git submodule add git@github.com:mattmc3/fishconf.git ./config/fish
```

### update submodules

```zsh
git submodule update --recursive --remote
```

## machine specific config

config example:

```
# home machine
[includeIf "gitdir:~/.dotfiles"]
	path = config_home.local
# work machine
[includeIf "gitdir:~/Projects/work/**"]
	path = config_work.local

[alias]
	config-home = ! git config user.name "My Internet Name" && git config user.email "email@home.com"
	config-work = ! git config user.name "My Domain Name" && git config user.email "email@work.com"
```

config_home.local example:

```
[user]
    name = My Internet Name
    email = email@home.com
```

config_work.local example:

```
[user]
    name = My Domain Name
    email = email@work.com
```

## Resources

* [Detached HEAD](https://stackoverflow.com/questions/18770545/why-is-my-git-submodule-head-detached-from-master)
