# Dotfiles

## Intro
This repo is for making sure my *nix dot files and other configs are just a `git clone`
away. Some of the techniques and code are based on concepts from
[this article](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th)
and the zillions of other dotfile repos on GitHub.

## Philosophy
A lot of dofiles repos use sophisticated symlinking strategies or make heavy use of GNU stow.
I tried that method, but cluttering my box with symlinks never quite felt quite right. I
wanted to manage the files where they really live, not in my repo. Iwanted something simpler.
And at the same time something more porwerful. I needed `rsync`.

So few dotfiles repos harness the power of `rsync`. At its core, all the scripting and structure
of this repo can be broken down into one command for dotfile management:

```
# to backup
rsync -acv --include-from="filter.lst" "$HOME/" "$HOME/.dotfiles/settings/home/"

# to restore
rsync -avI --exclude=".DS_Store" "$HOME/.dotfiles/settings/home/" "$HOME/"
```

Now, in addition to dotfiles, I also wanted to manage saving off `pip` installs, my `Brewfile`,
my VSCode plugins, my crontab and other things that aren't strictly dotfiles. I also secure my
sensitive files with PGP encryption so that I can be confortable putting everything up into
a public repo. But despite all the extras, you can clone this repo yourself and strip it down
to a simple, elegant `rsync` dotfiles repo of your very own.

## git-ing
### Prereqs:

- Get GPG and create a key pair to encrypt your files
- Get [homebrew](https://brew.sh)
- Get [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

If you don't have these, `make init` will grab them.


### git
```
# go home
cd

# get project
git clone git@github.com:mattmc3/dotfiles.git ~/.dotfiles

# restore
make restore

# or... set up new
make clean
make init
make backup
```

### !!! WARNING !!!
`make restore` is currently a *destructive opertation*. **Backup your home directory
before using this project.** Unless you're me, and then this is really the homedir you
always wanted <3 <3 <3).

## Project structure
- **docs** : My notes
- **scripts** : bash scripts to handle backup / restore operations
- **scripts/_dir_** : a module for a specific type of backup / restore
- **settings** : The location of dotfiles backups
- **settings/home** : rsync-ed files and dirs off my $HOME
- **settings/home/.config/shell** : My shell customizations.
    - Note that these are backups from rsync, not the master files like with other dotfiles repos.
- **settings/misc** : Other backups such as my Brewfile, `pip freeze` files, etc.

## How to use?

This project uses a makefile to do its work, because why not? Scripts are stored
in the _scripts_ directory if you'd prefer to not use `make`.

- Run `make help` for detals, but the main actions are:
    - `make backup`
    - `make restore`

## Modules

Modules are how we add functionality to our dotfiles backups/restores. If you don't
use Atom for example, just comment out `atom` from backup_modules in backup.sh before
running `make backup` and those customizations will no longer be part of the dotfiles
backups.

I like the manta of "convention over configuration", so modules follow some rules to
make the dotfiles install simple.

A module is simply a directory with some optional scripts:
- _backup.sh_ : the script that will run when running `make backup`. This is useful for
snapshotting system configs or making snapshots of pip installs, etc.
- _restore.sh_ : the script that will run when running `make restore`. This is how a
module would restore itself back to the system - perhaps by symlinking a file into _$HOME_
or redownloading Atom extentions.

Remember, these files are all optional.

## Smarty pants

Want to be a smarty pants? Run a cron job that does `make backup` followed by a `git add . && git commit -m 'checkin'`
every so often to ensure you always have a good backup.

### atom

Atom stores its dot files in ~/.atom. The dotfiles module picks those up, but
the atom module picks up the apm extentions.

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

I've tried them all. This is a system that works. That, and Taskpaper.

### vscode

Just because MS can't make a decent OS, doesn't mean they can't make great dev tools.
