#!/bin/sh

# fake ZSH shell to avoid context switch mid script
export SHELL="zsh"

# brew utilities
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew app casks
brew bundle

# glances
pip install lolcat

# trans
wget git.io/trans -O /usr/local/bin/trans
chmod +x /usr/local/bin/trans

# node apps
npm install -g eslint yarn webpack vtop

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# gitster theme
git clone https://github.com/Jmclerck/gitster-theme.git ~/.oh-my-zsh/custom/themes/gister

# octicons font
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf -O ~/Library/Fonts/octicons.ttf

# Symlink Terminal Preferences
rm ~/Library/Preferences/com.apple.Terminal.plist
ln -s "$(pwd)/com.apple.Terminal.plist" ~/Library/Preferences/com.apple.Terminal.plist

# Symlink RC files
rm ~/.nanorc
ln -s "$(pwd)/.nanorc" ~/.nanorc
rm ~/.oh-my-zsh/custom/zshrc.zsh
ln -s "$(pwd)/zshrc.zsh" ~/.oh-my-zsh/custom/zshrc.zsh

defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock

# Tap to Click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

chsh -s /bin/zsh

exit
