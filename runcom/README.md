# runcom

This folder represents shell runcom files (aka: dotfiles) that can be referenced
by the dotfiles symlinked in your `$HOME` directory. The symlinks are setup when
`make install` from this repo, and removed when running `make uninstall`. Files
in your home directory are typically required configs, so this directory
organizes the other imports you may be using.

# common

Example of myrc_local

```shell
MYNAME="John Doe"

CURRENT_HOSTNAME=`hostname -f`
CURRENT_HOSTNAME_MD5=`hostname -f | md5`
CURRENT_USERNAME=`id -un`
WORK_HOSTNAME_MD5="6accefe4a7ff62bd935f25a053c5fd3c"

HOME_USERNAME=fname
WORK_USERNAME=firstlast
WORK_DOMAIN_USERNAME="domain\\firstlast"

WORK_EMAIL=firstlast@dotfiles.com
HOME_EMAIL=fname@home.net

if [[ $CURRENT_HOSTNAME_MD5 = $WORK_HOSTNAME_MD5 ]]; then
    GIT_USERNAME=$MYNAME
    GIT_EMAIL=$WORK_EMAIL
else
    GIT_USERNAME=$HOME_USERNAME
    GIT_EMAIL=$HOME_EMAIL
fi

git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL
```

Example of .gitconfig_local

```properties
[user]
    name = John Doe
    email = john.doe@example.com
```
