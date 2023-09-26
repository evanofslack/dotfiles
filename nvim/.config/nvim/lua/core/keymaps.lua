local set = vim.keymap.set
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
set("n", "<c-w>", "<cmd>noautocmd w<cr>", { noremap = true, silent = false, desc = "quicksave no autocommand" })
-- quicksave and format
set("n", "<leader><s-w>", function()
	vim.lsp.buf.format({ async = true })
	vim.api.nvim_command("write")
end, { noremap = true, silent = false, desc = "quicksave w/ format" })

-- close buffer without closing window layout
set("n", "<leader>bd", "<cmd>Bdelete<cr>", { noremap = true, silent = false, desc = "close buffer" })
set("n", "<leader>bv", "<cmd>:vsplit<cr>", { noremap = true, silent = false, desc = "split buffer vertically" })
set("n", "<leader>bh", "<cmd>:split<cr>", { noremap = true, silent = false, desc = "split buffer horizontally" })

-- copy/paste from system clipboard
set({ "n", "v" }, "<c-y>", [["+y]])
set({ "n", "v" }, "<c-p>", [["+p]])
set({ "i" }, "<c-p>", [[<esc>"+pi]])

-- move visual highlighted text
set("v", "<c-j>", ":m '>+1<CR>gv=gv")
set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- resizing panes
set({ "n", "v" }, "<Left>", ":vertical resize +1<CR>", default_opts)
set({ "n", "v" }, "<Right>", ":vertical resize -1<CR>", default_opts)
set({ "n", "v" }, "<Up>", ":resize -1<CR>", default_opts)
set({ "n", "v" }, "<Down>", ":resize +1<CR>", default_opts)

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
set("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })

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

set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "search undo history" })
set("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", { desc = "search clipboard history" })
set("n", "<leader>fz", "<cmd>Telescope zoxide list<cr>", { desc = "navigate with zoxide" })
set("n", "<leader>fn", "<cmd>Telescope notify <cr>", { desc = "search notifications" })
set("n", "<leader>ft", "<cmd>:TodoTelescope<cr>", { desc = "search todos" })

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
-- handled by glances
-- set(
-- 	"n",
-- 	"<leader>gi",
-- 	"<cmd>lua vim.lsp.buf.implementation()<CR>",
-- 	{ noremap = true, silent = true, desc = "go to implementation" }
-- )
-- handled by glances
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

set(
	{ "n", "v" },
	"<leader>la",
	require("actions-preview").code_actions,
	{ noremap = true, silent = true, desc = "show code actions" }
)

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

set("n", "<leader>ss", ":SearchBoxReplace<CR>")
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
set("n", "<Leader>lt", function()
	local val = not vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = val })
	vim.diagnostic.config({ virtual_lines = not val })
	vim.notify("lsp virtual text set to " .. tostring(val))
end, { desc = "toggle lsp_lines" })

-- advanced git search
set("n", "<leader>hb", ext.advanced_git_search.diff_branch_file, { desc = "diff branches of current file" })
set("n", "<leader>hf", ext.advanced_git_search.diff_commit_file, { desc = "diff commits of current file" })
set("n", "<leader>hc", ext.advanced_git_search.search_log_content, { desc = "search all previous commits" })
set("n", "<leader>hg", ext.advanced_git_search.search_log_content_file, { desc = "search commits for current file" })
set("n", "<leader>hr", ext.advanced_git_search.checkout_reflog, { desc = "search reflog" })

-- gitsigns
set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true, desc = "stage hunk" })
set({ "n", "v" }, "<leader>hu", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "unstage hunk" })
set("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", { noremap = true, silent = true, desc = "stage buffer" })
set("n", "<leader>hU", ":Gitsigns undo_stage_hunk<CR>", { noremap = true, silent = true, desc = "undo stage buffer" })
set("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true, desc = "reset buffer" })
set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true, desc = "preview buffer" })
set(
	"n",
	"<leader>ht",
	":Gitsigns toggle_current_line_blame<CR>",
	{ noremap = true, silent = true, desc = "toggle blame line" }
)

-- gitlinker
set(
	{ "n", "x" },
	"<leader>hl",
	'<cmd>lua require("gitlinker").link({action = require("gitlinker.actions").clipboard})<cr>',
	{ desc = "Copy git link to clipboard" }
)
set(
	{ "n", "x" },
	"<leader>hL",
	'<cmd>lua require("gitlinker").link({action = require("gitlinker.actions").system})<cr>',
	{ desc = "Open git link in browser" }
)

-- diffview
set("n", "<leader>hd", ":DiffviewOpen<CR>", { noremap = true, silent = true, desc = "diff" })
set("n", "<leader>hh", ":DiffviewFileHistory<CR>", { noremap = true, silent = true, desc = "file history" })

-- git mergetool
set("n", "<leader>h1", "<cmd> diffget LOCAL<CR>", { noremap = true, silent = true, desc = "pick local" })
set("n", "<leader>h2", "<cmd> diffget BASE<CR>", { noremap = true, silent = true, desc = "pick base" })
set("n", "<leader>h3", "<cmd> diffget REMOTE<CR>", { noremap = true, silent = true, desc = "pick remote" })

local gs = package.loaded.gitsigns
set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		require("gitsigns").next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "navigate to next git hunk" })

