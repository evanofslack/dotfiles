require("zen-mode").setup({
	{
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			width = 120, -- width of the Zen window
			height = 1, -- height of the Zen window
			options = {
				-- signcolumn = "no", -- disable signcolumn
				-- number = false, -- disable number column
				-- relativenumber = false, -- disable relative numbers
				-- cursorline = false, -- disable cursorline
				-- cursorcolumn = false, -- disable cursor column
				-- foldcolumn = "0", -- disable fold column
				-- list = false, -- disable whitespace characters
			},
		},
		plugins = {
			-- disable some global vim options (vim.o...)
			options = {
				enabled = true,
				ruler = false, -- disables the ruler text in the cmd line area
				showcmd = true, -- disables the command in the last line of the screen
			},
			-- gitsigns = { enabled = false }, -- disables git signs
			-- tmux = { enabled = false }, -- disables the tmux statusline
		},
		on_open = function(win) end,
		on_close = function() end,
	},
})
