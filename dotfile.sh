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

for file in "symlinks" "plugins" "macOS" "tid"; do "./scripts/${file}.sh" &> /dev/null; done
