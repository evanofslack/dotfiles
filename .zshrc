# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# load configs
for file in ~/.zsh/config/*; do
    source "$file"
done

# include alias 
[[ -f ~/.aliases ]] && source ~/.aliases
    
# local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


# path
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/Users/eslack/.cargo/bin:$PATH"

# edit
export EDITOR=nvim
export TERM=alacritty

# make it pretty
neofetch --off
