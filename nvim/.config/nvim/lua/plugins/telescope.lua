return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<Down>"] = require("telescope.actions").cycle_history_next,
          ["<Up>"] = require("telescope.actions").cycle_history_prev,
        },
      },
    },
    pickers = {
      oldfiles = {
        sort_lastused = true,
        cwd_only = false,
      },
    },
  },
}
