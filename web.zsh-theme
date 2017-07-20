local resetColor="%{$reset_color%}"

local prefix=("" "" "" "" "" "" "" "" "" "" "" "" "" "" "")
local selection=${prefix[$(( $RANDOM % ${#prefix[@]} + 1 ))]}

local dir="%c"
local git='$(git_current_branch)@$(git_prompt_short_sha)'

local node=' $(npm config get node-version)'
local yarn=' $(yarn --version)'

local icons=''

local ahead=$(git_commits_ahead)
if [[ $ahead -gt 0 ]]; then
  icons='$icons  $ahead'
fi

local behind=$(git_commits_behind)
if [[ $behind -gt 0 ]]; then
  icons='$icons  $behind'
fi

local conflicts=$(git status --porcelain | grep -o 'UU' | tr -d '\n')
local numberOfConflicts=${#conflicts}
if [[ $numberOfConflicts -gt 0 ]]; then
  icons='$icons  $(($numberOfConflicts / 2))'
fi

local untracked=$(git status --porcelain | grep -o '??' | tr -d '\n')
local numberOfUntracked=${#untracked}
if [[ $numberOfUntracked -gt 0 ]]; then
  icons='$icons  $(($numberOfUntracked / 2))'
fi

local modified=$(git status --porcelain | grep -o 'M' | tr -d '\n')
local numberOfModified=${#modified}
if [[ $numberOfModified -gt 0 ]]; then
  icons='$icons  $numberOfModified'
fi

local stashes=$(git stash list | grep -o '@' | tr -d '\n')
local numberOfStashes=${#stashes}
if [[ $numberOfStashes -gt 0 ]]; then
  icons='$icons  $numberOfStashes'
fi

local deleted=$(git status --porcelain | grep -o 'D' | tr -d '\n')
local numberOfDeleted=${#deleted}
if [[ $numberOfDeleted -gt 0 ]]; then
  icons='$icons  $numberOfDeleted'
fi

local renamed=$(git status --porcelain | grep -o 'R' | tr -d '\n')
local numberOfRenamed=${#renamed}
if [[ $numberOfRenamed -gt 0 ]]; then
  icons='$icons  $numberOfRenamed'
fi

local added=$(git status --porcelain | grep -o 'A' | tr -d '\n')
local numberOfAdded=${#added}
if [[ $numberOfAdded -gt 0 ]]; then
  icons='$icons  $numberOfAdded'
fi

local remote=$(command git show-ref origin/$(git_current_branch))
if [[ -z $remote ]]; then
  icons='$icons  '
else
  if [[ $git_current_branch -eq 'master' ]]; then
    icons='$icons  '
  else
    icons='$icons  '
  fi
fi

PROMPT="$selection $dir at $git $icons"
RPROMPT="%{$fg_bold[green]%}$node$resetColor$resetColor %{$fg_bold[blue]%}$yarn$resetColor$resetColor"
