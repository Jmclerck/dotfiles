local resetColor="%{$reset_color%}"
local prefix="▲"
local dir="%{$fg_bold[green]%}%c$resetColor$resetColor"
local node="%{$fg_bold[green]%}  $(npm config get node-version)"
local yarn="%{$fg_bold[blue]%}  $(yarn --version)"

PROMPT='$prefix $dir $(git_prompt_info)'
RPROMPT="$node$yarn$resetColor$resetColor"

ZSH_THEME_GIT_PROMPT_PREFIX="at %{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$resetColor "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✖"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"
