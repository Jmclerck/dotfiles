local resetColor="%{$reset_color%}"
local black="%{$FG[000]%}"
local red="%{$FG[001]%}"
local green="%{$FG[002]%}"
local yellow="%{$FG[003]%}"
local blue="%{$FG[004]%}"
local magenta="%{$FG[005]%}"
local cyan="%{$FG[006]%}"
local white="%{$FG[007]%}"
local purple="%{$FG[201]%}"
local orange="%{$FG[202]%}"

___power=("" "" "" "" "")
___power_colours=("$red" "$yellow" "$yellow" "$yellow" "$green")
___prefix=("" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "")
___prefix_colours=("$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$resetColor" "$blue" "$blue" "$blue" "$blue" "$blue" "$blue" "$blue" "$green" "$green" "$magenta" "$orange" "$orange" "$orange" "$orange" "$purple" "$purple" "$purple" "$purple" "$red" "$red" "$yellow")

function __iconography() {
  local index=$(( $RANDOM % ${#___prefix[@]} + 1 ))

  echo "${___prefix_colours[$index]}${___prefix[$index]} "
}

function __power() {
  if [[ $THEME_POWER_MONITOR != false ]]; then
    local stat=$(pmset -g batt)

    local charging=$(echo $stat | grep -Eo "\scharg[ing|ed]")
    local discharging=$(echo $stat | grep -o "\sdischarging")
    local percent=$(echo $stat | grep -o "[0-9]*%" | grep -o "[0-9]*")
    local segment=$(( ($percent / 25) + 1 ))

    local colour=${___power_colours[$segment]}

    if [[ -n $charging ]]; then
      local time=$(echo $stat | grep -o "[0-9]:[0-9]*")

      echo "${colour}  $time"
    elif [[ -n $discharging ]]; then
      echo "${colour} ${___power[$segment]} $percent%%"
    fi
  fi
}

function __stat() {
  if [[ $THEME_GIT_STATUS != false ]]; then
    local icons=''
    local git=$(git rev-parse --is-inside-work-tree 2> /dev/null)

    if [[ $git == true ]]; then
      local stashes=$(git stash list | grep -o '@' |  tr -d ' ' | tr -d '\n')
      local numberOfStashes=${#stashes}
      if [[ $numberOfStashes -gt 0 ]]; then
        icons="$icons $magenta $numberOfStashes"
      fi

      local untracked=$(git status --porcelain | grep -o '^??\s' |  tr -d ' ' | tr -d '\n')
      local numberOfUntracked=${#untracked}
      if [[ $numberOfUntracked -gt 0 ]]; then
        icons="$icons $orange $(($numberOfUntracked / 2))"
      fi

      local added=$(git status --porcelain | grep -oE '^\sA\s|^A\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfAdded=${#added}
      if [[ $numberOfAdded -gt 0 ]]; then
        icons="$icons $green $numberOfAdded"
      fi

      local deleted=$(git status --porcelain | grep -oE '^\sD\s|^D\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfDeleted=${#deleted}
      if [[ $numberOfDeleted -gt 0 ]]; then
        icons="$icons $red $numberOfDeleted"
      fi

      local modified=$(git status --porcelain | grep -oE '^\sM\s|^M\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfModified=${#modified}
      if [[ $numberOfModified -gt 0 ]]; then
        icons="$icons $orange $numberOfModified"
      fi

      local renamed=$(git status --porcelain | grep -oE '^\sR\s|^R\s{2}' |  tr -d ' ' | tr -d '\n')
      local numberOfRenamed=${#renamed}
      if [[ $numberOfRenamed -gt 0 ]]; then
        icons="$icons $green $numberOfRenamed"
      fi

      local conflicts=$(git status --porcelain | grep -oE '^UU\s' |  tr -d ' ' | tr -d '\n')
      local numberOfConflicts=${#conflicts}
      if [[ $numberOfConflicts -gt 0 ]]; then
        icons="$icons $red $(($numberOfConflicts / 2))"
      fi

      local staged=$(git status --porcelain |  grep -oE '^A\s{2}|^D\s{2}|^M\s{2}|^R\s{2}' | tr -d ' ' | tr -d '\n')
      local numberOfStaged=${#staged}
      if [[ $numberOfStaged -gt 0 ]]; then
        icons="$icons $green $(($numberOfStaged))"
      fi

      local remote=$(git show-ref origin/$(git_current_branch) 2> /dev/null)
      if [[ -z $remote ]]; then
        icons="$icons $red"
      else
        local ahead=$(git_commits_ahead)
        if [[ $ahead -gt 0 ]]; then
          icons="$icons $orange $ahead"
        fi

        local behind=$(git_commits_behind)
        if [[ $behind -gt 0 ]]; then
          icons="$icons $green $behind"
        fi

        if [[ $(git_current_branch) == "master" ]]; then
          icons="$icons $blue"
        else
          icons="$icons $blue"
        fi
      fi

      echo " at $magenta$(git_current_branch)$icons "
    else
      echo "$magenta  "
    fi
  fi
}

function __versions() {
  local icons=''

  if [[ $THEME_NPM_VERSION != false ]]; then
    icons="$icons$red  $(npm --version)"
  fi

  if [[ $THEME_NODE_VERSION != false ]]; then
    icons="$icons$green  $(npm config get node-version)"
  fi

  if [[ $THEME_RUBY_VERSION != false ]]; then
    icons="$icons$red  $(ruby --version | grep -o "\d*\.\d*\.\d*")"
  fi

  echo "$icons"
}

PROMPT='$(__iconography)%U%c%u$(__stat)'
RPROMPT='$(__versions)$(__power)$resetColor'
