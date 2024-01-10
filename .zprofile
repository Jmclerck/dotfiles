source $(dirname $(readlink $0))/.path.zprofile

fpath=($HOME/.zsh/wd $fpath)

autoload -Uz compinit
compinit -u

source $(dirname $(readlink $0))/.completion.zprofile

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
