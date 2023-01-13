local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local z_utils = require("telescope._extensions.zoxide.utils")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
			},
		},
	},
	pickers = {},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
		zoxide = {
			prompt_title = "[ Zoxide ]",
			list_command = "zoxide query -ls",
			mappings = {
				default = {
					action = z_utils.create_basic_command("edit"),
				},
				["<c-f>"] = {
					keepinsert = true,
					action = function(selection)
						builtin.find_files({ cwd = selection.path })
					end,
				},
				["<c-g>"] = {
					keepinsert = true,
					action = function(selection)
						builtin.live_grep({ cwd = selection.path })
					end,
				},
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("notify")
