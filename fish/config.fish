set -x N_PREFIX $HOME/.n
set PATH /Applications/Postgres.app/Contents/Versions/latest/bin $N_PREFIX/bin $HOME/.yarn/bin $PATH

source ~/.config/fish/functions/fish_battery.fish
source ~/.config/fish/functions/fish_utils.fish

n 7
tabs -2
thefuck --alias | source
fish_logo
