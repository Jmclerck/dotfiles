# Symlink zshrc configuration
rm ~/.zshrc 2&> /dev/null
ln -s "$(pwd)/.zshrc" ~

# Symlink vscode settings
rm ~/Library/Application\ Support/Code/User/settings.json 2&> /dev/null
ln -s "$(pwd)/code/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# Symlink vscode snippets
rm -rf ~/Library/Application\ Support/Code/User/snippets 2&> /dev/null
ln -s "$(pwd)/code/snippets" ~/Library/Application\ Support/Code/User/snippets

# Copy webicons font
rm ~/Library/Fonts/webicons.ttf 2&> /dev/null
cp "$(pwd)/oh-my-zsh/themes/webicons/font/webicons.ttf" ~/Library/Fonts/
