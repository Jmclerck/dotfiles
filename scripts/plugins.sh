#!/usr/bin/env bash

source "$BASH_IT/bash_it.sh"

# disable all bash-it aliases, completions & plugins
bash-it disable alias all
bash-it disable completion all
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
