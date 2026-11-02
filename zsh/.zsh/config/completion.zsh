autoload -Uz compinit
compinit

# enable kubectl autocompletion
command -v kubectl >/dev/null && source <(kubectl completion zsh)
