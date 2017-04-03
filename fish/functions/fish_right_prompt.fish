set -U fish_color_nodejs green
set -U fish_nodejs_icon ''

function fish_right_prompt --description 'Write out the right prompt'
  set_color $fish_color_nodejs
  printf '%s %s %s%s' $fish_nodejs_icon (node --version) (set_color normal) (battery)
  set_color normal
end
