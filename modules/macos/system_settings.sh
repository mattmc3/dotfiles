# Sensible macOS defaults
# Based on https://github.com/jedrichards/dotfiles/blob/master/.osx
# Based on https://github.com/higgis/dotfiles/blob/master/.osx

# disable the caps lock key on the internal keyboard
defaults write 'com.apple.keyboard.modifiermapping.1452-566-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'

# disable the caps lock key on external keyboards
defaults write 'com.apple.keyboard.modifiermapping.1452-544-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'
