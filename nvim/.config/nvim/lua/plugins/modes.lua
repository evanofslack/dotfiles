local status_ok, modes = pcall(require, "modes")
if not status_ok then
	return
end

modes.setup({
	colors = {
		bg = "", -- Optional bg param, defaults to Normal hl group
		copy = "#f5c359",
		delete = "#c75c6a",
		insert = "#78ccc5",
		visual = "#FFFDD0",
	},

	-- Set opacity for cursorline and number background
	line_opacity = {
		copy = 0.25,
		delete = 0.25,
		insert = 1,
		visual = 0.25,
	},

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = false,

	-- Disable modes highlights in specified filetypes
	-- Please PR commonly ignored filetypes
	ignore_filetypes = { "NvimTree", "TelescopePrompt" },
})
