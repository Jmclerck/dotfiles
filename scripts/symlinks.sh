# Symlink zshrc configuration
rm ~/.zshrc 2&> /dev/null
ln -s "$(pwd)/.zshrc" ~


# Copy webicons font
rm ~/Library/Fonts/webicons.ttf 2&> /dev/null
cp "$(pwd)/oh-my-zsh/themes/webicons/font/webicons.ttf" ~/Library/Fonts/
