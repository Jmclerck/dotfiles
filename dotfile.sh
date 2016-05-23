#!/bin/sh

if [ `uname` == 'Darwin' ] 
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install fasd wget

  # iTerm
  cp -rf .iterm ~/

  # VS Code  
  cp -rf .vscode ~/

  ## Link local settings.json to correct location
  ln -s ~/.vscode/settings.json ~'/Library/Application Support/Code/User/settings.json'
else if [ `uname` == 'Linux' ] 
then
  apt-get install git make
  git clone https://github.com/clvv/fasd.git
  cd fasd
  make install

  # VS Code
  cp -rf .vscode $HOME/

  ## Link local settings.json to correct location
  ln -s $HOME/.vscode/settings.json $HOME/.config/Code/User/settings.json
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

shopt -s extglob
for f in ~/.zprezto/runcoms/!(README.md); do 
  ln -s $f $HOME/.$(basename $f)
done

cp zpreztorc zprofile zshrc ~/.zprezto/runcoms/

chsh -s /bin/zsh

exit
