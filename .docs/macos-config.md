# MacOS setup

## Dotfiles

Some great dotfiles repos exist with good examples of MacOS configs.

- [pawelgrzybek](https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh)
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
- [geerlingguy](https://github.com/geerlingguy/dotfiles/blob/master/.osx)

## Initial setup

### Install Rosetta 2

On a new M1 Mac, Rosetta 2 will get you running with apps that are only compiled for Intel chipsets

```shell
softwareupdate --install-rosetta --agree-to-license
```

### Install XCode command line utilities

```shell
xcode-select --install
```

### XCode

```shell
sudo xcodebuild -license accept
```

### Homebrew

If you are on Apple Silicon (M1 ARM chipsets), you will need to install brew in a different location for native compilation. This may not always be true, but at the time of this writing it is.

To install homebrew for ARM:

```shell
# We'll be installing Homebrew in the /opt directory.
cd /opt

# Create a directory for Homebrew. This requires root permissions.
sudo mkdir homebrew

# Make us the owner of the directory so that we no longer require root permissions.
sudo chown -R $(whoami) /opt/homebrew

# Download and unzip Homebrew. This command can be found at https://docs.brew.sh/Installation.
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

# Add the Homebrew bin directory to the PATH. If you don't use zsh, you'll need to do this yourself.
echo "export PATH=/opt/homebrew/bin:$PATH" >> ${ZDOTDIR:-$HOME}/.zshrc
```

## Misc

### Screenshots

MacOS saves screenshots to inconvienent places and creates a lot of clutter. You can change your screenshot location with this command:

```shell
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
```

### GUI Editors

Some GUI editors can be launched via command line, but they need their binaries available in `$PATH`. One easy way to do that is to symlink the apps in your `~/bin` assuming that is in your `$PATH`

```shell
# sublime
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/bin

# vscode
ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ~/bin
```

## Desktop & Screen Saver

### Hot corners

Possible values:

- 0: no-op
- 2: Mission Control
- 3: Show application windows
- 4: Desktop
- 5: Start screen saver
- 6: Disable screen saver
- 7: Dashboard
- 10: Put display to sleep
- 11: Launchpad
- 12: Notification Center

```shell
# bottom right corner starts screen saver
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0
```

## Dock

Dock options are available [here][devicemanagement-dock].

```shell
# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Change minimize/maximize window effect from genie to scale
defaults write com.apple.dock mineffect -string "scale"

# move to left
defaults write com.apple.dock orientation left
```

Don’t show recent applications in Dock

```shell
defaults write com.apple.dock show-recents -bool false
```

## Keyboard

### Use key repeat for press-and-hold

MacOS handles pressing-and-holding of keys differently than I'd like. Instead of the default, let's change it to repeat the key being pressed.

```shell
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

Or, do this for individual apps

```shell
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

If you need to reset back to default:

``` shell
defaults delete -g ApplePressAndHoldEnabled
```

### Speed

You can speed up key repeats with the following commands

```shell
# normal minimum is 15 (225 ms)
defaults write -g InitialKeyRepeat -int 35

# normal minimum is 2 (30 ms)
defaults write -g KeyRepeat -int 2
```

## Fonts

Not sure why, but Mojave font rendering was terrible on external monitors. This was the fix

```shell
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

## Finder

Show Path Bar

```shell
defaults write com.apple.finder ShowPathbar -bool true
```

Modify the Finder sidebar with the [mysides] app.

```shell
brew install --cask mysides
mysides list
mysides add example file:///Users/Shared/example
```

Keep folders on top when sorting by name

```shell
defaults write com.apple.finder _FXSortFoldersFirst -bool true
```

## Finalize setup

In order to reset apps whose settings are changed, run this script:

```shell
macapps=(
    "Activity Monitor"
    "Address Book"
    "Calendar"
    "cfprefsd"
    "Contacts"
    "Dock"
    "Finder"
    "Mail"
    "Messages"
    "Photos"
    "Safari"
    "SystemUIServer"
    "Terminal"
    "iCal"
)
for app in $macapps; do
    killall "${app}" &> /dev/null
done
```

[devicemanagement-dock]: https://developer.apple.com/documentation/devicemanagement/dock
[mysides]: https://github.com/mosen/mysides
