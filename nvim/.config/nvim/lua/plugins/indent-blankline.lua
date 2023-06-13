local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#434343 gui=nocombine]]) -- gray color of the line

indent_blankline.setup({
	char = "▏",
	char_highlight_list = {
		"IndentBlanklineIndent1",
	},
	show_current_context = true,
	show_current_context_start = false,
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	use_treesitter = true,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"packer",
		"NvimTree",
	},
})
