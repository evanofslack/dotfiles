-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      ["*"] = {
        keys = {
          { "<s-k>", false },
          { "<leader>gI", false },
          { "<leader>gk", vim.lsp.buf.hover, mode = "n", desc = "Hover" },
        },
      },
    },
  },
}
