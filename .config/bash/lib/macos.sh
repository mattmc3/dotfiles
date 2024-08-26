#!/usr/bin/env bash

# Check requirements.
[[ "$OSTYPE" == darwin* ]] || return 1

##? cdf - Change to the current Finder directory.
function cdf() {
  cd "$(pfd)" || return
}

##? flushdns - Flush the DNS cache.
function flushdns() {
  dscacheutil -flushcache && sudo killall -HUP mDNSResponder
}

##? hidefiles - Hide hidden dotfiles in Finder.
function hidefiles() {
  defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder
}

##? showfiles - Show hidden dotfiles in Finder.
function showfiles() {
  defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder
}

##? lmk - Have Siri let me know when a process is complete.
function lmk() {
  # eg: sleep 2 && lmk
  say "${*:-Process complete}"
}

##? manp - read man page with Preview.app
function manp() {
  # https://scriptingosx.com/2022/11/on-viewing-man-pages-ventura-update/
  if [[ $# -eq 0 ]]; then
    echo >&2 'manp: You must specify the manual page you want'
    return 1
  fi
  mandoc -T pdf "$(/usr/bin/man -w "$*")" | open -fa Preview
}

##? ofd - Open the current directory in Finder
function ofd() {
  open "$PWD"
}

##? peek - Take a quick look at a file using an appropriate viewer
function peek() {
  [[ $# -gt 0 ]] && qlmanage -p "$*" &>/dev/null &
}

##? pfd - Print the frontmost Finder directory.
function pfd() {
  osascript 2> /dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of first window as text)
    end tell
EOF
}

##? pfs - Print the current Finder selection
function pfs() {
  osascript 2>&1 <<EOF
    tell application "Finder" to set the_selection to selection
    if the_selection is not {}
      repeat with an_item in the_selection
        log POSIX path of (an_item as text)
      end repeat
    end if
EOF
}

##? pushdf - Push the current Finder directory to the dirstack.
function pushdf() {
  pushd "$(pfd)" || return
}

##? rmdsstore - Remove .DS_Store files recursively in a directory.
function rmdstore() {
  find "${*:-.}" -type f -name .DS_Store -delete
}
