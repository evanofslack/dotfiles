local set = vim.keymap.set

-- vertical movement
set("n", "J", "<c-d>zz")
set("n", "K", "<c-u>zz")
set("v", "J", "}")
set("v", "K", "{")

-- move by visual line not buffer
set("n", "j", "gj", { noremap = true })
set("n", "k", "gk", { noremap = true })

-- move in insert mode
set("i", "<c-h>", "<left>", { noremap = true })
set("i", "<c-l>", "<right>", { noremap = true })
set("i", "<c-j>", "<down>", { noremap = true })
set("i", "<c-k>", "<up>", { noremap = true })

-- unmap arrow keys
set({ "n", "v", "i" }, "<up>", "<nop>", { noremap = true })
set({ "n", "v", "i" }, "<down>", "<nop>", { noremap = true })
set({ "n", "v", "i" }, "<left>", "<nop>", { noremap = true })
set({ "n", "v", "i" }, "<right>", "<nop>", { noremap = true })

-- tab navigation
set("n", "<Tab>", "<cmd>bn<cr>", { noremap = true })
set("n", "<S-Tab>", "<cmd>bp<cr>", { noremap = true })

-- indent and keep selection
set("x", "<Tab>", ">gv", { noremap = true })
set("x", "<S-Tab>", "<gv", { noremap = true })
set("x", ">", ">gv", { noremap = true })
set("x", "<", "<gv", { noremap = true })

-- clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- always search the same direction
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- nvimtree toggle
set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { noremap = true })

-- quicksave
set("n", "<leader>w", ":w<cr>", { silent = false })
-- quicksave w/o running autocmds (formatting, reloads, etc)
set("n", "<c-w>", "<cmd>noautocmd w<cr>", { silent = false })

-- close buffer without losing window layout
set("n", "<leader>d", "<cmd>Bdelete<cr>")

-- copy/paste from system clipboard
set({ "n", "v" }, "<c-y>", [["+y]])
set({ "n", "v" }, "<c-p>", [["+p]])
set({ "i" }, "<c-p>", [[<esc>"+pi]])

-- move visual highlighted text
set("v", "<c-j>", ":m '>+1<CR>gv=gv")
set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- autocompletion

-- lsp code navigation.
set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
set("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, silent = true })
set("n", "g[", vim.diagnostic.goto_next, { noremap = true, silent = true })
set("n", "g]", vim.diagnostic.goto_prev, { noremap = true, silent = true })

-- telescope
local builtin = require("telescope.builtin")
set("n", "<leader>p", builtin.git_files, { desc = "find git files" })
set("n", "<leader>f", builtin.find_files, { desc = "find files" })
set("n", "<leader>r", builtin.oldfiles, { desc = "find recently opened files" })
set("n", "<leader>b", builtin.buffers, { desc = "find existing buffers" })
set("n", "<leader>g", builtin.live_grep, { desc = "search with grep" })
set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "search undo history" })
set("n", "<leader>y", "<cmd>Telescope neoclip<cr>", { desc = "search clipboard history" })
set("n", "<leader>z", "<cmd>Telescope zoxide list<cr>", { desc = "navigate with zoxide" })
set("n", "<leader>1", "<cmd>Telescope notify <cr>", { desc = "search notifications" })

set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] fuzzily search in current buffer]" })
set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })

-- trouble
set("n", "<leader>d", "<cmd>TroubleToggle<cr>", { silent = true, desc = "show diagnostics" })
set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "go to lsp references (trouble)" })
