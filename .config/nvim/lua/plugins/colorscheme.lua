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
	inverse = false, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {
		bright_green = "#bbb226",
		bright_blue = "#83a59b",
		-- bright_cyan = "#7cc08c",
	},
	overrides = {
		Search = { bg = "#5c5c5c", fg = "#ebdbb2" },
		IncSearch = { bg = "#fe8019", fg = "#ebdbb2" },
		-- IncSearch = { bg = "#076678", fg = "#ebdbb2" },
		CursorLine = { bg = "#302c2b" },
		-- DiffDelete = { bg = "#282828", fg = "#cc241d" },
		-- DiffAdd = { bg = "#282828", fg = "#bbb226" },
	},
	dim_inactive = false,
	transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
