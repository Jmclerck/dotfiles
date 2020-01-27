#!/bin/sh

#  builder.sh
#  
#
#  Created by Jonathan Clerck on 27/01/2020.
#  

echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.edilis.percentage</string>

  <key>ProgramArguments</key>
  <array>
    <string>$(pwd)/scripts/percentage.sh</string>
    <string>$(pwd)/logs</string>
  </array>

  <key>StartInterval</key>
  <integer>30</integer>

  <key>RunAtLoad</key>
  <true/>

  <key>StandardErrorPath</key>
  <string>$(pwd)/logs/percentage.err</string>

  <key>StandardOutPath</key>
  <string>$(pwd)/logs/percentage.out</string>
</dict>
</plist>" > com.edilis.percentage.plist

pushd ~/Library/LaunchAgents &> /dev/null
launchctl unload com.edilis.percentage.plist 2&> /dev/null
popd &> /dev/null

rm ~/Library/LaunchAgents/com.edilis.percentage.plist 2&> /dev/null
ln -s "$(pwd)/com.edilis.percentage.plist" ~/Library/LaunchAgents/com.edilis.percentage.plist

pushd ~/Library/LaunchAgents &> /dev/null
launchctl load com.edilis.percentage.plist
popd &> /dev/null
