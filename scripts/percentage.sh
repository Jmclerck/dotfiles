#!/usr/bin/env bash

percent=$(pmset -g batt | /usr/local/bin/rg -o "[0-9]*%" | /usr/local/bin/rg -o "[0-9]*")
percentShown=$(defaults read com.apple.menuextra.battery ShowPercent)

# cleanup logs
find $1 -maxdepth 1 -name "*.out" -type file -size +250k -delete
find $1 -maxdepth 1 -name "*.err" -type file -size +250k -delete

if [[ $percent -lt 20 ]]; then
  if [[ $percentShown == 0 || $percentShown == "NO" || $percentShown == false ]]; then
    defaults write com.apple.menuextra.battery ShowPercent -bool true
    killall SystemUIServer
  fi
else
  if [[ $percentShown == 1 || $percentShown == "YES" || $percentShown == true ]]; then
    defaults write com.apple.menuextra.battery ShowPercent -bool false
    killall SystemUIServer
  fi
fi

echo "`date` | Percentage: $percent - shown: $percentShown"
