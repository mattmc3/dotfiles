#!/usr/bin/env zsh

# dotfiles references
# https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://github.com/geerlingguy/dotfiles/blob/master/.osx


# --- General ---
# install xcode command line tools
xcode-select --install

# rosetta 2 for intel chipset apps on the M1
softwareupdate --install-rosetta --agree-to-license


# --- Symlinks ---
# sublime
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/bin

# vscode
ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ~/bin


# --- Dock ---
# https://developer.apple.com/documentation/devicemanagement/dock

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Change minimize/maximize window effect from genie to scale
defaults write com.apple.dock mineffect -string "scale"

# move to left
defaults write com.apple.dock orientation left


# --- Keyboard ---
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Or, do this for individual apps
# defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
# defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# if you need to reset back to default
# defaults delete -g ApplePressAndHoldEnabled

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)


# --- Folders ---
# Save screenshots to the downloads
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"


# --- Desktop & Screen Saver ---
# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0


# --- Misc ---
# why does Mojave font rendering suck on external monitors? FixedIt!
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO


# --- Finder Preferences ---
# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true


# --- Accessibility ---
# Accessibility > Display > Cursor : Increase pointer size
sudo defaults write com.apple.universalaccess mouseDriverCursorSize 1.8


# --- Security & Privacy
# Turn Firewall on
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1


# --- Restart affected apps ---

for app in \
  "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Mail" \
  "Messages" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "Terminal" \
  "iCal"; do
  killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
