-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local del = vim.keymap.del
local default_opts = { noremap = true, silent = true }

-- vertical movement
set("v", "J", "}")
set("v", "K", "{")

-- move by visual line not buffer
set("n", "j", "gj", default_opts)
set("n", "k", "gk", default_opts)

-- move in insert mode
set("i", "<c-h>", "<left>", default_opts)
set("i", "<c-l>", "<right>", default_opts)
set("i", "<c-j>", "<down>", default_opts)
set("i", "<c-k>", "<up>", default_opts)

-- tab navigation
set("n", "<Tab>", "<cmd>bn<cr>", default_opts)
set("n", "<S-Tab>", "<cmd>bp<cr>", default_opts)

-- indent and keep selection
set("x", "<Tab>", ">gv", default_opts)
set("x", "<S-Tab>", "<gv", default_opts)
set("x", ">", ">gv", default_opts)
set("x", "<", "<gv", default_opts)

-- always search the same direction
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- move visual highlighted text
set("v", "<c-j>", ":m '>+1<CR>gv=gv")
set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- resizing panes
set({ "n", "v" }, "<Left>", ":vertical resize +1<CR>", default_opts)
set({ "n", "v" }, "<Right>", ":vertical resize -1<CR>", default_opts)
set({ "n", "v" }, "<Up>", ":resize -1<CR>", default_opts)
set({ "n", "v" }, "<Down>", ":resize +1<CR>", default_opts)

-- increment/decrement
set({ "n", "v" }, "<c-m>", "<c-a>", default_opts)
set({ "n", "v" }, "<c-n>", "<c-x>", default_opts)
