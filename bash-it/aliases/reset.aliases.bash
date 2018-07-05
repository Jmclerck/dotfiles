function reset-dock() {
  defaults delete com.apple.dock; killall Dock
}

function reset-launchpad() {
  defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
}