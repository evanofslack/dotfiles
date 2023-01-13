local gruvbox_status_ok, gruvbox = pcall(require, "gruvbox")
if not gruvbox_status_ok then
	return
end

gruvbox.setup({
	undercurl = true,
	underline = true,
	bold = false,
	italic = true,
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {
		bright_green = "#bbb226",
		bright_blue = "#83a59b",
		bright_cyan = "#7cc08c",
	},
	overrides = {
		Search = { fg = "#458588", bg = "#ebdbb2" },
		IncSearch = { fg = "#076678", bg = "#ebdbb2" },
		CursorLine = { bg = "#302c2b" },
	},
	dim_inactive = false,
	transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
