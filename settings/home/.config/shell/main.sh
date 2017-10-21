# Common settings

source "$HOME/.config/shell/secrets.sh"
source "$HOME/.config/shell/exports.sh"
source "$HOME/.config/shell/aliases.sh"
source "$HOME/.config/shell/functions.sh"
source "$HOME/.config/shell/prompt.sh"
source "$HOME/.config/shell/local.sh"

################################################################################
# Misc

# gpg
# eval $(gpg-agent --daemon --allow-preset-passphrase)

# add ssh key
ssh-add ~/.ssh/id_rsa &> /dev/null

# z is an awesome utility for remembering paths
if [ -e `brew --prefix`/etc/profile.d/z.sh ]; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

################################################################################
# sourcing

# .myenv secrets
if [[ -f $HOME/.localrc ]] ; then
    . $HOME/.localrc
fi

# source modules
find $DOTFILES/modules -name "*rc.sh" | while read file; do
    . $file
done
