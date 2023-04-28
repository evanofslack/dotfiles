local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end
indent_blankline.setup({
	char = "▏",
	show_current_context = true,
	show_current_context_start = true,
	show_trailing_blankline_indent = false, -- new
	show_first_indent_level = true, -- new
	use_treesitter = true,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"packer",
		"NvimTree",
	},
})
