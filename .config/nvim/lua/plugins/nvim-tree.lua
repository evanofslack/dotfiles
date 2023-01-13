local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function custom_callback(callback_name)
	return string.format(":lua require('utils/nvim-tree').%s()<CR>", callback_name)
end

nvim_tree.setup({
	auto_reload_on_write = true,
	sort_by = "case_sensitive",
	live_filter = {
		prefix = "[filter]: ",
		always_show_folders = false, -- Turn into false from true by default
	},
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "<c-f>", cb = custom_callback("launch_find_files") },
				{ key = "<c-g>", cb = custom_callback("launch_live_grep") },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = false,
		custom = { "node_modules", ".git", ".cache", "__pycache__" },
	},
	actions = {
		open_file = {
			quit_on_open = true,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "abcdefghijklmnopqrstuvwxyz",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
		remove_file = {
			close_window = true,
		},
	},
})
