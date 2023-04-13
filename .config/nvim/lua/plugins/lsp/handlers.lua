local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		virtual_lines = true, -- enable virtual lines
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(
		bufnr,
		"n",
		"gd",
		"<cmd>lua vim.lsp.buf.definition()<CR>",
		{ noremap = true, silent = true, desc = "go to definition" }
	)
	keymap(
		bufnr,
		"n",
		"gD",
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		{ noremap = true, silent = true, desc = "go to declaration" }
	)
	keymap(
		bufnr,
		"n",
		"gi",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		{ noremap = true, silent = true, desc = "go to implementation" }
	)
	keymap(
		bufnr,
		"n",
		"gr",
		"<cmd>lua vim.lsp.buf.references()<CR>",
		{ noremap = true, silent = true, desc = "go to references" }
	)
	keymap(
		bufnr,
		"n",
		"gl",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true, desc = "open diagnostic" }
	)
	keymap(
		bufnr,
		"n",
		"gk",
		"<cmd>lua vim.lsp.buf.hover()<CR>",
		{ noremap = true, silent = true, desc = "see hover definition" }
	)
	-- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true, silent = true, desc = "" }) -- redefined by lsp-code-action-menu
	keymap(
		bufnr,
		"n",
		"[g",
		"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
		{ noremap = true, silent = true, desc = "go to next diagnostic" }
	)
	keymap(
		bufnr,
		"n",
		"]g",
		"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
		{ noremap = true, silent = true, desc = "go to previous diagnostic" }
	)
	-- keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = "" }) -- redefined in inc-rename
	keymap(
		bufnr,
		"n",
		"<leader>ls",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true, desc = "see signature help" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>lq",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		{ noremap = true, silent = true, desc = "see location list" }
	)
	keymap(
		bufnr,
		"n",
		"<leader>li",
		"<cmd>LspInfo<cr>",
		{ noremap = true, silent = true, desc = "see attached LSP info" }
	)
	keymap(bufnr, "n", "<leader>lm", "<cmd>Mason<cr>", { noremap = true, silent = true, desc = "see Mason info" })
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- lsp_keymaps(bufnr)

	-- winbar context
	local status_navic_ok, navic = pcall(require, "nvim-navic")
	if status_navic_ok then
		if client.server_capabilities["documentSymbolProvider"] then
			navic.attach(client, bufnr)
		end
	end
end

return M
