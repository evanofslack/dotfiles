# path
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/Users/eslack/.cargo/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH

# pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# edit
export EDITOR=nvim
