local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function footer()
	local datetime = os.date(" %m-%d-%Y   %H:%M")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return datetime .. nvim_version_info
end
dashboard.section.footer.val = footer()

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
