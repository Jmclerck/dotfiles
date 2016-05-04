#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# fasd
alias a='fasd -a'        # any
alias s='fasd -si'        # show / search / select
alias d='fasd -d'        # directory
alias ds='fasd -sid'     # interactive directory selection
alias f='fasd -f'        # file
alias fs='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias js='fasd_cd -d -i' # cd with interactive selection

# NOM
nom() {
  npm "$@";
}

# ZSH
alias zshu="pushd .; cd ~/.zprezto; git pull && git submodule update --init --recursive; popd"
