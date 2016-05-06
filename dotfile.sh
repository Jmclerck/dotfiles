#!/bin/sh

if [ `uname` == 'Darwin' ] 
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install fasd wget

  # Atom
  cp -rf .atom ~/

  # iTerm
  cp -rf .iterm ~/
else if [ `uname` == 'Linux' ] 
then
  apt-get install git make
  git clone https://github.com/clvv/fasd.git
  cd fasd
  make install
fi
fi

# Powerline fonts
git clone https://github.com/powerline/fonts.git
pushd fonts
./install.sh
popd
rm -rf fonts

# Nano
cp .nanorc ~/

# Prezto 
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

GLOBIGNORE="README.md"
for f in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/; do
  ln -s "$f" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cp zpreztorc zprofile zshrc ~/.zprezto/runcoms/

chsh -s /bin/zsh

zsh
