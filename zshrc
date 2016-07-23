# Path to your oh-my-zsh installation.
export ZSH=/Users/Jonathan/.oh-my-zsh

source /Users/Jonathan/.powerlevelrc

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(brew docker docker-compose fasd git node osx)

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

export EDITOR="nano"

source $ZSH/oh-my-zsh.sh
source /Users/Jonathan/.powerlevelrc

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/github_rsa"

# fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias ds='fasd -sid'     # interactive directory selection
alias f='fasd -f'        # file
alias fs='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias js='fasd_cd -d -i' # cd with interactive selection

# Coffee. Must ... Stay ... Awake ...
Coffee() {
  if [ $1 = "wait" ] 
    then
      caffeinate -d $2;
  elif [ $1 = "time" ]
    then
      caffeinate -t $2;
  else
    echo "I don't understand";
  fi
}

# Cow says Hello
greeting() {
  local user=$(whoami);
  local time=$(date '+%X');
  cowsay Hello ${user} the time is: ${time};
}

# Alias NOM to NPM, for fun and profit
nom() {
  npm "$@";
}

# Strip extra macOS files from Archives 
strip() {
  zip -d $1 __MACOSX/\*;
}

greeting
