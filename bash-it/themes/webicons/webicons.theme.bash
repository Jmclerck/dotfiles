#!/usr/bin/env bash

___prefix=("" "" "" "" "" "" "${orange}" "${orange}" "${orange}" "${orange}" "${orange}" "${magenta}" "${purple}" "${purple}" "${purple}" "${purple}" "${red}" "${yellow}" "${darkblue}" "${darkblue}" "${darkblue}" "${darkblue}" "${darkgreen}" "${darkgreen}" "${lightblue}" "${lightblue}" )

___silent() {
    { 2>&3 "$@"& } 3>&2 2>/dev/null
    disown &>/dev/null
}

__stat() {
  local icons=''
  local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

  if [[ $git == true ]]; then
    local stashes=$(git stash list | grep -o '@' |  tr -d ' ' | tr -d '\n')
    local numberOfStashes=${#stashes}
    if [[ $numberOfStashes -gt 0 ]]; then
      icons="$icons  $numberOfStashes"
    fi

    local untracked=$(git status --porcelain | grep -o '^??\s' |  tr -d ' ' | tr -d '\n')
    local numberOfUntracked=${#untracked}
    if [[ $numberOfUntracked -gt 0 ]]; then
      icons="$icons  $(($numberOfUntracked / 2))"
    fi

    local added=$(git status --porcelain | grep -oE '^\sA\s|^A\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfAdded=${#added}
    if [[ $numberOfAdded -gt 0 ]]; then
      icons="$icons  $numberOfAdded"
    fi

    local deleted=$(git status --porcelain | grep -oE '^\sD\s|^D\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfDeleted=${#deleted}
    if [[ $numberOfDeleted -gt 0 ]]; then
      icons="$icons  $numberOfDeleted"
    fi

    local modified=$(git status --porcelain | grep -oE '^\sM\s|^M\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfModified=${#modified}
    if [[ $numberOfModified -gt 0 ]]; then
      icons="$icons  $numberOfModified"
    fi

    local renamed=$(git status --porcelain | grep -oE '^\sR\s|^R\s{2}' |  tr -d ' ' | tr -d '\n')
    local numberOfRenamed=${#renamed}
    if [[ $numberOfRenamed -gt 0 ]]; then
      icons="$icons  $numberOfRenamed"
    fi

    local conflicts=$(git status --porcelain | grep -oE '^UU\s' |  tr -d ' ' | tr -d '\n')
    local numberOfConflicts=${#conflicts}
    if [[ $numberOfConflicts -gt 0 ]]; then
      icons="$icons  $(($numberOfConflicts / 2))"
    fi

    local staged=$(git status --porcelain |  grep -oE '^A\s{2}|^D\s{2}|^M\s{2}|^R\s{2}' | tr -d ' ' | tr -d '\n')
    local numberOfStaged=${#staged}
    if [[ $numberOfStaged -gt 0 ]]; then
      icons="$icons  $(($numberOfStaged))"
    fi

    local remote=$(git show-ref origin/$(_git-branch) 2> /dev/null)
    if [[ -z $remote ]]; then
      icons="$icons  "
    else
      local str=$(_git-upstream-behind-ahead)
      local counts=($(echo "$str" | tr ' ' '\n'))
      local ahead=${counts[0]}

      if [[ $ahead -gt 0 ]]; then
        icons="$icons  $ahead"
      fi

      local ahead=${counts[1]}
      if [[ $behind -gt 0 ]]; then
        icons="$icons  $behind"
      fi

      if [[ $(_git-branch) == "master" ]]; then
        icons="$icons  "
      else
        icons="$icons  "
      fi
    fi

    printf "$reset_color at ${magenta}$(_git-branch)$reset_color$icons"
  else
    printf "$resetColor  "
  fi
}

__updates() {
  local icons=''

  brew update > /dev/null 2>&1

  local brew=$(brew outdated 2> /dev/null | wc -l | tr -d ' ')
  local cask=$(brew cask outdated 2> /dev/null | wc -l | tr -d ' ')
  local updates=($brew + $cask)
  if [[ $updates -gt 0 ]]; then
    icons=" $updates $icons"
  fi

  local store=$(mas outdated 2> /dev/null | wc -l | tr -d ' ')
  if [[ $store -gt 0 ]]; then
    icons=" $store $icons"
  fi

  printf "$icons"
}

__versions() {
  local icons=''

  if [[ $THEME_NPM_VERSION != false ]]; then
    icons="$icons${red}  $(npm --version)"
  fi

  if [[ $THEME_NODE_VERSION != false ]]; then
    icons="$icons${green}  $(npm config get node-version)"
  fi

  printf "$icons"
}

function prompt_command() {
  index=$(( $RANDOM % ${#___prefix[@]} ))
  selection=${___prefix[$index]}
  PS1="$selection $(__versions) ${green}\w${purple}$(__stat)${reset_color}\n${reset_color}${green}→${reset_color} "
}

___silent __updates

safe_append_prompt_command prompt_command
