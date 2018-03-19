#!/bin/sh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

# zsh
if [[ ! -a ~/.oh-my-zsh/custom/themes ]]; then
  0> /dev/null sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

# Make a custom themes folder, if it doesn't already exist
if [[ ! -a ~/.oh-my-zsh/custom/themes ]]; then
  mkdir ~/.oh-my-zsh/custom/themes
fi

# Symlink config files
rm ~/.nanorc
ln -s "$(PWD)/.nanorc" ~
rm ~/.hyper.js
ln -s "$(PWD)/.hyper.js" ~
rm ~/.oh-my-zsh/custom/mine.zsh
ln -s "$(PWD)/mine.zsh" ~/.oh-my-zsh/custom
rm ~/.oh-my-zsh/custom/themes/webicons.zsh-theme
ln -s "$(PWD)/webicons.zsh-theme/webicons.zsh-theme" ~/.oh-my-zsh/custom/themes
rm ~/Library/Fonts/webicons.ttf
ln -s "$(PWD)/webicons.zsh-theme/font/webicons.ttf" ~/Library/Fonts/
rm ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json
ln -s "$(PWD)/code/settings.json" ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json
rm -rf ~/Library/Application\ Support/Code\ -\ Insiders/User/snippets
ln -s "$(PWD)/code/snippets" ~/Library/Application\ Support/Code\ -\ Insiders/User/snippets

# execute reset-launchpad
/bin/zsh -c 'source ~/.zshrc; reset-launchpad'

# remove vscode extensions
/bin/zsh -c 'for i in $(code-insiders --list-extensions | comm -13 ~/Documents/Github/dotfiles/vscode.ext -); do; code --uninstall-extension $i; done'

# install vscode extensions
/bin/zsh -c 'for i in $(cat vscode.ext); do; code-insiders --install-extension $i; done'

zsh
