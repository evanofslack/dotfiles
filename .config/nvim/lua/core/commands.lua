local autocmd = vim.api.nvim_create_autocmd

-- source init.lua on save
autocmd("BufWritePost", { pattern = "vim.env.MYVIMRC", command = "source $MYVIMRC" })

-- run packer sync on plugin list change
autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })

-- highlight yanked text
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
	end,
})

-- stop auto newline comments
autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
