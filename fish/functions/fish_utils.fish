function cls
  clear
  fish_logo
end

function j
  jump $argv
end

function m
  mark $argv
end

function pup
  pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U
end

function reset-dock
  defaults delete com.apple.dock; killall Dock
end

function reset-launchpad
  defaults write com.apple.dock ResetLaunchPad -bool true;
  killall Dock
end

function serve
  python -m SimpleHTTPServer $argv
end

function vtop
  node /usr/local/lib/node_modules/vtop/bin/vtop.js --theme 'monokai'
end
