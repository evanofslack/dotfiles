# herdr

config for the herdr app. install it by hand, there is no brew cask.

tracked: `settings.json`, `keys.json`, the `dev` layout, themes, `~/.config/herdr/config.toml` and my own mods (`spaces-plus`, `picker-plus`, `agents-plus`, `tabs-plus`, clones of the bundled ones, plus `wt-new` and `wt-claude`, which open the bundled `worktree` dialog from `cmd-n` and `cmd-shift-n`, the second with a `claude` tab). `tabs-plus` adds the Outgoing panel button, which opens the `outgoing` block in the `dev` layout. it also has a `tabs-plus.last` command, bound to `cmd-a`, that jumps back to the previous tab like tmux `last-window`.

not tracked:
- app state (`data/`, `view.json`, `shared.json`, `window.json`, sockets, logs)
- bundled mods, which the app installs itself
- add-on mods, reinstall these: `automations`, `git-graph`, `gitview` (+ `-agents`, `-ask`, `-diff`, `-keys`, `-mark`, `-sidebar`, `-tab`, `-tracing`), `herdr-nvim`, `herdr-nvim-header`, `insights`, `better-changes`
- `better-changes` comes from `munza/herdr-mods` (`better-changes/mods/better-changes`, installed at `ab45de7`). after copying it in, set `"place": "none"` in its `mod.json` so it only shows in the Outgoing tab, and add `"settings": { "panel": { "toggle": true } }` so `cmd-shift-g` closes it too. its `sync.sh` overwrites `mod.json`, so redo both after an update.
- automations (`~/.config/herdr/plugins/config/dnzzl.automations/automations.yaml`), work specific

`keys.json` binds `cmd-e`, `cmd-o`, `cmd-g`, `cmd-alt-g`, `cmd-shift-g` and others to add-on mods, so those keys do nothing until the mods are back. `shared.json` picks the `dev` layout, so select it once in the app.

herdr may rewrite `settings.json` or `keys.json` in place of the symlink when you change settings in the app. if `git status` here stops showing your changes, copy the file back and restow.

the context % in the agents list comes from claude code's status line. add this to `~/.claude/settings.json`, which is not tracked here:

```json
"statusLine": { "type": "command", "command": "sh ~/.config/herdr-app/mods/agents-plus/statusline.sh" }
```
