local custom_gruvbox = require'lualine.themes.gruvbox'
require('lualine').setup {
  options = { theme  = custom_gruvbox },
  tabline = {
    lualine_b = {
      {
        "buffers",
        hide_filename_extension = false,
        mode = 2,
      }
    },
  },
  extensions = {'nvim-tree'}
}
