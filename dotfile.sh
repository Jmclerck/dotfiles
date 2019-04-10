#!/usr/bin/env bash

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

# bash-it
if [[ ! -a ~/.bash_it ]]; then
  git clone https://github.com/Bash-it/bash-it.git ~/.bash_it
  ~/.bash_it/install.sh --no-modify-config --silent
fi

source "$BASH_IT/bash_it.sh"

# Copy WebIcons font (can't be symlinked, since macOS 10.13)
rm ~/Library/Fonts/webicons.ttf
ln -s "$(PWD)/bash-it/themes/font/webicons.ttf" ~/Library/Fonts/

# Symlink Bash/Bash-IT configuration
rm ~/.bash_profile
ln -s "$(PWD)/.bash_profile" ~

# Symlink Visual Studio Code settings
rm ~/Library/Application\ Support/Code/User/settings.json
ln -s "$(PWD)/code/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# Symlink Visual Studio Code snippets
rm -rf ~/Library/Application\ Support/Code/User/snippets
ln -s "$(PWD)/code/snippets" ~/Library/Application\ Support/Code/User/snippets

# Symlink Hyper preferences
rm ~/.hyper.js
ln -s "$(PWD)/.hyper.js" ~/.hyper.js

# disable all bash-it aliases, completions & plugins
bash-it disable alias all
bash-it completion alias all
bash-it disable plugin all

# enable bash-it aliases
for i in $(cat bash-it.aliases); do
  bash-it enable alias $i
done

# enable bash-it completions
for i in $(cat bash-it.completions); do
  bash-it enable completion $i
done

# enable bash-it plugins
for i in $(cat bash-it.plugins); do
  bash-it enable plugin $i
done

# remove existing vscode extensions
for i in $(code --list-extensions | comm -13 $(PWD)/vscode.extensions -); do
  code --uninstall-extension $i
done

# install vscode extensions
for i in $(cat vscode.extensions); do
  code --install-extension $i
done

#  install npm modules
for i in $(cat npm.modules); do
  npm i -g $i
done

# Add TouchID as sudo authentication method
touch ./sudo
sudo sed $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo > ./sudo
sudo chmod -w ./sudo
sudo chown root ./sudo
sudo mv /etc/pam.d/sudo /etc/pam.d/sudo~
sudo mv ./sudo /etc/pam.d/sudo
