#!/bin/sh

brew bundle dump --force

code-insiders --list-extensions > vscode.ext

git add .
git status
