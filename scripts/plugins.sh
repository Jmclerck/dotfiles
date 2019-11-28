# remove existing vscode extensions
for i in $(code --list-extensions | comm -13 $(pwd)/vscode.extensions -); do
  code --uninstall-extension $i
done

# install vscode extensions
for i in $(cat vscode.extensions); do
  code --install-extension $i
done
