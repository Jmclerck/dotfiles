#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install fasd wget

# iTerm
cp -rf .iterm ~/

# Awesome Terminal Fonts Patched
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git
pushd awesome-terminal-fonts/patched
cp *.ttf ~/Library/Fonts
popd
rm -rf awesome-terminal-fonts

# Fira Mono
git clone https://github.com/mozilla/Fira.git
pushd Fira-master/ttf
cp *.ttf ~/Library/Fonts
popd
rm -rf Fira-master

# Nano
cp .nanorc ~/

# Oh-My-ZSH
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

cp zshrc ~/.zshrc
cp powerlevelrc ~/.powerlevelrc

chsh -s /bin/zsh

exit
