# zsh

Uses the macOS system zsh. The plugins are installed with Homebrew (they are in `brew/Brewfile`):

```bash
brew install zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
```

`.zsh/config/plugins.zsh` sources them from `$HOMEBREW_PREFIX/share`, and skips any that are missing.

Machine-specific settings (work env vars, secrets) go in `~/.zshrc.local`, which is not tracked.
