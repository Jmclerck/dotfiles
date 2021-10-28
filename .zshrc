setopt prompt_subst

source ~/.zsh/zsh-async/async.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-battery-status/zsh-battery-status.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-git-status/zsh-git-status.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zprofile

autoload -Uz colors
colors

autoload -Uz compinit
compinit

PROMPT='$NEXT_GIT_STATUS%c> '
RPROMPT='$NEXT_BATTERY_STATUS'

precmd() {
  battery_status
  git_status $(pwd)
}

wd() {
  source ~/.zsh/wd/wd.sh
}