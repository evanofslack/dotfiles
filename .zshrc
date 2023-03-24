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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/eslack/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/eslack/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/eslack/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/eslack/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

