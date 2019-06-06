#!/usr/bin/env bash

___power=("" "" "" "" "")
___power_colours=("${red}" "${yellow}" "${yellow}" "${yellow}" "${green}")
___prefix=(
  "" "" "" "" "" "" ""
  "" "" "" "" "" "" ""
  "" ""
  ""
  "" "" "" ""
  "" "" "" ""
  "" ""
  "")
___prefix_colours=(
  "${reset_color}" "${reset_color}" "${reset_color}" "${reset_color}" "${reset_color}" "${reset_color}" "${reset_color}"
  "${blue}" "${blue}" "${blue}" "${blue}" "${blue}" "${blue}" "${blue}"
  "${green}" "${green}"
  "${magenta}"
  "${orange}" "${orange}" "${orange}" "${orange}"
  "${purple}" "${purple}" "${purple}" "${purple}"
  "${red}" "${red}"
  "${yellow}"
)

___silent() {
    { 2>&3 "$@"& } 3>&2 2>/dev/null
    disown &>/dev/null
}

__power() {
  if [[ $THEME_POWER_MONITOR != false ]]; then
    local status=$(pmset -g batt)

    local charging=$(echo $status | grep -Eo "\scharg[ing|ed]")
    local discharging=$(echo $status | grep -o "\sdischarging")
    local percent=$(echo $status | grep -o "[0-9]*%" | grep -o "[0-9]*")
    local segment=$(( percent / 25 ))

    local colour=${___power_colours[$segment]}

    if [[ -n $charging ]]; then
      local time=$(echo $status | grep -o "[0-9]:[0-9]*")

      echo "${colour}$percent%  ${reset_color} "
    elif [[ -n $discharging ]]; then
      echo "${colour}$percent% ${___power[$segment]} ${reset_color} "
    fi
  fi
}

