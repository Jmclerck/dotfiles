#!/bin/sh

# Symlink Terminal Preferences
rm ~/Library/Preferences/com.apple.Terminal.plist
ln -s "$(pwd)/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist

# Symlink RC files
ln -s "$(pwd)/.nanorc" ~/.nanorc
ln -s "$(pwd)/.zshrc" ~/.zshrc

# brew utilities
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cowsay fasd fortune node python tailor wget

# brew app casks
brew cask install docker google-chrome kaleidoscope parallels-desktop paw spectacle tower visual-studio-code

# glances
pip install lolcat

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# gitster theme
git clone https://github.com/Ranndom/gitster-theme.git ~/.oh-my-zsh/custom/themes/gitster.zsh-theme

# Hack fonts
wget https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip -O hack.zip
unzip hack.zip
mv *.ttf ~/Library/Fonts/
rm hack.zip

exit
