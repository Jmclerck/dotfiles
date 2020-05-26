# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle cleanup --force
brew bundle

# antibody
antibody bundle < Antibodyfile > ~/.zsh_plugins.sh

# aliases
cat Aliasfile > ~/.zsh_aliases.sh

# logs directory
mkdir logs
# zshrc
ln -sf "$(pwd)/.zshrc" ~

for file in "builder" "macOS" "touch"; do "./scripts/${file}.sh" &> /dev/null; done
