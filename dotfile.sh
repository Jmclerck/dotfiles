#!/bin/sh

if [ `uname` == 'Darwin' ] then
  # brew  
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  
  brew install android-sdk cmake fasd imagemagick wget
else if [ `uname` == 'Linux ] then
  # apt-get
  apt-get install git make
fi

# Nano
cp .nanorc ~/

# ZSH + Prezto 
zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh

cp .zpreztorc .zprofile .zshrc ~/.zprezto/runcoms

# fasd
git clone https://github.com/clvv/fasd.git
cd fasd
make install
