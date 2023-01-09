require('telescope').setup{
  defaults = {
    mappings = {}
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
  },
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("undo")

