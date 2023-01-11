local custom_gruvbox = require("lualine.themes.gruvbox")

local config = {
	options = {
		theme = custom_gruvbox,
		globalstatus = false,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_c = {},
	},
	extensions = { "nvim-tree" },
}

-- inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- insert spacing section
ins_left({
	function()
		return "%="
	end,
	separator = { left = "", right = "" },
})

-- insert lsp server name
ins_left({
	function()
		local no_active = "no active lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return no_active
		end
		local lsps = {}
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(lsps, client.name)
			end
		end
		return table.concat(lsps, ", ")
	end,
	icon = "  lsp:",
	separator = { left = "", right = "" },
})

require("lualine").setup(config)
