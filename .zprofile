export DENO_PREFIX=$HOME/.deno
export N_PREFIX=$HOME/.n
export PATH=$DENO_PREFIX/bin:$N_PREFIX/bin:$PATH

fpath=($HOME/.zsh/wd $fpath)

autoload -Uz compinit
compinit -u

eval "$(deno completions zsh)"; compdef _deno deno
eval "$(gh completion -s zsh)"; compdef _gh gh
eval "$(op completion zsh)"; compdef _op op

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(/opt/homebrew/bin/brew shellenv)"
