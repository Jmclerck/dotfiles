# Symlink zshrc configuration
rm ~/.zshrc 2&> /dev/null
ln -s "$(pwd)/.zshrc" ~

# Copy webicons font
rm ~/Library/Fonts/webicons.ttf 2&> /dev/null
cp "$(pwd)/oh-my-zsh/themes/webicons/font/webicons.ttf" ~/Library/Fonts/

rm ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch 2&> /dev/null
ln -s "$(pwd)/iTerm2/AutoLaunch" ~/Library/Application\ Support/iTerm2/Scripts/