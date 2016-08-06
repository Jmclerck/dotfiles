#!/bin/sh

# Copy RC files
cp terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
cp nanorc ~/.nanorc
cp zshrc ~/.zshrc
cp powerlevelrc ~/.powerlevelrc

# brew utilities
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cowsay fasd python wget

# glances
pip install glances

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Hack fonts
wget https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip -O hack.zip
unzip hack.zip
mv *.ttf ~/Library/Fonts/
rm hack.zip

exit
