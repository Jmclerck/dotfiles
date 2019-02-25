#!/bin/sh

brew bundle dump --force

code --list-extensions > vscode.extensions

npm ls -g --depth=0 --json=true |
  jq '.dependencies | keys' |
  sed -E 's/[^a-z\-]//g' |
  sed '/^$/d' > npm.modules

cp -r ~/.bash_it/enabled ./bash-it/

git add .
git status
