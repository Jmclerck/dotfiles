#!/bin/sh

brew bundle dump --force

code --list-extensions > vscode.ext

git add .
git status
