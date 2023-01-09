local autocmd = vim.api.nvim_create_autocmd

-- source init.lua on save
autocmd('BufWritePost', {pattern = 'vim.env.MYVIMRC', command = 'source $MYVIMRC'})

-- run packer sync on plugin list change
autocmd("BufWritePost", {pattern = "plugins.lua", command = "source <afile> | PackerSync"})

-- highlight yanked text
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})

-- stop auto newline comments
autocmd("BufEnter", { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end, })
