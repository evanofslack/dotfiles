local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local neovim = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

local slacknet = {
	[[                                                                    ]],
	[[                                                                    ]],
	[[                                                                    ]],
	[[       ___                       __                         __      ]],
	[[      /\_ \                     /\ \                       /\ \__   ]],
	[[  ____\//\ \       __       ___ \ \ \/'\      ___       __ \ \ ,_\  ]],
	[[ /',__\ \ \ \    /'__`\    /'___\\ \ , <    /' _ `\   /'__`\\ \ \/  ]],
	[[/\__, `\ \_\ \_ /\ \L\.\_ /\ \__/ \ \ \\`\  /\ \/\ \ /\  __/ \ \ \_ ]],
	[[\/\____/ /\____\\ \__/.\_\\ \____\ \ \_\ \_\\ \_\ \_\\ \____\ \ \__\]],
	[[ \/___/  \/____/ \/__/\/_/ \/____/  \/_/\/_/ \/_/\/_/ \/____/  \/__/]],
	[[                                                                    ]],
	[[                                                                    ]],
}

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = slacknet

dashboard.section.buttons.val = {
	dashboard.button("t", " " .. " new file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", " " .. " find file", ":Telescope find_files <CR>"),
	dashboard.button("r", " " .. " recent files", ":Telescope oldfiles <CR>"),
	-- dashboard.button("g", " " .. " find text", ":Telescope live_grep <CR>"),
	dashboard.button("n", "פּ " .. " nvim-tree", ":NvimTreeToggle<CR>"),
	dashboard.button(
		"l",
		" " .. " git",
		":lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<cr>"
	),
	dashboard.button("u", "ﮮ " .. " update plugins", ":PackerUpdate <CR>"),
	dashboard.button("s", " " .. " sync plugins", ":PackerUpdate <CR>"),
	dashboard.button("c", " " .. " config", ":e $MYVIMRC <CR>"),
	dashboard.button("q", " " .. " quit", ":qa<CR>"),
}

-- local function footer()
-- 	-- local plugins = #vim.tbl_keys(packer_plugins)
-- 	-- local plugin_info = " " .. plugins
-- 	local datetime = os.date(" %m-%d-%Y   %H:%M")
-- 	local version = vim.version()
-- 	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
--
-- 	-- return plugin_info .. datetime .. nvim_version_info
-- 	return datetime .. nvim_version_info
-- end

local function footer()
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return datetime .. "   " .. " plugins" .. nvim_version_info
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "GruvboxYellow"
dashboard.section.header.opts.hl = "GruvboxBlue"
-- dashboard.section.buttons.opts.hl = "GruvboxGreen"

alpha.setup(dashboard.opts)