__stat() {
  if [[ $THEME_GIT_STATUS != false ]]; then
    local icons=''
    local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

    if [[ $git == true ]]; then
      local stashes=$(git stash list | grep -o '@' |  tr -d ' ' | tr -d '\n')
      local numberOfStashes=${#stashes}
      if [[ $numberOfStashes -gt 0 ]]; then
        icons="$icons ${magenta} $numberOfStashes${reset_color}"
      fi

      local untracked=$(git status --porcelain | grep -o '^??\s' |  tr -d ' ' | tr -d '\n')
      local numberOfUntracked=${#untracked}
      if [[ $numberOfUntracked -gt 0 ]]; then
        icons="$icons ${orange} $(($numberOfUntracked / 2))${reset_color}"
      fi

      local added=$(git status --porcelain | grep -oE '^\sA\s|^A\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfAdded=${#added}
      if [[ $numberOfAdded -gt 0 ]]; then
        icons="$icons ${green} $numberOfAdded${reset_color}"
      fi

      local deleted=$(git status --porcelain | grep -oE '^\sD\s|^D\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfDeleted=${#deleted}
      if [[ $numberOfDeleted -gt 0 ]]; then
        icons="$icons ${red} $numberOfDeleted${reset_color}"
      fi

      local modified=$(git status --porcelain | grep -oE '^\sM\s|^M\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfModified=${#modified}
      if [[ $numberOfModified -gt 0 ]]; then
        icons="$icons ${orange} $numberOfModified${reset_color}"
      fi

      local renamed=$(git status --porcelain | grep -oE '^\sR\s|^R\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfRenamed=${#renamed}
      if [[ $numberOfRenamed -gt 0 ]]; then
        icons="$icons ${green} $numberOfRenamed${reset_color}"
      fi

      local conflicts=$(git status --porcelain | grep -oE '^UU\s' |  tr -d ' ' | tr -d '\n')
      local numberOfConflicts=${#conflicts}
      if [[ $numberOfConflicts -gt 0 ]]; then
        icons="$icons ${red} $(($numberOfConflicts / 2))${reset_color}"
      fi

      local staged=$(git status --porcelain |  grep -oE '^A\s{2}|^D\s{2}|^M\s{2}|^R\s{2}' | tr -d ' ' | tr -d '\n')
      local numberOfStaged=${#staged}
      if [[ $numberOfStaged -gt 0 ]]; then
        icons="$icons ${green} $(($numberOfStaged))${reset_color}"
      fi

      local remote=$(git show-ref origin/$(_git-branch) 2> /dev/null)
      if [[ -z $remote ]]; then
        icons="$icons ${red}${reset_color}"
      else
        local str=$(_git-upstream-behind-ahead)
        local counts=($(echo "$str" | tr ' ' '\n'))

        local behind=${counts[0]}
        if [[ $behind -gt 0 ]]; then
          icons="$icons ${orange} $behind${reset_color}"
        fi

        local ahead=${counts[1]}
        if [[ $ahead -gt 0 ]]; then
          icons="$icons ${green} $ahead${reset_color}"
        fi

        if [[ $(_git-branch) == "master" ]]; then
          icons="$icons ${blue}${reset_color}"
        else
          icons="$icons ${blue}${reset_color}"
        fi
      fi

      printf " at ${magenta}$(_git-branch)$icons"
    else
      printf "  "
    fi
  fi
}

__updates() {
  ___homebrew_updates() {
    brew update > /dev/null 2>&1

    ___cask_updates() {
      local casks=$(brew cask outdated 2> /dev/null | wc -l | tr -d ' ')
      if [[ $casks -eq 1 ]]; then
        echo "$casks homebrew cask update" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/homebrew.png -sound default -title 'webicons'
      elif [[ $casks -ge 2 ]]; then
        echo "$casks homebrew cask updates" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/homebrew.png -sound default -title 'webicons'
      fi
    }

    ___brew_updates() {
      local brews=$(brew outdated 2> /dev/null | wc -l | tr -d ' ')
      if [[ $brews -eq 1 ]]; then
        echo "$brews homebrew update" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/homebrew.png -sound default -title 'webicons'
      elif [[ $brews -ge 2 ]]; then
        echo "$brews homebrew updates" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/homebrew.png -sound default -title 'webicons'
      fi
    }

    ___silent ___brew_updates
    ___silent ___cask_updates
  }

  ___npm_updates() {
    local npm=$(npm outdated -g --json=true | jq 'keys' | sed -E 's/[^a-z\-]//g' | sed '/^$/d' 2> /dev/null | wc -l | tr -d ' ')
    if [[ $npm -eq 1 ]]; then
      echo "$npm npm update" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/npm.png -sound default -title 'webicons'
    elif [[ $npm -ge 2 ]]; then
      echo "$npm npm updates" | terminal-notifier -activate $THEME_TERMINAL_APP -appIcon $BASH_IT_CUSTOM/themes/icons/npm.png -sound default -title 'webicons'
    fi
  }

  if [[ $THEME_BREW_UPDATE != false ]]; then
    ___silent ___homebrew_updates
  fi

  if [[ $THEME_NPM_UPDATE != false ]]; then
    ___silent ___npm_updates
  fi
}

__versions() {
  local icons=''

  if [[ $THEME_NPM_VERSION != false ]]; then
    icons="$icons${red}  $(npm --version)"
  fi

  if [[ $THEME_NODE_VERSION != false ]]; then
    icons="$icons${green}  $(npm config get node-version)"
  fi

  if [[ $THEME_RUBY_VERSION != false ]]; then
    icons="$icons${red}  $(ruby --version | grep -o "\d*\.\d*\.\d*")"
  fi

  printf "$icons"
}

function prompt_command() {
  index=$(( $RANDOM % ${#___prefix[@]} ))
  selection=${___prefix[$index]}
  colour=${___prefix_colours[$index]}

  prompt="$colour$selection $(__versions) ${green}\w${purple}$(__stat)${reset_color}"

  printf '\r' # Return cursor to start of line

  PS1="$prompt\n$(__power)${yellow}⚡${reset_color} "
}

___silent __updates

safe_append_prompt_command prompt_command
