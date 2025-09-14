export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH" # mysql
export PATH=$PATH:$(go env GOPATH)/bin # golang
export PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH # find
export PATH="${PATH}:${HOME}/.krew/bin" # krew
export PATH="$HOME/.cargo/bin:$PATH" # cargo
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH" # nvim manager
export NVM_DIR="$HOME/.nvm" # node version manager

# pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# editor
export EDITOR=nvim
export BROWSER=Firefox

# sops age key
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# switcher (k8s)
source <(switcher init zsh)

# gvm
[[ -s "/Users/eslack/.gvm/scripts/gvm" ]] && source "/Users/eslack/.gvm/scripts/gvm"

# substring search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh


# node version manager
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
