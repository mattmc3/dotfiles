# Show/hide hidden files in Finder
alias show.hiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide.hiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hide.desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias show.desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
