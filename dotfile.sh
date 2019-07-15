#!/usr/bin/env bash

# silence last login message
touch .hushlogin

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh --unattended)"

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# nvs
git clone https://github.com/jasongin/nvs "$HOME/.nvs"
. "$HOME/.nvs/nvs.sh" install

# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

for file in "symlinks" "plugins" "macOS" "tid" "builder"; do "./scripts/${file}.sh" &> /dev/null; done
