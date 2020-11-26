#!/usr/bin/env bash

# .macos: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Or, do this for individual apps
# defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
# defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# # reset back to default
# defaults delete -g ApplePressAndHoldEnabled

# Save screenshots to the downloads
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

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

# why does Mojave font rendering suck on external monitors? FixedIt!
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
