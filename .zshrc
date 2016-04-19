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

# ZSH
alias zshc="nano ~/.zshrc"
alias zshs="source ~/.zshrc"
alias zshu="pushd .; cd ~/.zprezto; git pull && git submodule update --init --recursive; popd"

# Maven
alias mvn-build="mvn clean install -DskipTests -Dconnections.tomcat7.home='/etc/tomcat7'"

# Tomcat
alias tomcat-start="sudo launchctl load -w /Library/LaunchDaemons/org.apache.tomcat.plist"
alias tomcat-stop="sudo launchctl unload /Library/LaunchDaemons/org.apache.tomcat.plist"

# NOM
nom() {
  npm "$@";
}
