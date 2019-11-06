# Copy WebIcons font (can't be symlinked, since macOS 10.13)
rm ~/Library/Fonts/webicons.ttf 2&> /dev/null
ln -s "$(pwd)/bash-it/themes/font/webicons.ttf" ~/Library/Fonts/

# Symlink zshrc configuration
rm ~/.zshrc 2&> /dev/null
ln -s "$(pwd)/.zshrc" ~

# Symlink Visual Studio Code settings
rm ~/Library/Application\ Support/Code/User/settings.json 2&> /dev/null
ln -s "$(pwd)/code/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# Symlink Visual Studio Code snippets
rm -rf ~/Library/Application\ Support/Code/User/snippets 2&> /dev/null
ln -s "$(pwd)/code/snippets" ~/Library/Application\ Support/Code/User/snippets

# Symlink Hyper preferences
rm ~/.hyper.js 2&> /dev/null
ln -s "$(pwd)/.hyper.js" ~/.hyper.js
