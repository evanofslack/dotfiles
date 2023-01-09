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
    dashboard.button( "e", "  > New file" , "<cmd>ene <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME/Desktop | :Files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":History<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
