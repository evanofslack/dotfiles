# load start files first
[[ -f ~/.zsh/start.zsh ]] && source ~/.zsh/start.zsh

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function;
done

# load configs
for file in ~/.zsh/config/*; do
    source "$file";
done

# include alias
[[ -f ~/.aliases ]] && source ~/.aliases

# local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# load end files last
[[ -f ~/.zsh/end.zsh ]] && source ~/.zsh/end.zsh

# Created by `pipx` on 2024-09-01 17:05:32
export PATH="$PATH:/Users/eslack/.local/bin"

export GOPRIVATE=github.com/bluearchive/*

[[ -s "/Users/eslack/.gvm/scripts/gvm" ]] && source "/Users/eslack/.gvm/scripts/gvm"
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
