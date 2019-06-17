#!/usr/bin/env bash

# silence last login message
touch .hushlogin

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh --unattended)"

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

for file in "symlinks" "plugins" "macOS" "tid"; do "./scripts/${file}.sh" &> /dev/null; done
