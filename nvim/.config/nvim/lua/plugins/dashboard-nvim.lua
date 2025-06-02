return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
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

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "ene | startinsert",                              desc = " new file",        icon = " ", key = "n" },
          { action = 'lua LazyVim.pick()()',                           desc = " find file",       icon = " ", key = "f" },
          { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " recent files",    icon = " ", key = "r" },
          { action = 'lua LazyVim.pick("live_grep")()',                desc = " find text",       icon = " ", key = "g" },
          { action = 'lua LazyVim.pick.config_files()()',              desc = " config",          icon = " ", key = "c" },
          { action = "Lazy",                                           desc = " lazy",            icon = "󰒲 ", key = "l" },
          { action = "LazyExtras",                                     desc = " lazy extras",     icon = " ", key = "x" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local plugins = "   󰂖 " .. stats.loaded .. "/" .. stats.count .. " plugins [" .. ms .. "ms]"
          local datetime = os.date(" %m-%d-%Y")
          local version = vim.version()
          local nvim_version_info = "   " .. version.major .. "." .. version.minor .. "." .. version.patch
          return { datetime .. nvim_version_info .. plugins }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
