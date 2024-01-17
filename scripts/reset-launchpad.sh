echo "$(date '+%d-%m-%y %H:%M:%S') started with PID: $$"

defaults delete com.apple.dock
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock ResetLaunchPad -bool true
defaults write com.apple.dock wvous-bl-corner -int 14
defaults write com.apple.dock wvous-br-corner -int 5