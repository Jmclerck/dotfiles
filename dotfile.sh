#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install Node manager
curl -L https://git.io/n-install | bash

# install latest Node
n latest

# brew app casks
brew bundle

# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# node apps
npm install -g eslint lighthouse nodengine webpack vtop

# octicons font
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf -O ~/Library/Fonts/octicons.ttf

# devicons
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/icomoon.ttf
~/Library/Fonts/icomoon.ttf

/usr/local/bin/fish

# oh-my-fish
curl -L http://get.oh-my.fish | fish

# Symlink RC files
rm ~/.nanorc
ln -s (PWD)/.nanorc ~
rm ~/.hyper.js
ln -s (PWD)/.hyper.js ~
rm ~/.config/fish/config.zsh
ln -s (PWD)/fish/config.fish ~/.config/fish
rm ~/.config/fish/functions
ln -s (PWD)/fish/functions ~/.config/fish/

source ~/.config/fish/config.fish

reset-launchpad
reset-dock
greeting

exit
