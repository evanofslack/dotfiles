return {
  "dlvhdr/gh-blame.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>gp", "<cmd>GhBlameCurrentLine<cr>", desc = "GitHub Blame Line" },
  },
}
