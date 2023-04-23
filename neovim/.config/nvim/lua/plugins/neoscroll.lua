require("neoscroll").setup({ mappings = {} })

local t = {}
t["<S-k>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
t["<S-j>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
t["zz"] = { "zz", { "250" } }

require("neoscroll.config").set_mappings(t)
