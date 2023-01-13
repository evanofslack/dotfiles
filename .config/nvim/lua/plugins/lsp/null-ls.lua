local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- ensure autosave formatting with null-ls
local autosave_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				autosave_formatting(bufnr)
			end,
		})
	end
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	on_attach = on_attach,
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.black,
		formatting.isort,
		formatting.gofmt,
		formatting.goimports,
		formatting.markdownlint,
		formatting.rustfmt,
		formatting.rustywind,
		formatting.stylua,
		formatting.terrafmt,
		formatting.trim_newlines,
		formatting.trim_whitespace,
		formatting.yamlfmt,

		diagnostics.dotenv_linter,
		diagnostics.eslint,
		diagnostics.flake8,
		diagnostics.golangci_lint,
		diagnostics.hadolint,
		diagnostics.markdownlint,
		diagnostics.todo_comments,
		diagnostics.trail_space,
		diagnostics.zsh,

		diagnostics.cspell.with({
			filetypes = { "markdown" },
		}),
		code_actions.cspell.with({
			filetypes = { "markdown" },
		}),
	},
})
