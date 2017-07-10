#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew app casks
brew bundle

# node apps
npm install -g vtop

# octicons font
wget https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf -O ~/Library/Fonts/octicons.ttf

# zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Symlink RC files
rm ~/.nanorc
ln -s $(PWD)/.nanorc ~
rm ~/.hyper.js
ln -s $(PWD)/.hyper.js ~
rm ~/.oh-my-zsh/custom/mine.zsh
ln -s $(PWD)/mine.zsh ~/.oh-my-zsh/custom
mkdir ~/.oh-my-zsh/custom/themes
ln -s $(PWD)/zeit.zsh-theme ~/.oh-my-zsh/custom/themes

# execute reset-launchpad
/bin/zsh -c 'source ~/.zshrc; reset-launchpad'

exit
