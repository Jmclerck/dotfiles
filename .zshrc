setopt prompt_subst

export PATH="$HOME/.cargo/bin:/usr/local/sbin:/usr/local/opt/mozjpeg/bin:$PATH"
export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

export DENO_VERSION=true
export NODE_VERSION=true
export RUBY_VERSION=true
export VIRTUAL_ENV_DISABLE_PROMPT=true

source ~/.python/bin/activate
source ~/.zsh/zsh-async/async.plugin.zsh
source ~/.zsh/zsh-battery-status/zsh-battery-status.zsh
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
eval "$(jump shell)"

PROMPT='$NEXT_WEBICON $NEXT_GIT_STATUS %c> '
RPROMPT='$(versions) $NEXT_BATTERY_STATUS'

precmd() {
  git_status $(pwd)
  battery
  webicons
}