git="
.DS_Store\n
\n
# caches\n
.cache\n
.eslintcache\n
.stylelintcache\n
.temp\n
\n
# coverage\n
.nyc_output\n
*.lcov\n
coverage\n
lib-cov\n
\n
# editors\n
.idea\n
.fleet\n
.vscode\n
\n
# environment\n
.env\n
.env.development.local\n
.env.local\n
.env.production.local\n
.env.test.local\n
\n
# typescript\n
*.tsbuildinfo\n
\n
# vercel\n
.next\n
.vercel\n
\n
# yarn / npm\n
.npm\n
.pnp.*\n
.yalc\n
.yarn-integrity\n
.yarn/build-state.yml\n
.yarn/cache\n
.yarn/install-state.gz\n
.yarn/unplugged\n
node_modules\n
npm-debug.log*\n
yarn-debug.log*\n
yarn-error.log*"

if [[ ! -e "$HOME/.config/git/ignore" ]]; then
    mkdir -p "$HOME/.config/git"
    touch "$HOME/.config/git/ignore"
fi

echo $git | sed 's/^ *//g' > "$HOME/.config/git/ignore"

history="
defaults delete com.apple.dock\n
defaults write com.apple.dock magnification -bool true\n
defaults write com.apple.dock ResetLaunchPad -bool true\n
defaults write com.apple.dock wvous-bl-corner -int 14\n
defaults write com.apple.dock wvous-br-corner -int 5"

if [[ ! -e "$HOME/.zsh_history" ]]; then
    touch "$HOME/.zsh_history"
fi
    
echo $history | sed 's/^ *//g' > "$HOME/.zsh_history"