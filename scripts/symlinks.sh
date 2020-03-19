# Symlink zshrc configuration
rm ~/.zshrc 2&> /dev/null
ln -s "$(pwd)/.zshrc" ~

# Copy webicons font

ln -sf "$(pwd)/.zshrc" ~

ln -sf "$(pwd)/iTerm2/AutoLaunch" ~/Library/Application\ Support/iTerm2/Scripts/

cp "$(pwd)/oh-my-zsh/themes/webicons/font/webicons.ttf" ~/Library/Fonts/