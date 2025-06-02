return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local logo = [[
               ___                       __                         __      
              /\_ \                     /\ \                       /\ \__   
          ____\//\ \       __       ___ \ \ \/'\      ___       __ \ \ ,_\  
         /',__\ \ \ \    /'__`\    /'___\\ \ , <    /' _ `\   /'__`\\ \ \/  
        /\__, `\ \_\ \_ /\ \L\.\_ /\ \__/ \ \ \\`\  /\ \/\ \ /\  __/ \ \ \_ 
        \/\____/ /\____\\ \__/.\_\\ \____\ \ \_\ \_\\ \_\ \_\\ \____\ \ \__\
         \/___/  \/____/ \/__/\/_/ \/____/  \/_/\/_/ \/_/\/_/ \/____/  \/__/
    ]]
    local header_color = "GruvboxBlue"
    local button_color = "GruvboxYellow"
    local footer_color = "GruvboxAqua"

    local header_padding = 6
    local button_padding = 4
    local footer_padding = 2

    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = vim.split(logo, "\n")

    -- override button hl color
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = button_color
      return b
    end

    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("n", " " .. " new file",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("f", " " .. " find file",       LazyVim.pick()),
      dashboard.button("r", " " .. " recent files",    LazyVim.pick("oldfiles")),
      dashboard.button("g", " " .. " find text",       LazyVim.pick("live_grep")),
      dashboard.button("c", " " .. " config",          LazyVim.pick.config_files()),
      dashboard.button("l", "󰒲 " .. " lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("x", " " .. " lazy extras",     "<cmd> LazyExtras <cr>"),
      dashboard.button("q", " " .. " quit",            "<cmd> qa <cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = button_color
    end
    dashboard.section.header.opts.hl = header_color
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = footer_color
    dashboard.config.layout = {
      { type = "padding", val = header_padding },
      dashboard.section.header,
      { type = "padding", val = button_padding },
      dashboard.section.buttons,
      { type = "padding", val = footer_padding },
      dashboard.section.footer,
    }
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,

  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local plugins = "   󰂖 " .. stats.loaded .. "/" .. stats.count .. " plugins [" .. ms .. "ms]"
        local datetime = os.date(" %m-%d-%Y")
        local version = vim.version()
        local nvim_version_info = "   " .. version.major .. "." .. version.minor .. "." .. version.patch
        dashboard.section.footer.val = datetime .. nvim_version_info .. plugins
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
