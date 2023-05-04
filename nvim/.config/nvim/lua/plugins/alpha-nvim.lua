local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local header_color = "GruvboxBlue"
local button_color = "GruvboxYellow"
local footer_color = "GruvboxAqua"

local header_padding = 6
local button_padding = 4
local footer_padding = 2

local slacknet = {
	[[       ___                       __                         __      ]],
	[[      /\_ \                     /\ \                       /\ \__   ]],
	[[  ____\//\ \       __       ___ \ \ \/'\      ___       __ \ \ ,_\  ]],
	[[ /',__\ \ \ \    /'__`\    /'___\\ \ , <    /' _ `\   /'__`\\ \ \/  ]],
	[[/\__, `\ \_\ \_ /\ \L\.\_ /\ \__/ \ \ \\`\  /\ \/\ \ /\  __/ \ \ \_ ]],
	[[\/\____/ /\____\\ \__/.\_\\ \____\ \ \_\ \_\\ \_\ \_\\ \____\ \ \__\]],
	[[ \/___/  \/____/ \/__/\/_/ \/____/  \/_/\/_/ \/_/\/_/ \/____/  \/__/]],
}

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = slacknet

-- override button hl color
local function button(sc, txt, keybind, keybind_opts)
	local b = dashboard.button(sc, txt, keybind, keybind_opts)
	b.opts.hl_shortcut = button_color
	return b
end

dashboard.section.buttons.val = {
	button("a", " " .. " new file", ":ene <BAR> startinsert <CR>"),
	button("f", " " .. " find file", ":Telescope find_files <CR>"),
	button("r", " " .. " recent files", ":Telescope oldfiles <CR>"),
	button("t", " " .. " find text", ":Telescope live_grep <CR>"),
	button("n", "פּ " .. " file tree", ":NvimTreeToggle<CR>"),
	-- button("u", "ﮮ " .. " update plugins", ":PackerUpdate <CR>"),
	button("s", " " .. " sync plugins", ":PackerUpdate <CR>"),
	button(
		"g",
		" " .. " git",
		":lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<cr>"
	),
	button("c", " " .. " config", ":e $MYVIMRC <CR>"),
	button("q", " " .. " quit", ":qa<CR>"),
}

local function footer()
	local eslack = "eslack_dotfiles  "
	local datetime = os.date(" %m-%d-%Y")
	local version = vim.version()
	local nvim_version_info = "  nvim v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return eslack .. datetime .. nvim_version_info
end
dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = header_color
dashboard.section.footer.opts.hl = footer_color

dashboard.config.layout = {
	{ type = "padding", val = header_padding },
	dashboard.section.header,
	{ type = "padding", val = button_padding },
	dashboard.section.buttons,
	{ type = "padding", val = footer_padding },
	dashboard.section.footer,
}

alpha.setup(dashboard.opts)