set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		require("gitsigns").prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "navigate to previous git hunk" })

-- trouble
set("n", "<leader>fd", "<cmd>TroubleToggle<cr>", { silent = true, desc = "show diagnostics" })
-- set("n", "<leader>gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "lsp references (trouble)" })

-- todo comments
set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- show treesitter capture group for textobject under cursor.
set("n", "<leader>sh", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, { noremap = true, silent = false, desc = "show treesitter highlight group" })

-- symbols-outline
set("n", "<leader>N", "<cmd>SymbolsOutline<cr>", { silent = true, desc = "show symbol outline" })

-- lazy
set("n", "<leader>x", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = "lazy" })

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

-- harpoon
set(
	"n",
	"<leader>aa",
	"<cmd>lua require('harpoon.mark').add_file()<cr>",
	{ noremap = true, silent = true, desc = "add file to marks" }
)
set(
	"n",
	"<leader>a<leader>",
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
	{ noremap = true, silent = true, desc = "toggle menu" }
)
set(
	"n",
	"<leader>a1",
	"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
	{ noremap = true, silent = true, desc = "jump file 1" }
)
set(
	"n",
	"<leader>a2",
	"<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
	{ noremap = true, silent = true, desc = "jump file 2" }
)
set(
	"n",
	"<leader>a3",
	"<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
	{ noremap = true, silent = true, desc = "jump file 3" }
)
set(
	"n",
	"<leader>a4",
	"<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
	{ noremap = true, silent = true, desc = "jump file 4" }
)

set(
	"n",
	"<leader>a<Tab>",
	"<cmd>lua require('harpoon.ui').nav_next()<cr>",
	{ noremap = true, silent = true, desc = "jump next file" }
)
set(
	"n",
	"<leader>a<S-Tab>",
	"<cmd>lua require('harpoon.ui').nav_prev()<cr>",
	{ noremap = true, silent = true, desc = "jump prev file" }
)
set(
	"n",
	"<leader>at",
	"<cmd>lua require('telescope').extensions.harpoon.marks()<cr>",
	{ noremap = true, silent = true, desc = "jump harpoon file" }
)

-- remote-sshfs
local api = require("remote-sshfs.api")
set("n", "<leader>rc", api.connect, { noremap = true, silent = true, desc = "connect to remote filesystem" })
set("n", "<leader>rd", api.disconnect, { noremap = true, silent = true, desc = "disconnect from remote filesystem" })
set("n", "<leader>re", api.edit, { noremap = true, silent = true, desc = "edit ssh config" })

-- ufo
set("n", "<leader>z<leader>", "za", { noremap = true, silent = true, desc = "toggle fold" })
set(
	"n",
	"<leader>zr",
	require("ufo").openFoldsExceptKinds,
	{ noremap = true, silent = true, desc = "open all folds except kinds" }
)
set("n", "<leader>zm", require("ufo").closeFoldsWith, { noremap = true, silent = true, desc = "close folds with" })
set("n", "<leader>zk", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { noremap = true, silent = true, desc = "peek under fold" })

