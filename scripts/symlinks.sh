#!/usr/bin/env bash

# Copy WebIcons font (can't be symlinked, since macOS 10.13)
rm ~/Library/Fonts/webicons.ttf
ln -s "$(PWD)/bash-it/themes/font/webicons.ttf" ~/Library/Fonts/


# Symlink Visual Studio Code settings
rm ~/Library/Application\ Support/Code/User/settings.json
ln -s "$(PWD)/code/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# Symlink Visual Studio Code snippets
rm -rf ~/Library/Application\ Support/Code/User/snippets
ln -s "$(PWD)/code/snippets" ~/Library/Application\ Support/Code/User/snippets

# Symlink Hyper preferences
rm ~/.hyper.js
ln -s "$(PWD)/.hyper.js" ~/.hyper.js
