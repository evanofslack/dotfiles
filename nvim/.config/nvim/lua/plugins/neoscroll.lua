return {
  "karb94/neoscroll.nvim",
  keys = {
    {
      "<S-k>",
      function()
        require("neoscroll").ctrl_u({ duration = 250 })
      end,
    },
    {
      "<S-j>",
      function()
        require("neoscroll").ctrl_d({ duration = 250 })
      end,
    },
  },
}
