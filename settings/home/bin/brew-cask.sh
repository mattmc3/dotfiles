#!/bin/bash
#
# brew-cask.sh
# latest source: https://github.com/eduncan911/dotfiles/blob/master/bin/brew-cask.sh
# author: https://eduncan911.github.io
#
# a simple utility to list homebrew CASK packages that have
# been updated, and also provide a way to force upgrade of
# those packages.
#
# cask does not have a proper upgrade path for packages like 
# Linux OS package managers have.  therefore, we have to take 
# unusual steps to upgrade packages that are managed by cask.
#
# the "unusual step" being, --force install of the updated cask.
#
# Installation:
#  $ curl -L https://raw.githubusercontent.com/eduncan911/dotfiles/master/bin/brew-cask.sh --create-dirs -o ~/bin/brew-cask.sh
#  $ chmod 755 bin/brew-cask
#
# Usage:
#
#  $ brew update
#    You should execute this first to update everything locally.
#
#  $ brew-cask.sh [update]
#    This will list all of your cask packages and rather there is an upgrade
#    pending with a ✔ checkmark, just like Homebrew does with "brew update".
#    The update command is optional, as it doesn't actually do any tracking, there's
#    not really anything to "update" with cask.  But it keeps with the pattern of
#    of Homebrew's "brew update" pattern for those with memory muscle fingers (like me).
#
#  $ brew-cask.sh upgrade
#    This performs a "brew cask install <cask> --force" of all cask packages that have
#    an update pending.
#
# This code was inspired by http://stackoverflow.com/a/36000907/56693

# get the list of installed casks
casks=( $(brew cask list) )

if [[ "$1" == "upgrade" ]]; then
  for cask in ${casks[@]}; do
    current="$(brew cask info $cask | sed -n '1p' | sed -n 's/^.*: \(.*\)$/\1/p')"
    installed=( $(ls /usr/local/Caskroom/$cask))
    if (! [[ " ${installed[@]} " == *" $current "* ]]); then
      echo "Upgrading $cask to v$current."
      (set -x; brew cask install $cask --force;)
    else
      echo "$cask v$current is up-to-date, skipping."
    fi
  done
else
  echo "Inspecting ${#casks[@]} casks. Use 'brew-cask.sh upgrade' to perform any updates."
  for (( i = i ; i < ${#casks[@]} ; i++ )); do
    current="$(brew cask info ${casks[$i]} | sed -n '1p' | sed -n 's/^.*: \(.*\)$/\1/p')"
    installed=( $(ls /usr/local/Caskroom/${casks[$i]}))
    if (! [[ " ${installed[@]} " == *" $current "* ]]); then
      casks[$i]="${casks[$i]}$(tput sgr0)$(tput setaf 2) ✔$(tput sgr0)"
    fi
  done
  echo " ${casks[@]/%/$'\n'}" | column
fi

