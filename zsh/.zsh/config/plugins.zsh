# zsh plugins from homebrew (see zsh/README.md)
# syntax-highlighting must load before history-substring-search
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  [[ -f "$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh" ]] && source "$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh"
done

# xoxide (autojump)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# atuin (shell history)
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"
