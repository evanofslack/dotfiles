# dotfiles

the wildest collection of code you'll ever see

<img width="900" alt="nvim" src="https://github.com/evanofslack/dotfiles/assets/51209817/577aade5-b113-4d28-a070-d8ab90f3d585">

## new mac

1. install [homebrew](https://brew.sh) and [alacritty](https://alacritty.org)
2. create an ssh key and add it to github (git rewrites github https urls to ssh)
3. clone and run setup

```bash
git clone git@github.com:evanofslack/dotfiles.git ~/dotfiles
cd ~/dotfiles
make macos
```

`make macos` will:
- install everything in `brew/Brewfile`
- stow the configs into `$HOME` (existing files are moved to `~/.dotfiles-backup/<timestamp>/`)
- install tmux plugins (tpm), rust (rustup) and node (nvm)

stow links are relative, so keep the repo where you cloned it.

### manual steps
- copy the sops age key to `~/.config/sops/age/keys.txt`
- put machine-specific settings in `~/.zshrc.local` (not tracked)
- `gh auth login`
- zsh plugins: see [zsh/README.md](zsh/README.md)

### optional extras
not installed by setup:
- cargo: `just`, `tuicr`
- go: `protoc-gen-go`, `protoc-gen-go-grpc`, `swag`
- npm: `@earendil-works/pi-coding-agent`

## other targets

```bash
make arch    # stow only
make remote  # minimal: bash, git, vim
make remove  # unstow everything
```
