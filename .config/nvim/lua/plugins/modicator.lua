-- local status_ok, modicator = pcall(require, "modicator")
-- if not status_ok then
-- 	return
-- end
local modicator = require("modicator")

-- required for modicator
-- vim.o.cursorline = true
-- vim.o.number = true
-- vim.o.termguicolors = true

-- modicator.setup({
modicator.setup({
	show_warnings = true, -- Show warning if any required option is missing
	highlights = {
		modes = {
			["i"] = modicator.get_highlight_fg("Question"),
			["v"] = modicator.get_highlight_fg("Type"),
			["V"] = modicator.get_highlight_fg("Type"),
			["�"] = modicator.get_highlight_fg("Type"),
			["s"] = modicator.get_highlight_fg("Keyword"),
			["S"] = modicator.get_highlight_fg("Keyword"),
			["R"] = modicator.get_highlight_fg("Title"),
			["c"] = modicator.get_highlight_fg("Constant"),
		},
	},
})
