export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH" # mysql
export PATH="/Users/eslack/.cargo/bin:$PATH" # cargo
export PATH=$PATH:$(go env GOPATH)/bin # golang
export PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH # find
export PATH="${PATH}:${HOME}/.krew/bin" # krew

# pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# editor
export EDITOR=nvim


[[ -s "/Users/eslack/.gvm/scripts/gvm" ]] && source "/Users/eslack/.gvm/scripts/gvm"
