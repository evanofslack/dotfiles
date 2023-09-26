local status_ok, hlchunk = pcall(require, "hlchunk")
if not status_ok then
	return
end

hlchunk.setup({

	indent = {
		chars = {
			"│",
		},
		style = {
			vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
		},
	},

	blank = {
		enable = false,
	},
	line_num = {
		enable = false,
	},
	chunk = {
		chars = {
			horizontal_line = "─",
			vertical_line = "│",
			left_top = "┌",
			left_bottom = "└",
			right_arrow = "─",
		},
		-- style = "#458588",

		style = "#fabd2f",
	},
})
