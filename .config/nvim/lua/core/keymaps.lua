local set = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- vertical movement
set("n", "J", "<c-d>zz")
set("n", "K", "<c-u>zz")
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

-- clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

-- always search the same direction
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- nvimtree toggle
set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "show file tree" })

-- quicksave
set("n", "<leader>w", ":w<cr>", { silent = false, desc = "quicksave" })
-- quicksave w/o running autocmds (formatting, reloads, etc)
set("n", "<c-w>", "<cmd>noautocmd w<cr>", { noremap = true, silent = false })

-- close buffer without losing window layout
set("n", "<leader>bd", "<cmd>Bdelete<cr>", { noremap = true, silent = false, desc = "close buffer" })

-- copy/paste from system clipboard
set({ "n", "v" }, "<c-y>", [["+y]])
set({ "n", "v" }, "<c-p>", [["+p]])
set({ "i" }, "<c-p>", [[<esc>"+pi]])

-- move visual highlighted text
set("v", "<c-j>", ":m '>+1<CR>gv=gv")
set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- resizing panes
set({ "n", "v", "i" }, "<Left>", ":vertical resize +1<CR>", default_opts)
set({ "n", "v", "i" }, "<Right>", ":vertical resize -1<CR>", default_opts)
set({ "n", "v", "i" }, "<Up>", ":resize -1<CR>", default_opts)
set({ "n", "v", "i" }, "<Down>", ":resize +1<CR>", default_opts)

-- telescope
local builtin = require("telescope.builtin")
local ext = require("telescope").extensions

-- find git files
-- if in git project, find git files, otherwise find files
set("n", "<leader>ff", function()
	local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
	git_dir = string.gsub(git_dir, "\n", "")
	local ok, _ = vim.loop.fs_stat(git_dir)
	if not ok then
		builtin.find_files()
	else
		builtin.git_files()
	end
end, { desc = "find git files " })
set("n", "<leader>fp", builtin.find_files, { desc = "find files" })
set("n", "<leader>fr", builtin.oldfiles, { desc = "find recently opened files" })
set("n", "<leader>f;", builtin.buffers, { desc = "find existing buffers" })

-- live grep
-- if in git project, change work dir to top level, otherwise do a normal grep
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

set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "search in current buffer" })
set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
set("n", "<leader>fq", builtin.quickfix, { desc = "find quickfix" })

-- lsp
set(
	"n",
	"<leader>gd",
	"<cmd>lua vim.lsp.buf.definition()<CR>",
	{ noremap = true, silent = true, desc = "go to definition" }
)
-- handles by glances
-- set(
-- 	"n",
-- 	"<leader>gi",
-- 	"<cmd>lua vim.lsp.buf.implementation()<CR>",
-- 	{ noremap = true, silent = true, desc = "go to implementation" }
-- )
-- handles by glances
-- set(
-- 	"n",
-- 	"<leader>gr",
-- 	"<cmd>lua vim.lsp.buf.references()<CR>",
-- 	{ noremap = true, silent = true, desc = "go to references" }
-- )
set(
	"n",
	"<leader>gl",
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	{ noremap = true, silent = true, desc = "open diagnostic" }
)
set(
	"n",
	"<leader>gk",
	"<cmd>lua vim.lsp.buf.hover()<CR>",
	{ noremap = true, silent = true, desc = "see hover definition" }
)

-- glances offers alternatives to default lsp locations
set("n", "<leader>gD", "<CMD>Glance definitions<CR>", { noremap = true, silent = true, desc = "glance definition" })
set("n", "<leader>gr", "<CMD>Glance references<CR>", { noremap = true, silent = true, desc = "go to references" })
set(
	"n",
	"<leader>gt",
	"<CMD>Glance type_definitions<CR>",
	{ noremap = true, silent = true, desc = "go to type definitions" }
)
set(
	"n",
	"<leader>gi",
	"<CMD>Glance implementations<CR>",
	{ noremap = true, silent = true, desc = "go to implementations" }
)

-- set(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, silent = true, desc = "" }) -- redefined by lsp-code-action-menu
set(
	"n",
	"[g",
	"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
	{ noremap = true, silent = true, desc = "go to next diagnostic" }
)
set(
	"n",
	"]g",
	"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
	{ noremap = true, silent = true, desc = "go to previous diagnostic" }
)
-- set(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = "" }) -- redefined in inc-rename
set(
	"n",
	"<leader>ls",
	"<cmd>lua vim.lsp.buf.signature_help()<CR>",
	{ noremap = true, silent = true, desc = "see signature help" }
)
set(
	"n",
	"<leader>lq",
	"<cmd>lua vim.diagnostic.setloclist()<CR>",
	{ noremap = true, silent = true, desc = "see location list" }
)
set("n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "see attached LSP info" })
set("n", "<leader>lm", "<cmd>Mason<cr>", { noremap = true, silent = true, desc = "see Mason info" })

-- advanced git search
set("n", "<leader>hb", ext.advanced_git_search.diff_branch_file, { desc = "diff branches of current file" })
set("n", "<leader>hf", ext.advanced_git_search.diff_commit_file, { desc = "diff commits of current file" })
set("n", "<leader>hl", ext.advanced_git_search.diff_commit_line, { desc = "diff commits of visually selected lines" })
set("n", "<leader>hc", ext.advanced_git_search.search_log_content, { desc = "search all previous commits" })
set("n", "<leader>hcf", ext.advanced_git_search.search_log_content_file, { desc = "search commits for current file" })
set("n", "<leader>hr", ext.advanced_git_search.checkout_reflog, { desc = "search reflog" })

-- git mergetool
set("n", "<leader>h1", "<cmd> diffget LOCAL<CR>", { noremap = true, silent = true, desc = "pick local" })
set("n", "<leader>h2", "<cmd> diffget BASE<CR>", { noremap = true, silent = true, desc = "pick base" })
set("n", "<leader>h3", "<cmd> diffget REMOTE<CR>", { noremap = true, silent = true, desc = "pick remote" })

-- trouble
set("n", "<leader>fd", "<cmd>TroubleToggle<cr>", { silent = true, desc = "show diagnostics" })
-- set("n", "<leader>gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "lsp references (trouble)" })

-- lsp
set("n", "<leader>la", "<cmd>CodeActionMenu<cr>", { noremap = true, silent = true, desc = "show code actions" })

-- icon-picker
set("i", "<c-e>", "<cmd>IconPickerInsert<cr>", { noremap = true, silent = true, desc = "icon picker" })

-- color-picker
set("i", "<C-c>", "<cmd>PickColor<cr>", { noremap = true, silent = true, desc = "color picker" })
set("n", "<C-c>", "<cmd>PickColor<cr>", { noremap = true, silent = true, desc = "color picker" })

-- show treesitter capture group for textobject under cursor.
set("n", "<leader>th", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, { noremap = true, silent = false, desc = "show treesitter highlight group" })

-- symbols-outline
set("n", "<leader>N", "<cmd>SymbolsOutline<cr>", { silent = true, desc = "show symbol outline" })

-- packer
set("n", "<leader>zc", "<cmd>PackerCompile<cr>", { noremap = true, silent = true, desc = "compile" })
set("n", "<leader>zi", "<cmd>PackerInstall<cr>", { noremap = true, silent = true, desc = "install" })
set("n", "<leader>zs", "<cmd>PackerSync<cr>", { noremap = true, silent = true, desc = "sync" })
set("n", "<leader>zS", "<cmd>PackerStatus<cr>", { noremap = true, silent = true, desc = "status" })
set("n", "<leader>zu", "<cmd>PackerUpdate<cr>", { noremap = true, silent = true, desc = "update" })

-- portal
set(
	"n",
	"<leader>o",
	"<cmd>Portal jumplist backward<cr>",
	{ noremap = true, silent = false, desc = "portal jumplist backward" }
)
set(
	"n",
	"<leader>i",
	"<cmd>Portal jumplist forward<cr>",
	{ noremap = true, silent = false, desc = "portal jumplist forward" }
)

-- neotest
neotest = require("neotest")
set(
	"n",
	"<leader>da",
	"<cmd>lua require('neotest').run.attach()<cr>",
	{ noremap = true, silent = true, desc = "attach" }
)
set(
	"n",
	"<leader>df",
	"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
	{ noremap = true, silent = true, desc = "run file" }
)
set(
	"n",
	"<leader>dF",
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	{ noremap = true, silent = true, desc = "debug file" }
)
set(
	"n",
	"<leader>dl",
	"<cmd>lua require('neotest').run.run_last()<cr>",
	{ noremap = true, silent = true, desc = "run last" }
)
set(
	"n",
	"<leader>dL",
	"<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>",
	{ noremap = true, silent = true, desc = "debug last" }
)
set(
	"n",
	"<leader>dn",
	"<cmd>lua require('neotest').run.run()<cr>",
	{ noremap = true, silent = true, desc = "run nearest" }
)
set(
	"n",
	"<leader>dN",
	"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
	{ noremap = true, silent = true, desc = "debug nearest" }
)
set(
	"n",
	"<leader>do",
	"<cmd>lua require('neotest').output.open({ enter = true })<cr>",
	{ noremap = true, silent = true, desc = "output" }
)
set("n", "<leader>dS", "<cmd>lua require('neotest').run.stop()<cr>", { noremap = true, silent = true, desc = "stop" })
set(
	"n",
	"<leader>ds",
	"<cmd>lua require('neotest').summary.toggle()<cr>",
	{ noremap = true, silent = true, desc = "summary" }
)
