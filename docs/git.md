# git

Reference for common stuff I never remember in git

## Fix a commit

### Accidental local commit

Undo previous local commit:

```zsh
git reset --soft HEAD~1
```

## submodules

### add a submodule

```zsh
cd $DOTFILES
git submodule add git@github.com:mattmc3/zdotdir.git ./config/zsh
git submodule add git@github.com:mattmc3/fishconf.git ./config/fish
```

### update submodules

```zsh
git submodule update --recursive --remote
```

### remove submodules

```zsh
# https://stackoverflow.com/a/36593218/8314
local submodule="$1"
if [[ ! -n "$submodule" || ! -d "$submodule" ]]; then
  >&2 echo "FAIL: No valid submodule specified"
  return 1
fi

# Remove the submodule entry from .git/config
git submodule deinit -f "$submodule"

# Remove the submodule directory from the superproject's .git/modules directory
rm -rf ".git/modules/${submodule}"

# Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f "$submodule"
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

## branches

Prune branches

```zsh
local curbranch=$(git rev-parse --abbrev-ref HEAD)
if [[ $curbranch != 'master' ]] || [[ $curbranch != 'main' ]]; then
  >&2 echo "This command requires you to be on the main branch."
  >&2 echo "please run: git checkout main"
  return 1
fi
git fetch -p && git branch -vv | awk '/: gone]/{print \$1}' | xargs git branch -d
```

## Resources

* [Detached HEAD](https://stackoverflow.com/questions/18770545/why-is-my-git-submodule-head-detached-from-master)
