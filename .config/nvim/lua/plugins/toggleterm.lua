require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	direction = "float",
	float_opts = {
		border = "curved",
		winblend = 5,
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<c-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
