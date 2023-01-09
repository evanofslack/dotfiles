local g = vim.g
local opt = vim.opt

-- disable distribution plugins
g.loaded_netrwFileHandlers = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1

-- autocomplete
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.pumheight = 10

-- search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- save
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- looks
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.showmode = true
opt.signcolumn = 'yes'
-- opt.colorcolumn = "100"
opt.laststatus = 2

-- spacing
opt.autoindent = true
opt.copyindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- essentials
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 10
opt.updatetime = 50
opt.timeoutlen = 300

-- interaction
opt.mouse = 'nvic'
opt.clipboard = 'unnamedplus'

-- misc
opt.wildignorecase = true
opt.wildignore =
  '.git,*.pyc,**/tmp/**,*.DS_Store,**/node_modules/**'
opt.history = 100
