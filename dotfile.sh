# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

for file in "symlinks" "plugins" "macOS" "tid"; do "./scripts/${file}.sh" &> /dev/null; done
# antibody
antibody bundle < Antibodyfile > ~/.zsh_plugins.sh

for file in "symlinks" "plugins" "macOS" "touch"; do "./scripts/${file}.sh" &> /dev/null; done
