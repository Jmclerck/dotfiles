#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew app casks
brew bundle

# node apps
npm install -g vtop

# zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Make a custom themes folder, if it doesn't already exist
if [[ ! -a ~/.oh-my-zsh/custom/themes ]]; then
  mkdir ~/.oh-my-zsh/custom/themes
fi

# Symlink RC files
rm ~/.nanorc
ln -s $(PWD)/.nanorc ~
rm ~/.hyper.js
ln -s $(PWD)/.hyper.js ~
rm ~/.oh-my-zsh/custom/mine.zsh
ln -s $(PWD)/mine.zsh ~/.oh-my-zsh/custom
rm ~/.oh-my-zsh/custom/themes/zeit.zsh-theme
ln -s $(PWD)/zeit.zsh-theme ~/.oh-my-zsh/custom/themes
rm ~/Library/Fonts/icomoon.ttf
ln -s $(PWD)/font/icomoon.ttf ~/Library/Fonts/

# execute reset-launchpad
/bin/zsh -c 'source ~/.zshrc; reset-launchpad'

exit
