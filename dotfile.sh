#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# brew app casks
brew bundle

# octicons
wget https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf -O ~/Library/Fonts/octicons.ttf

# Symlink RC files
rm ~/.nanorc
ln -s (PWD)/.nanorc ~
rm ~/.hyper.js
ln -s (PWD)/.hyper.js ~
rm ~/.oh-my-zsh/custom/mine.zsh
ln -s (PWD)/mine.zsh ~/.oh-my-zsh/custom

# execute reset-launchpad
/bin/zsh -c 'source ~/.zshrc; reset-launchpad'

exit
