setopt prompt_subst

export PATH="$HOME/.cargo/bin:$HOME/Library/Python/3.8/bin:/usr/local/sbin:/usr/local/opt/mozjpeg/bin:$PATH"
export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"

source ~/.zprofile
source ~/.zsh/zsh-async/async.plugin.zsh
source ~/.zsh/zsh-battery-status/zsh-battery-status.zsh
source ~/.zsh/zsh-ci-status/zsh-ci-status.zsh
source ~/.zsh/zsh-command-status/zsh-command-status.zsh
source ~/.zsh/zsh-git-status/zsh-git-status.zsh
source ~/.zsh/zsh-versions/zsh-versions.zsh
source ~/.zsh/zsh-webicons/zsh-webicons.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

autoload -Uz compinit && compinit -u
gpgconf --kill gpg-agent
ssh-add -K ~/.ssh/id_rsa

eval "$(fnm env --log-level=quiet --multi --shell=zsh --use-on-cd)"

PROMPT='$NEXT_WEBICON$NEXT_GIT_STATUS%c> '
RPROMPT='$(command_status)$NEXT_CI_STATUS$(versions)$NEXT_BATTERY_STATUS'

precmd() {
  battery_status
  ci_status $(pwd)
  git_status $(pwd)
  webicons
}

wd() {
  source ~/.zsh/wd/wd.sh
}
