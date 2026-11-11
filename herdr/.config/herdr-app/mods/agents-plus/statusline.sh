#!/bin/sh
# Claude Code status line: model, folder, branch and context used.
# It also saves context use for the agents-plus sidebar, one file per herdr
# terminal (HC_TERMINAL_ID), because Herdr's agent list has no context data.
in=$(cat)
dir="$HOME/.cache/herdr-ctx"
mkdir -p "$dir"

field() { printf '%s' "$in" | jq -r "$1 // empty" 2>/dev/null; }
model=$(field '.model.display_name')
cwd=$(field '.workspace.current_dir')
pct=$(field '.context_window.used_percentage')
branch=$(git -C "${cwd:-.}" branch --show-current 2>/dev/null)

if [ -n "$HC_TERMINAL_ID" ] && [ -n "$pct" ]; then
  tmp="$dir/.$HC_TERMINAL_ID.$$"
  printf '{"pct":%s,"at":%s}\n' "$pct" "$(date +%s)" > "$tmp" && mv "$tmp" "$dir/$HC_TERMINAL_ID.json"
fi

# Terminal ANSI colors, so the line follows the terminal theme.
dim='\033[2m' yellow='\033[33m' red='\033[31m' reset='\033[0m'
line="$model"
[ -n "$cwd" ] && line="$line ${dim}·${reset} ${cwd##*/}"
[ -n "$branch" ] && line="$line ${dim}·${reset} $branch"
if [ -n "$pct" ]; then
  p=${pct%.*}
  color=$dim
  [ "$p" -ge 50 ] && color=$yellow
  [ "$p" -ge 80 ] && color=$red
  line="$line ${dim}·${reset} ${color}ctx ${p}%${reset}"
fi
printf '%b\n' "$line"
