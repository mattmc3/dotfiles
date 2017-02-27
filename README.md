# Dotfiles

### WARNING
`make install` is currently a *destructive opertation*. **Backup your home directory
before using this project.** Unless you're me, and then this is really the homedir you
always wanted <3 <3 <3).

## Intro
This repo is for keeping changes to *nix dot files and other configs just a `git clone`
away. Some of the techniques and code are based on concepts from
[this article](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th)
and the zillions of other dotfile repos on GitHub.

This mainly targets macOS, and assumes that zsh is the shell with something like oh-my-zsh or
zim underpinning it. This repo contains just my customizations on top of that.


## Gitting
### Prereqs:

- Get [homebrew](https://brew.sh)
- Get [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)  
OR  
- Get [zim](https://github.com/Eriner/zim)

If you don't have these, `make install` will grab them.


### Gitting
```
# go home
cd
# get project
git clone git@github.com:mattmc3/dotfiles.git ~/.dotfiles
# install
make install
```


## Project structure
- modules
Contains a folder for each type of configuration management. If these folders  
have a build.sh, install.sh, or uninstall.sh, that script is used in `make build`,  
`make install` and `make uninstall` respectively.

- runcom
    - Contains the run-command files for the home directory. These files are  
      symlinked to this project so that changes to the files are captured
      in git.
    - rc files
        - bash_profile
        - bashrc
        - zshrc

- scripts
All the shell scripts that make the dotfiles project go!


## How to use?

This project uses a makefile to do its work, because why not? Scripts are stored
in the _scripts_ directory if you'd prefer to not use `make`.

- Run `make help` for detals, but the main actions are:
    - `make build`
    - `make install`
    - `make uninstall`


## Modules

Modules are how we add functionality to our shell. If you don't use atom for example,
just remove the atom directory before running `make install` and those customizations
will no longer be part of the dotfiles.

I like the manta of "convention over configuration", so modules follow some rules to
make the dotfiles instal simple.

A module is simply a directory with some optional scripts:
- _build.sh_ : the script that will run when running `make build`. This is useful for
snapshotting system configs.
- _install.sh_ : the script that will run when running `make install`. This is how a
module would install itself - perhaps by symlinking a file into _$HOME_.
- _uninstall.sh_ : the script that will run when running `make uninstall`. This is how a
module would uninstall itself safely, undoing whatever was done during the _install.sh_
script.

Remember, these files are optional.

A module may also contain files that match the pattern _*rc.sh_, _*rc.bash_, or _*rc.zsh_.
These files are loaded automatically by _runcom/mainrc.sh_, _runcom/bashrc.bash_, or
_runcom/zshrc.zsh_ respectively.

### alfred

The alfred module has my encrypted data for my MFA workflow.
The workflow is available [here](https://github.com/mattmc3/alfred-workflow-gauth).

### atom

Atom stores its dot files in ~/.atom. The ones I want to keep are here to be
symlinked.

### autohotkey

This isn't a macOS config, but if I'm ever on Windows AHK makes it more tolerable
and I want a known place to find my AHK script.

### bin

It's handy to have a ~/bin folder in your path with scripts and such.

### brew

macOS and homebrew... like chocolate and peanut butter.

### cron

My crontab file.

Some of the jobs serve as a belt (Dropbox) and suspenders (git) approach to saving
my todo.txt and nvALT notes.

### git

Handy git extentions.

### iTerm

iTerm can save its config. This is where it goes.

### python

> you can't expect to wield supreme executive power just because some
> watery tart threw a sword at you.

### taskpaper

Simple. Effective. And now with syncing themes via dotfiles!

### tmux

Best. Terminal multiplexer. Evah.

### todotxt

I've tried them all. This is the system that works.

### vim

...or emacs...
