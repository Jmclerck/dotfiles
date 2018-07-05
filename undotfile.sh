#!/bin/sh

brew bundle dump --force

code --list-extensions > vscode.ext

cp ~/Library/Preferences/com.apple.Terminal.plist .

cp -r ~/.bash_it/enabled ./bash-it/

git add .
git status
