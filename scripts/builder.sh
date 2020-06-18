#!/bin/sh

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
  <key>Label</key>
  <string>io.jclerck.percentage</string>

  <key>ProgramArguments</key>
  <array>
    <string>$(pwd)/scripts/percentage.sh</string>
    <string>$(pwd)</string>
  </array>

  <key>StartInterval</key>
  <integer>30</integer>

  <key>RunAtLoad</key>
  <true/>

  <key>StandardErrorPath</key>
  <string>$(pwd)/percentage.err</string>

  <key>StandardOutPath</key>
  <string>$(pwd)/percentage.out</string>
</dict>
</plist>" > io.jclerck.percentage.plist

launchctl unload io.jclerck.percentage.plist 2&> /dev/null
rm ~/Library/LaunchAgents/io.jclerck.percentage.plist 2&> /dev/null

mv -f "$(pwd)/io.jclerck.percentage.plist" ~/Library/LaunchAgents/io.jclerck.percentage.plist
pushd ~/Library/LaunchAgents/ 2&> /dev/null
launchctl load -w io.jclerck.percentage.plist