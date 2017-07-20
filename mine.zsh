# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

ZSH_THEME="web"

plugins=(brew docker docker-compose git thefuck node npm osx z)

alias reset-dock="defaults delete com.apple.dock; killall Dock"
alias reset-launchpad="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias vtop="vtop --theme acid"

eval $(thefuck --alias)
ssh-add -K ~/.ssh/id_rsa 2>/dev/null
source <(npx --shell-auto-fallback zsh)

. ~/.oh-my-zsh/plugins/z/z.sh
