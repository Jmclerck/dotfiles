#!/usr/bin/env bash

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
