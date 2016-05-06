#!/bin/sh

if [ `uname` == 'Darwin' ] 
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install fasd wget
else if [ `uname` == 'Linux' ] 
then
  apt-get install git make
  git clone https://github.com/clvv/fasd.git
  cd fasd
  make install
fi
fi

# Nano
cp .nanorc ~/

# Prezto 
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cp zpreztorc zprofile zshrc ~/.zprezto/runcoms/

chsh -s /bin/zsh
