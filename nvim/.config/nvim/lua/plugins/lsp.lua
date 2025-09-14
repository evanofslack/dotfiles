-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Get the default keymaps
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    -- Modify keymaps
    keys[#keys + 1] = { "<s-k>", false }
    keys[#keys + 1] = { "<leader>gI", false }
    keys[#keys + 1] = { "<leader>gk", vim.lsp.buf.hover, mode = "n", desc = "Hover" }
    opts.inlay_hints = { enabled = false }
  end,
}
