# herdr

config for the herdr app. install it by hand, there is no brew cask.

tracked: `settings.json`, `keys.json`, the `dev` layout, themes and `~/.config/herdr/config.toml`.

not tracked:
- app state (`data/`, `view.json`, `shared.json`, `window.json`, sockets, logs)
- bundled mods, which the app installs itself
- add-on mods, reinstall these: `automations`, `git-graph`, `gitview` (+ `-agents`, `-ask`, `-diff`, `-keys`, `-mark`, `-sidebar`, `-tab`, `-tracing`), `herdr-nvim`, `herdr-nvim-header`, `insights`, `tabs-plus`, `wt-new`, `wt-claude`
- automations (`~/.config/herdr/plugins/config/dnzzl.automations/automations.yaml`), work specific

`keys.json` binds `cmd-e`, `cmd-o`, `cmd-g`, `cmd-n`, `cmd-shift-n` and others to add-on mods, so those keys do nothing until the mods are back. `shared.json` picks the `dev` layout, so select it once in the app.

herdr may rewrite `settings.json` or `keys.json` in place of the symlink when you change settings in the app. if `git status` here stops showing your changes, copy the file back and restow.
