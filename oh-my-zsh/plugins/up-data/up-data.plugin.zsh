# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

source $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh

if [[ -z $UP_DATA_TERMINAL_APP ]]; then
  export UP_DATA_TERMINAL_APP='com.apple.terminal'
fi

function __updates() {
  if [[ $THEME_BREW_UPDATE != false ]]; then
    brew update > /dev/null 2>&1

    local casks=$(brew cask outdated 2> /dev/null | wc -l | tr -d ' ')
    if [[ $casks -eq 1 ]]; then
      echo "$casks homebrew cask update" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png -sound default -title 'webicons'
    elif [[ $casks -ge 2 ]]; then
      echo "$casks homebrew cask updates" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png -sound default -title 'webicons'
    fi

    local brews=$(brew outdated 2> /dev/null | wc -l | tr -d ' ')
    if [[ $brews -eq 1 ]]; then
      echo "$brews homebrew update" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png -sound default -title 'webicons'
    elif [[ $brews -ge 2 ]]; then
      echo "$brews homebrew updates" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png -sound default -title 'webicons'
    fi
  fi

  if [[ $THEME_NPM_UPDATE != false ]]; then
    local npm=$(npm outdated -g --json=true | jq 'keys' | sed -E 's/[^a-z\-]//g' | sed '/^$/d' 2> /dev/null | wc -l | tr -d ' ')
    if [[ $npm -eq 1 ]]; then
      echo "$npm npm update" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/npm.png -sound default -title 'webicons'
    elif [[ $npm -ge 2 ]]; then
      echo "$npm npm updates" | terminal-notifier -activate $UP_DATA_TERMINAL_APP -appIcon $ZSH_CUSTOM/plugins/up-data/icons/npm.png -sound default -title 'webicons'
    fi
  fi
}

async_init
async_start_worker my_worker
async_job my_worker __updates
