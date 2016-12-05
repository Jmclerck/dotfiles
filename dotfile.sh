#!/bin/sh

# brew utilities
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install autojump cowsay fortune gawk node python wget

# brew app casks
    brew cask install atom docker google-chrome hyper java kaleidoscope parallels-desktop paw spectacle tower

# tailor depends on java being installed first
    brew install tailor

# glances
    pip install lolcat

# trans
    wget git.io/trans /usr/local/bin/trans
    chmod +x /usr/local/bin/trans

# node apps
    npm install -g now yarn vtop

# oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# gitster theme
    git clone https://github.com/Ranndom/gitster-theme.git ~/.oh-my-zsh/custom/themes

# Hack fonts
    wget https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip -O hack.zip
    unzip hack.zip
    mv *.ttf ~/Library/Fonts/
    rm hack.zip

# Symlink Terminal Preferences
    rm ~/Library/Preferences/com.apple.Terminal.plist
    ln -s "$(pwd)/com.apple.Terminal.plist" ~/Library/Preferences/com.apple.Terminal.plist

# Symlink RC files
    ln -s "$(pwd)/.nanorc" ~/.nanorc
    ln -s "$(pwd)/zshrc.zsh" ~/.oh-my-zsh/custom/zshrc.zsh

exit
