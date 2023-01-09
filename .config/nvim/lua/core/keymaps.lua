local set = vim.keymap.set

-- vertical movement
set('n', 'J', '<c-d>')
set('n', 'K', '<c-u>')
set('v', 'J', '}')
set('v', 'K', '{')

-- move by visual line not buffer
set('n', 'j', 'gj', { noremap = true})
set('n', 'k', 'gk', { noremap = true})

-- move in insert mode
set('i', '<c-h>', '<left>', { noremap = true})
set('i', '<c-l>', '<right>', { noremap = true})
set('i', '<c-j>', '<down>', { noremap = true})
set('i', '<c-k>', '<up>', { noremap = true})

-- unmap arrow keys
set({'n', 'v', 'i'}, '<up>', '<nop>', { noremap = true})
set({'n', 'v', 'i'}, '<down>', '<nop>', { noremap = true})
set({'n', 'v', 'i'}, '<left>', '<nop>', { noremap = true})
set({'n', 'v', 'i'}, '<right>', '<nop>', { noremap = true})

-- tab navigation
set('n', '<Tab>', '<cmd>bn<cr>', { noremap = true})
set('n', '<S-Tab>', '<cmd>bp<cr>', { noremap = true})

-- indent and keep selection
set('x', '<Tab>', '>gv', { noremap = true})
set('x', '<S-Tab>', '<gv', { noremap = true})
set('x', '>', '>gv', { noremap = true})
set('x', '<', '<gv', { noremap = true})

-- unsets the last search pattern register by hitting return
set('n', '<cr>', '<cmd>noh<cr><cr>', { noremap = true})

-- nvimtree toggle
set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', { noremap = true})
-- nnoremap <leader>n :NvimTreeToggle<CR>

-- quicksave
set('n', '<leader>w', ':w<cr>', { silent = false })

-- close buffer without losing window layout
set("n", "<leader>d", "<cmd>Bdelete<cr>")


-- autocompletion

-- goto code navigation.

-- show documentation in preview window.

-- yank list
-- nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

-- telescope 
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', builtin.git_files, { desc = 'find git files'})
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'search with grep' })
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = 'search undo history'})

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] find recently opened files' })
vim.keymap.set('n', '<leader>;', builtin.buffers, { desc = '[ ] find existing buffers' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
