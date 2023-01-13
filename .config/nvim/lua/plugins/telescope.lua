local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local z_utils = require("telescope._extensions.zoxide.utils")
local lga_actions = require("telescope-live-grep-args.actions")

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
	pickers = {
		oldfiles = {
			sort_lastused = true,
			cwd_only = false,
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			mappings = { -- extend mappings
				i = {
					["<C-o>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					["<C-u>"] = lga_actions.quote_prompt({ postfix = " .." }),
				},
			},
		},
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
		file_browser = {
			-- theme = "ivy",
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
		zoxide = {
			prompt_title = "[ zoxide ]",
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
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("file_browser")
