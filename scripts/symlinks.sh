#!/bin/sh

# Symlink & Copy configuration and data files

ln -sf "$(pwd)/.zshrc" ~

ln -sf "$(pwd)/iTerm2/AutoLaunch" ~/Library/Application\ Support/iTerm2/Scripts/

cp "$(pwd)/oh-my-zsh/themes/webicons/font/webicons.ttf" ~/Library/Fonts/