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
