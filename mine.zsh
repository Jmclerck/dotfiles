# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

ZSH_THEME="zeit"

plugins=(brew docker docker-compose git thefuck node npm osx z)

function cls() {
	clear
}

function reset-dock() {
	defaults delete com.apple.dock; killall Dock
}

function reset-launchpad() {
	defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
}

eval $(thefuck --alias)

. ~/.oh-my-zsh/custom/particle.zsh
. ~/.oh-my-zsh/plugins/z/z.sh
