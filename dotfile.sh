#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew app casks
brew bundle

# node apps
npm install -g eslint lighthouse webpack vtop

# octicons font
wget https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf -O ~/Library/Fonts/octicons.ttf

# devicons
wget https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/devicons.ttf -O ~/Library/Fonts/icomoon.ttf

# oh-my-fish
curl -L http://get.oh-my.fish | fish

# Symlink RC files
rm ~/.nanorc
ln -s (PWD)/.nanorc ~
rm ~/.hyper.js
ln -s (PWD)/.hyper.js ~
rm ~/.config/fish/config.fish
ln -s (PWD)/fish/config.fish ~/.config/fish/config.fish
rm ~/.config/fish/functions
ln -s (PWD)/fish/functions ~/.config/fish/


# source ~/.config/fish/config.fish
# reset-launchpad

exit
