#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
NVM_VERSION="v0.40.3"

MACOS_PACKAGES=(alacritty atuin bat btop gh git neofetch nvim starship tmux vim zsh)
ARCH_PACKAGES=(alacritty atuin btop gh git neofetch nvim starship tmux vim zsh)
REMOTE_PACKAGES=(bash git vim)

function check() {
    if ! command -v "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

# move a conflicting file/dir/link out of the way
function backup() {
    local target="$1"
    local dest="$BACKUP_DIR/${target#"$HOME"/}"
    mkdir -p "$(dirname "$dest")"
    mv "$target" "$dest"
    echo "backed up $target -> $dest"
}

# walk each file in a package and back up anything in $HOME that stow would
# conflict with. a link that already points into this repo is removed instead,
# since stow refuses links it didn't create and will recreate it anyway.
function backup_conflicts() {
    local pkg="$1" src rel prefix repo part
    while IFS= read -r src; do
        rel="${src#"$pkg"/}"
        prefix="$HOME"
        IFS=/ read -ra parts <<< "$rel"
        for part in "${parts[@]}"; do
            prefix="$prefix/$part"
            repo="$DOTFILES/$pkg/${prefix#"$HOME"/}"
            if [[ -L "$prefix" ]]; then
                if [[ "$(realpath "$prefix" 2>/dev/null || true)" == "$(realpath "$repo")" ]]; then
                    rm "$prefix"
                else
                    backup "$prefix"
                fi
                break
            elif [[ ! -e "$prefix" ]]; then
                break
            elif [[ ! -d "$prefix" || ! -d "$repo" ]]; then
                backup "$prefix"
                break
            fi
        done
    done < <(cd "$DOTFILES" && find "$pkg" \( -type f -o -type l \) ! -name .gitignore ! -path "$pkg/README*")
}

function stow_packages() {
    # keep ~/.config a real dir so stow doesn't fold it into a package
    mkdir -p "$HOME/.config"
    cd "$DOTFILES"
    for pkg in "$@"; do
        backup_conflicts "$pkg"
        stow --verbose --target="$HOME" --restow "$pkg"
    done
}

function install_tmux_plugins() {
    local tpm="$HOME/.tmux/plugins/tpm"
    [[ -d "$tpm" ]] || git clone https://github.com/tmux-plugins/tpm "$tpm"
    "$tpm/bin/install_plugins"
}

function install_rust() {
    [[ -x "$HOME/.cargo/bin/rustup" ]] && return
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
}

function install_node() {
    export NVM_DIR="$HOME/.nvm"
    if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
        # PROFILE=/dev/null: don't let the installer append to the stowed .zshrc
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
    fi
    set +u
    source "$NVM_DIR/nvm.sh"
    nvm install --lts
    set -u
}

function macos() {
    check brew
    brew bundle --file="$DOTFILES/brew/Brewfile"
    stow_packages "${MACOS_PACKAGES[@]}"
    install_tmux_plugins
    install_rust
    install_node
}

function arch() {
    check stow
    stow_packages "${ARCH_PACKAGES[@]}"
}

function remote() {
    check stow
    stow_packages "${REMOTE_PACKAGES[@]}"
}

function remove() {
    check stow
    cd "$DOTFILES"
    local pkg
    for pkg in $(printf "%s\n" "${MACOS_PACKAGES[@]}" "${ARCH_PACKAGES[@]}" "${REMOTE_PACKAGES[@]}" | sort -u); do
        stow --verbose --target="$HOME" --delete "$pkg"
    done
}

case "${1:-}" in
    macos|arch|remote|remove) "$1" ;;
    *) echo "usage: $0 {macos|arch|remote|remove}"; exit 1 ;;
esac
