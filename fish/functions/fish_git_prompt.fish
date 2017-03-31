set -U fish_color_git_ahead AF00FF
set -U fish_color_git_behind F2B01E
set -U fish_color_git_clean green
set -U fish_color_git_dirty red
set -U fish_color_git_staged yellow

set -U fish_prompt_git_branch ' '
set -U fish_prompt_git_status_ahead ' '
set -U fish_prompt_git_status_behind ' '

set -U fish_color_git_added green
set -U fish_prompt_git_status_added ' '

set -U fish_color_git_modified blue
set -U fish_prompt_git_status_modified ' '

set -U fish_color_git_renamed magenta
set -U fish_prompt_git_status_renamed ' '

set -U fish_color_git_deleted red
set -U fish_prompt_git_status_deleted ' '

set -U fish_color_git_unmerged yellow
set -U fish_prompt_git_status_unmerged ' '

set -U fish_color_stashed yellow
set -U fish_prompt_git_status_stashed ' '

set -U fish_color_git_untracked cyan
set -U fish_prompt_git_status_untracked ' '

function fish_git_prompt --description 'Write out the git prompt'
  set -l branch (git symbolic-ref --quiet --short HEAD 2> /dev/null)

  if test -z $branch
    return
  end

  printf ' | '

  git diff-index --quiet --cached HEAD 2>/dev/null
  set -l staged $status

  set -l index (git status --porcelain 2> /dev/null)
  if test -z "$index"
    set_color $fish_color_git_clean
  else if test $staged = 1
    set_color $fish_color_git_staged
  else
    set_color $fish_color_git_dirty
  end

  set -l sha256 (git rev-parse --short HEAD 2> /dev/null)
  if test $branch != 'develop' -a $branch != 'master'
    printf '%s@%s%s' $branch $sha256 $fish_prompt_git_branch
  else
    printf '%s@%s' $branch $sha256
  end

  set -l remote (git show-ref origin/$branch 2> /dev/null)
  if test -n "$remote"
    set -l remote (git rev-list --count origin/$branch 2> /dev/null)
    set -l local (git rev-list --count $branch 2> /dev/null)
    if test $remote -gt $local
      set_color $fish_color_git_behind
      set -l diff (math (math $local - $remote) \* -1)
      if test $diff -gt 1
        printf '%s %d' $fish_prompt_git_status_behind $diff
      else
        printf $fish_prompt_git_status_behind
      end
      
    else if test $remote -lt $local
      set_color $fish_color_git_ahead
      set -l diff (math $local - $remote)
      if test $diff -gt 1
        printf '%s %d' $fish_prompt_git_status_ahead $diff
      else
        printf $fish_prompt_git_status_ahead
      end
    end
  end

  set -l stash (string trim (git stash list | wc -l))
  if test -n "$stash"
    if test $stash -eq 1
      set_color $fish_color_stashed
      printf $fish_prompt_git_status_stashed
    else if test $stash -gt 1
      set_color $fish_color_stashed
      printf "%s %d" $fish_prompt_git_status_stashed $stash
    end
  end

  set -l info
  for i in $index
    switch $i
      case 'A  *'
        set i added
      case 'M  *' ' M *'
        set i modified
      case 'R  *'
        set i renamed
      case 'D  *' ' D *'
        set i deleted
      case 'U  *'
        set i unmerged
      case '?? *'
        set i untracked
    end

    if not contains $i $info
      set info $info $i
    end
  end

  for i in added modified renamed deleted unmerged untracked
    if contains $i $info
      eval 'set_color $fish_color_git_'$i
      eval 'printf $fish_prompt_git_status_'$i
    end
  end

  set_color normal
end
