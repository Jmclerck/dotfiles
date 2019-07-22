#!/bin/zsh

source $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh

if [[ -z $UP_DATA_TERMINAL_APP ]]; then
  export UP_DATA_TERMINAL_APP='com.apple.terminal'
fi

function main() {
  local title='Up-data ☝️'

  if [[ $THEME_BREW_UPDATE != false ]]; then
    brew update > /dev/null 2>&1

    local caskList=$(brew cask outdated 2> /dev/null)
    local casks=$(echo $caskList | sed '/^$/d' | wc -l | tr -d ' ')
    if [[ $casks -eq 1 ]]; then
      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.cask" \
        -message $caskList \
        -sound submarine \
        -subtitle "$casks homebrew cask update" \
        -title $title
    elif [[ $casks -eq 2 ]]; then
      local joined=$(echo $caskList | tr '\n' '&' | sed -E 's/&/ & /g' | rev | cut -c 3- | rev)

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.cask" \
        -message $joined \
        -sound submarine \
        -subtitle "$casks homebrew cask updates" \
        -title $title
    elif [[ $casks -ge 3 ]]; then
      local joined="$(echo $caskList | head -n 2 | tr '\n' '&' | sed -E 's/&/, /g' | rev | cut -c 3- | rev) and $(($casks - 2)) more"

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.cask" \
        -message $joined \
        -sound submarine \
        -subtitle "$casks homebrew cask updates" \
        -title $title
    fi

    local brewList=$(brew outdated 2> /dev/null)
    local brews=$(echo $brewList | sed '/^$/d' | wc -l | tr -d ' ')

    if [[ $brews -eq 1 ]]; then
      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.brew" \
        -message $brewList \
        -sound submarine \
        -subtitle "$brews homebrew update" \
        -title $title
    elif [[ $brews -eq 2 ]]; then
      local joined=$(echo $brewList | tr '\n' '&' | sed -E 's/&/ & /g' | rev | cut -c 3- | rev)

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.brew" \
        -message $joined \
        -sound submarine \
        -subtitle "$brews homebrew updates" \
        -title $title
    elif [[ $brews -ge 3 ]]; then
      local joined="$(echo $brewList | head -n 2 | tr '\n' '&' | sed -E 's/&/, /g' | rev | cut -c 3- | rev) and $(($brews - 2)) more"

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/homebrew.png \
        -group "com.updata.brew" \
        -message $joined \
        -sound submarine \
        -subtitle "$brews homebrew updates" \
        -title $title
    fi
  fi

  if [[ $THEME_NPM_UPDATE != false ]]; then
    local list=$(npm outdated -g --json=true | jq 'keys' | sed -E 's/[^a-z\-]//g' | sed '/^$/d' 2> /dev/null)
    local npm=$(echo $list | sed '/^$/d'| wc -l | tr -d ' ')

    if [[ $npm -eq 1 ]]; then
      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/npm.png \
        -group "com.updata.npm" \
        -message $list \
        -sound submarine \
        -subtitle "$npm npm update" \
        -title $title
    elif [[ $npm -eq 2 ]]; then
      local joined=$(echo $list | tr '\n' '&' | sed -E 's/&/ & /g' | rev | cut -c 3- | rev)

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/npm.png \
        -group "com.updata.npm" \
        -message $joined \
        -sound submarine \
        -subtitle "$npm npm updates" \
        -title $title
    elif [[ $npm -ge 3 ]]; then
      local joined="$(echo $list | head -n 2 | tr '\n' '&' | sed -E 's/&/, /g' | rev | cut -c 3- | rev) and $(($npm - 2)) more"

      terminal-notifier \
        -activate $UP_DATA_TERMINAL_APP \
        -appIcon $ZSH_CUSTOM/plugins/up-data/icons/npm.png \
        -group "com.updata.npm" \
        -message $joined \
        -sound submarine \
        -subtitle "$npm npm updates" \
        -title $title
    fi
  fi
}

async_init
async_start_worker up_data_worker
async_flush_jobs up_data_worker
async_job up_data_worker main
