brew bundle dump --force

code --list-extensions > vscode.extensions

npm ls -g --depth=0 --json=true |
  jq '.dependencies | keys' |
  sed -E 's/[^a-z\-]//g' |
  sed '/^$/d' > npm.modules

git add .
git status