-- icon-picker
set("n", "<leader>pi", "<cmd>IconPickerInsert<cr>", { noremap = true, silent = true, desc = "icon picker" })

-- color-picker
set("n", "<leader>pc", "<cmd>PickColor<cr>", { noremap = true, silent = true, desc = "pick color" })

-- neotest
neotest = require("neotest")
set(
	"n",
	"<leader>ta",
	"<cmd>lua require('neotest').run.attach()<cr>",
	{ noremap = true, silent = true, desc = "attach" }
)
set(
	"n",
	"<leader>tf",
	"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
	{ noremap = true, silent = true, desc = "run file" }
)
set(
	"n",
	"<leader>tF",
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	{ noremap = true, silent = true, desc = "debug file" }
)
set(
	"n",
	"<leader>tl",
	"<cmd>lua require('neotest').run.run_last()<cr>",
	{ noremap = true, silent = true, desc = "run last" }
)
set(
	"n",
	"<leader>tL",
	"<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>",
	{ noremap = true, silent = true, desc = "debug last" }
)
set(
	"n",
	"<leader>td",
	"<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>",
	{ noremap = true, silent = true, desc = "run directory" }
)
set(
	"n",
	"<leader>tn",
	"<cmd>lua require('neotest').run.run()<cr>",
	{ noremap = true, silent = true, desc = "run nearest" }
)
set(
	"n",
	"<leader>tN",
	"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
	{ noremap = true, silent = true, desc = "debug nearest" }
)
set(
	"n",
	"<leader>to",
	"<cmd>lua require('neotest').output.open({ enter = true })<cr>",
	{ noremap = true, silent = true, desc = "output" }
)
set("n", "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", { noremap = true, silent = true, desc = "stop" })
set(
	"n",
	"<leader>ts",
	"<cmd>lua require('neotest').summary.toggle()<cr>",
	{ noremap = true, silent = true, desc = "summary" }
)

-- dap
set(
	"n",
	"<leader>dR",
	"<cmd>lua require'dap'.run_to_cursor()<cr>",
	{ noremap = true, silent = true, desc = "run to cursor" }
)
set(
	"n",
	"<leader>dE",
	"<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
	{ noremap = true, silent = true, desc = "evaluate input" }
)
set(
	"n",
	"<leader>dC",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
	{ noremap = true, silent = true, desc = "conditional breakpoint" }
)
set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { noremap = true, silent = true, desc = "toggle ui" })
set("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", { noremap = true, silent = true, desc = "step back" })
set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true, desc = "continue" })
set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { noremap = true, silent = true, desc = "disconnect" })
set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { noremap = true, silent = true, desc = "evaluate" })
set("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", { noremap = true, silent = true, desc = "get session" })
set(
	"n",
	"<leader>dh",
	"<cmd>lua require'dap.ui.widgets'.hover()<cr>",
	{ noremap = true, silent = true, desc = "hover variables" }
)
set(
	"n",
	"<leader>dS",
	"<cmd>lua require'dap.ui.widgets'.scopes()<cr>",
	{ noremap = true, silent = true, desc = "scopes" }
)
set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true, silent = true, desc = "step into" })
set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true, silent = true, desc = "step over" })
set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { noremap = true, silent = true, desc = "pause" })
set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { noremap = true, silent = true, desc = "quit" })
set(
	"n",
	"<leader>dr",
	"<cmd>lua require'dap'.repl.toggle()<cr>",
	{ noremap = true, silent = true, desc = "toggle repl" }
)
set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { noremap = true, silent = true, desc = "start" })
set(
	"n",
	"<leader>dt",
	"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
	{ noremap = true, silent = true, desc = "toggle breakpoint" }
)
set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { noremap = true, silent = true, desc = "terminate" })
set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true, silent = true, desc = "step out" })
set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { noremap = true, silent = true, desc = "evaluate" })
