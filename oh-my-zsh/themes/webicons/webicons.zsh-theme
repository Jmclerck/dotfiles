local blue="%{$fg[blue]%}"
local cyan="%{$fg[cyan]%}"
local green="%{$fg[green]%}"
local magenta="%{$fg[magenta]%}"
local red="%{$fg[red]%}"
local yellow="%{$fg[yellow]%}"

local grey="%{$FG[008]%}"
local orange="%{$FG[208]%}"
local purple="%{$FG[093]%}"
local resetColor="%{$reset_color%}"

___power=(" " " " " " " " " " " " " ")
___power_colours=("$red" "$yellow" "$yellow" "$yellow" "$yellow" "$yellow" "$green")
___prefix=(
" " " " " " " " " " " " " " " "
" " " " " " " " " " " " " " " "
" " " " " " " " " " " " " " " "
" " " " " " " " " " " " " " " "
)
___prefix_colours=(
  "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor"
  "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor"
  "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor"
  "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor"
)


function __iconography() {
  local index=$(( $RANDOM % ${#___prefix[@]} + 1 ))

  echo "${___prefix_colours[$index]}${___prefix[$index]} "
}

function __power() {
  if [[ $THEME_POWER_MONITOR != false ]]; then
    local stat=$(pmset -g batt)

    local charging=$(echo $stat | rg -o "\scharg[ing|ed]")
    local discharging=$(echo $stat | rg -o "\sdischarging")
    local percent=$(echo $stat | rg -o "[0-9]*%" | rg -o "[0-9]*")
    local segment=$(( ($percent / 14.3) + 1 ))

    local colour=${___power_colours[$segment]}

    if [[ -n $charging ]]; then
      local time=$(echo $stat | rg -o "[0-9]:[0-9]*")

      echo "${colour}  $time"
    elif [[ -n $discharging ]]; then
      echo "${colour} ${___power[$segment]}$percent%%"
    fi
  fi
}

function __stat() {
  if [[ $THEME_GIT_STATUS != false ]]; then
    local icons=''
    local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

    if [[ $git == true ]]; then
      local stashes=$(git stash list | rg -o '@' |  tr -d ' ' | tr -d '\n')
      local numberOfStashes=${#stashes}
      if [[ $numberOfStashes -gt 0 ]]; then
        icons="$icons $magenta  $numberOfStashes"
      fi

      local untracked=$(git status --porcelain | rg -o '^\?\?\s' |  tr -d ' ' | tr -d '\n')
      local numberOfUntracked=${#untracked}
      if [[ $numberOfUntracked -gt 0 ]]; then
        icons="$icons $orange  $(($numberOfUntracked / 2))"
      fi

      local added=$(git status --porcelain | rg -o '^\sA\s|^A\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfAdded=${#added}
      if [[ $numberOfAdded -gt 0 ]]; then
        icons="$icons $green  $numberOfAdded"
      fi

      local deleted=$(git status --porcelain | rg -o '^\sD\s|^D\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfDeleted=${#deleted}
      if [[ $numberOfDeleted -gt 0 ]]; then
        icons="$icons $red  $numberOfDeleted"
      fi

      local modified=$(git status --porcelain | rg -o '^\sM\s|^M\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfModified=${#modified}
      if [[ $numberOfModified -gt 0 ]]; then
        icons="$icons $orange  $numberOfModified"
      fi

      local renamed=$(git status --porcelain | rg -o '^\sR\s|^R\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfRenamed=${#renamed}
      if [[ $numberOfRenamed -gt 0 ]]; then
        icons="$icons $green  $numberOfRenamed"
      fi

      local conflicts=$(git status --porcelain | rg -o '^UU\s' |  tr -d ' ' | tr -d '\n')
      local numberOfConflicts=${#conflicts}
      if [[ $numberOfConflicts -gt 0 ]]; then
        icons="$icons $red  $(($numberOfConflicts / 2))"
      fi

      local staged=$(git status --porcelain |  rg -o '^A\s{2}|^D\s{2}|^M\s{2}|^R\s{2}' | tr -d ' ' | tr -d '\n')
      local numberOfStaged=${#staged}
      if [[ $numberOfStaged -gt 0 ]]; then
        icons="$icons $green $(($numberOfStaged))"
      fi

      local remote=$(git show-ref origin/$(git_current_branch) 2> /dev/null)
      if [[ -z $remote ]]; then
        icons="$icons $grey "
      else
        local ahead=$(git_commits_ahead)
        if [[ $ahead -gt 0 ]]; then
          icons="$icons $orange $ahead"
        fi

        local behind=$(git_commits_behind)
        if [[ $behind -gt 0 ]]; then
          icons="$icons $green $behind"
        fi

        if [[ $(git_current_branch) == "master" ]]; then
          icons="$icons $blue "
        else
          icons="$icons $blue "
        fi
      fi

      echo "$resetColor at $magenta$(git_current_branch)$icons $resetColor"
    else
      echo "$magenta   $resetColor"
    fi
  fi
}

function __versions() {
  local icons=''

  if [[ $THEME_DENO_VERSION != false ]]; then
    denoVersion=$(deno --version | rg -o "deno (\d*\.\d*\.\d*)" -r '$1') &> /dev/null

    if [[ -n $denoVersion ]]; then
      icons="$icons$resetColor  $denoVersion"
    fi
  fi

  if [[ $THEME_DOCKER_VERSION != false ]]; then
    dockerVersion=$(docker --version | rg -o "\d*\.\d*\.\d*") &> /dev/null

    if [[ -n $dockerVersion ]]; then
      icons="$icons$cyan  $dockerVersion"
    fi
  fi

  if [[ $THEME_NODE_VERSION != false ]]; then
    nodeVersion=$(npm config get node-version) &> /dev/null

    if [[ -n $nodeVersion ]]; then
      icons="$icons$green  $nodeVersion"
    fi
  fi

  if [[ $THEME_NPM_VERSION != false ]]; then
    npmVersion=$(npm --version) &> /dev/null

    if [[ -n $npmVersion ]]; then
      icons="$icons$red  $npmVersion"
    fi
  fi

  if [[ $THEME_PYTHON_VERSION != false ]]; then
    pythonVersion=$(python --version | rg -o "\d*\.\d*\.\d*") &> /dev/null

    if [[ -n $pythonVersion ]]; then
      icons="$icons$yellow  $pythonVersion"
    fi
  fi

  if [[ $THEME_RUBY_VERSION != false ]]; then
    rubyVerison=$(ruby --version | rg -o "\d*\.\d*\.\d*") &> /dev/null

    if [[ -n $rubyVerison ]]; then
      icons="$icons$red  $rubyVerison"
    fi
  fi

  if [[ $THEME_YARN_VERSION != false ]]; then
    yarnVersion=$(yarn --version) &> /dev/null

    if [[ -n $yarnVersion ]]; then
      icons="$icons$cyan  $yarnVersion"
    fi
  fi

  echo "$icons"
}

PROMPT='$(__iconography)%U%c%u$(__stat)'
RPROMPT='$(__versions)$(__power)$resetColor'
