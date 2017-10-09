# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

ZSH_THEME="webicons"

plugins=(brew docker docker-compose git thefuck node npm osx z)

function brew() {
	if [[ $1 == 'update' ]]; then
	  command brew update
	else
		command brew $@
	fi
}

function hitop() {
  pushd /usr/local/lib/node_modules/vtop/themes &> /dev/null
  local files=($(find -E . -type f -regex ".*\.json"))
  local selection=${files[$(( $RANDOM % ${#files[@]} + 1 ))]}
  popd &> /dev/null
  vtop --theme $(echo $selection | cut -d / -f 2 | cut -d . -f 1) || vtop
}

alias reset-dock="defaults delete com.apple.dock; killall Dock"
alias reset-launchpad="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

eval $(thefuck --alias)
ssh-add -K ~/.ssh/id_rsa 2>/dev/null
source <(npx --shell-auto-fallback zsh)

. ~/.oh-my-zsh/plugins/z/z.sh
