local notify = require("notify")
vim.notify = notify

notify.setup({
	stages = "fade",
	timeout = 2000,
	max_width = 50,
	background_colour = "#000000",
})
