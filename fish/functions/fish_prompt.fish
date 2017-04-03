set -U fish_color_cwd magenta
set -U fish_color_success green
set -U fish_color_error red

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not test $last_status -eq 0
    set_color $fish_color_error
    printf ' '
    set_color normal
  else
    set_color $fish_color_success
    printf ' '
    set_color normal
  end

  set_color $fish_color_cwd
  printf (prompt_pwd)
  set_color normal

  fish_git_prompt

  printf '  '
  set_color normal
end
