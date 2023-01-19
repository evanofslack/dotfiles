local get_hex = require("cokeline/utils").get_hex

require("cokeline").setup({
	show_if_buffers_are_at_least = 2,
	rendering = {
		max_buffer_width = 30,
	},

	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Comment", "fg")
		end,
		bg = function(buffer)
			return buffer.is_focused and get_hex("None", "fg") or get_hex("Normal", "bg")
		end,
	},
	sidebar = {
		filetype = "NvimTree",
		components = {
			{
				text = "",
				fg = get_hex("Normal", "fg"),
				bg = get_hex("NvimTreeNormal", "bg"),
				style = "bold",
			},
		},
	},

	components = {
		{
			text = function(buffer)
				return " " .. buffer.filename
			end,
			fg = function(buffer)
				return buffer.is_focused and get_hex("Normal", "fg")
			end,
			style = function(buffer)
				return buffer.is_focused and "bold" or nil
			end,
			truncation = {
				priority = 2,
				direction = "right",
			},
		},
		{
			text = "  ",
			truncation = {
				priority = 1,
			},
		},
		{
			text = "",
			fg = function(buffer)
				return buffer.is_focused and get_hex("Normal", "fg")
			end,
			delete_buffer_on_left_click = true,
			truncation = {
				priority = 1,
			},
		},
		{
			text = " ",
			truncation = {
				priority = 1,
			},
		},
		{
			text = "▏",
			fg = get_hex("Comment", "fg"),
			truncation = {
				priority = 1,
			},
		},
	},
})
