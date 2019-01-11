#!/bin/sh

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

# Symlink Bash/Bash-IT configuration
rm ~/.bash_profile
ln -s "$(PWD)/.bash_profile" ~

# Symlink nano configuration
rm ~/.nanorc
ln -s "$(PWD)/.nanorc" ~

# Symlink Visual Studio Code settings
rm ~/Library/Application\ Support/Code/User/settings.json
ln -s "$(PWD)/code/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# Copy Terminal preferences (can't be symlinked)
rm ~/Library/Preferences/com.apple.Terminal.plist
cp com.apple.Terminal.plist ~/Library/Preferences

# Copy WebIcons font (can't be symlinked, since macOS 10.13)
rm ~/Library/Fonts/webicons.ttf
ln -s "$(PWD)/bash-it/themes/font/webicons.ttf" ~/Library/Fonts/

# Symlink Visual Studio Code snippets
rm -rf ~/Library/Application\ Support/Code/User/snippets
ln -s "$(PWD)/code/snippets" ~/Library/Application\ Support/Code/User/snippets

# Copy enabled bash-it plugins (can't be symlinked)
rm -rf ~/.bash_it/enabled
cp -r "$(PWD)/bash-it/enabled" ~/.bash_it

# Add webicons to monospace font fallbacks
sudo /usr/libexec/PlistBuddy -c "Add monospace:0 string 'webicons'" /System/Library/Frameworks/CoreText.framework/Versions/A/Resources/DefaultFontFallbacks.plist

# Add TouchID as sudo authentication method
touch ./sudo
sudo sed $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo > ./sudo
sudo chmod -w ./sudo
sudo chown root ./sudo
sudo mv /etc/pam.d/sudo /etc/pam.d/sudo~
sudo mv ./sudo /etc/pam.d/sudo

# remove existing vscode extensions
for i in $(code --list-extensions | comm -13 $(PWD)/vscode.extensions -); do
  code --uninstall-extension $i
done

# install expected vscode extensions
for i in $(cat vscode.extensions); do
  code --install-extension $i
done

#  install npm modules
for i in $(cat npm.modules); do
  npm i -g $i
done
