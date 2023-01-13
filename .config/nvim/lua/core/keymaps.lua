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

-- telescope
local builtin = require("telescope.builtin")
local ext = require("telescope").extensions
set("n", "<leader>ff", builtin.git_files, { desc = "find git files" })
set("n", "<leader>fp", builtin.find_files, { desc = "find files" })
set("n", "<leader>fr", builtin.oldfiles, { desc = "find recently opened files" })
set("n", "<leader>f;", builtin.buffers, { desc = "find existing buffers" })

-- live grep
-- if in git project, change work dir to top level
-- otherwise do a normal grep
set("n", "<leader>fg", function()
	local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
	git_dir = string.gsub(git_dir, "\n", "")
	local ok, _ = vim.loop.fs_stat(git_dir)
	if not ok then
		ext.live_grep_args.live_grep_args()
	else
		local opts = { cwd = git_dir }
		ext.live_grep_args.live_grep_args(opts)
	end
end, { desc = "search with grep" })

-- alternative grep implementations
-- set("n", "<leader>fg", builtin.live_grep, { desc = "search with grep" })
-- set("n", "<leader>fg", ext.live_grep_args.live_grep_args, { desc = "search with grep" })

set("n", "<leader>fb", ":Telescope file_browser<cr>", { desc = "browse files" })
set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "search undo history" })
set("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", { desc = "search clipboard history" })
set("n", "<leader>fz", "<cmd>Telescope zoxide list<cr>", { desc = "navigate with zoxide" })
set("n", "<leader>fn", "<cmd>Telescope notify <cr>", { desc = "search notifications" })

set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] fuzzily search in current buffer]" })
set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
set("n", "<leader>fq", builtin.quickfix, { desc = "find quickfix" })

-- trouble
set("n", "<leader>fd", "<cmd>TroubleToggle<cr>", { silent = true, desc = "show diagnostics" })
-- set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "go to lsp references (trouble)" })

-- lsp
set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
set("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, silent = true })
set("n", "[g", vim.diagnostic.goto_next, { noremap = true, silent = true })
set("n", "]g", vim.diagnostic.goto_prev, { noremap = true, silent = true })
