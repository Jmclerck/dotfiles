#!/bin/sh

# brew utilities
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew app casks
    brew bundle

# glances
    pip install lolcat

# trans
    wget git.io/trans /usr/local/bin/trans
    chmod +x /usr/local/bin/trans

# node apps
    npm install -g eslint yarn webpack vtop

# oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# gitster theme
    git clone https://github.com/Jmclerck/gitster-theme.git ~/.oh-my-zsh/custom/themes/gitster.zsh-theme

# Symlink Terminal Preferences
    rm ~/Library/Preferences/com.apple.Terminal.plist
    ln -s "$(pwd)/com.apple.Terminal.plist" ~/Library/Preferences/com.apple.Terminal.plist

# Symlink RC files
    ln -s "$(pwd)/.nanorc" ~/.nanorc
    ln -s "$(pwd)/zshrc.zsh" ~/.oh-my-zsh/custom/zshrc.zsh

exit
