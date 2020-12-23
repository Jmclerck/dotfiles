setopt prompt_subst

export PATH="$HOME/.deno/bin:$PATH"
export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"

source ~/.zsh/zsh-async/async.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-battery-status/zsh-battery-status.zsh
source ~/.zsh/zsh-ci-status/zsh-ci-status.zsh
source ~/.zsh/zsh-command-status/zsh-command-status.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-git-status/zsh-git-status.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-pg-status/zsh-pg-status.zsh
source ~/.zsh/zsh-versions/zsh-versions.zsh
source ~/.zsh/zsh-webicons/zsh-webicons.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zprofile

autoload -Uz compinit && compinit -u

eval "$(fnm env --shell=zsh --use-on-cd)"

PROMPT='$NEXT_WEBICON $NEXT_GIT_STATUS%c> '
RPROMPT='$NEXT_CI_STATUS $(versions) $NEXT_BATTERY_STATUS'

precmd() {
  battery_status
  ci_status $(pwd)
  git_status $(pwd)
  webicons
}

wd() {
  source ~/.zsh/wd/wd.sh
}