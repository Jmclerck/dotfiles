#!/bin/sh

# Copy RC files
cp terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
cp nanorc ~/.nanorc
cp zshrc ~/.zshrc

# brew utilities
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cowsay fasd fortune node python wget

# glances
pip install lolcat

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# gitster theme
wget https://raw.githubusercontent.com/shashankmehta/dotfiles/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme -O ~/.oh-my-zsh/custom/themes/gitster.zsh-theme

# powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Hack fonts
wget https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip -O hack.zip
unzip hack.zip
mv *.ttf ~/Library/Fonts/
rm hack.zip

exit
