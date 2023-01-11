local lsp = require("lsp-zero")

---------- lsp ----------

-- lsp.preset("recommended")
lsp.preset("lsp-compe")

lsp.ensure_installed({
	"html",
	"cssls",
	"tsserver",
	"eslint",
	"sumneko_lua",
	"rust_analyzer",
	"gopls",
	"pyright",
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	set_lsp_keymaps = { omit = { "k", "K" } },
})

---------- cmp ----------

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- for autopairs
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local cmp_config = lsp.defaults.cmp_config({
	window = {
		completion = cmp.config.window.bordered(),
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	},
})

cmp.setup(cmp_config)

---------- nvim-navic ----------

local navic = require("nvim-navic")
local barbecue = require("barbecue")

barbecue.setup({
	attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
	theme = {
		basename = { bold = false },
	},
	modifiers = {
		dirname = ":s?.*??",
	},
})

local navic_attach = function(client, bufnr)
	if client.server_capabilities["documentSymbolProvider"] then
		navic.attach(client, bufnr)
	end
end

lsp.configure("rust_analyzer", {
	on_attach = navic_attach,
})

lsp.configure("gopls", {
	on_attach = navic_attach,
})

lsp.configure("pyright", {
	on_attach = navic_attach,
})

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
	on_attach = navic_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

---------- setup lsp before null-ls ----------

lsp.setup()

---------- null-ls ----------

local null_ls = require("null-ls")

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.diagnostics.dotenv_linter,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.tfsec,
		null_ls.builtins.diagnostics.todo_comments,
		null_ls.builtins.diagnostics.trail_space,
		null_ls.builtins.diagnostics.zsh,

		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.rustywind,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.terrafmt,
		null_ls.builtins.formatting.trim_newlines,
		null_ls.builtins.formatting.trim_whitespace,
		null_ls.builtins.formatting.yamlfmt,
	},
})

---------- diagnostics ----------
vim.diagnostic.config({
	virtual_text = true,
})
