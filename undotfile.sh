#!/usr/bin/env bash

brew bundle dump --force

code --list-extensions > vscode.extensions

npm ls -g --depth=0 --json=true |
  jq '.dependencies | keys' |
  sed -E 's/[^a-z\-]//g' |
  sed '/^$/d' > npm.modules

source "$BASH_IT/bash_it.sh"

bash-it show alias |
  grep -Eo "\S*\s*\[x\]" |
  grep -o "[a-z\-]*" |
  sed '/^$/d' > bash-it.aliases

bash-it show completions |
  grep -Eo "\S*\s*\[x\]" |
  grep -o "[a-z\-]*" |
  sed '/^$/d' > bash-it.completions

bash-it show plugins |
  grep -Eo "\S*\s*\[x\]" |
  grep -o "[a-z\-]*" |
  sed '/^$/d' > bash-it.plugins

git add .
git status
