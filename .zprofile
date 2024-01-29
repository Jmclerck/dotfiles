autoload -Uz compinit

if [[ ! $0 =~ "^-" ]]
then
    source "$(dirname $(realpath $0))/.path.zprofile"
    source "$(dirname $(realpath $0))/.completion.zprofile"
fi

compinit -u

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
