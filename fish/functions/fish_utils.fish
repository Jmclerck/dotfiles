function cd
  builtin cd $argv

  if test -z $nodengine_last_dir
    set nodengine_last_dir ''
  end
  
  set rc $PWD/.nvmrc

  if test -e $rc -a $nodengine_last_dir != $PWD
    echo 'Found .nvmrc with version '(cat $rc)
    n (cat $rc)
    set -g nodengine_last_dir $PWD
    return
  end

  set engine $PWD/package.json

  if test -e $engine -a $nodengine_last_dir != $PWD
    nodengine
    set -g nodengine_last_dir $PWD
    return
  end
end

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
  node ~/.n/lib/node_modules/vtop/bin/vtop.js --theme 'monokai'
end
