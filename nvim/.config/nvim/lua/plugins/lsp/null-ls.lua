local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- local autoformat = vim.b.autoformat
local autoformat = false

local function toggle_autoformat()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		autoformat = true
	else
		autoformat = not autoformat
	end
	if autoformat then
		vim.notify("lsp format on save enabled")
	else
		vim.notify("lsp format on save disabled")
	end
end

-- ensure autosave formatting with null-ls
local autosave_formatting = function(bufnr)
	if vim.b.autoformat == false then
		return
	end
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
				if autoformat then
					autosave_formatting(bufnr)
				end
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
		formatting.prettier,
		formatting.black,
		formatting.isort,
		formatting.gofmt,
		formatting.goimports,
		formatting.markdownlint,
		formatting.rustfmt,
		formatting.rustywind,
		formatting.stylua,
		formatting.terraform_fmt,
		formatting.trim_newlines,
		formatting.trim_whitespace,
		formatting.yamlfmt,

		diagnostics.dotenv_linter,
		diagnostics.eslint,
		diagnostics.ruff,
		-- diagnostics.flake8,
		-- diagnostics.flake8.with({
		-- 	args = { "--max-line-length", "150" },
		-- }),
		diagnostics.golangci_lint.with({
			args = { "run", "--concurrency=1", "--fix=false", "--out-format=json", "--path-prefix", "$ROOT" },
		}),
		-- diagnostics.hadolint,
		diagnostics.markdownlint,
		-- diagnostics.todo_comments,
		-- diagnostics.trail_space,
		diagnostics.zsh,

		-- diagnostics.cspell.with({
		-- 	filetypes = { "markdown", "text" },
		-- }),
		-- code_actions.cspell.with({
		-- 	filetypes = { "markdown", "text" },
		-- }),
	},
})

vim.keymap.set("n", "<Leader>lf", function()
	toggle_autoformat()
end, { desc = "toggle lsp  format on save" })
