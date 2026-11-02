export PATH="$HOME/.local/bin:$PATH" # pipx, uv tools
export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH" # mysql

# rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# go
command -v go >/dev/null && export PATH="$PATH:$(go env GOPATH)/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

# node version manager
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# editor
export EDITOR=nvim
export BROWSER=Firefox

# sops age key
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# Docker/Colima testcontainers
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"
export UV_ENV_FILE=.env
export DAGSTER_HOME="$(pwd)/dagster_home"

# switcher (k8s)
command -v switcher >/dev/null && source <(switcher init zsh)

# worktrunk
command -v wt >/dev/null && eval "$(command wt config shell init zsh)"
