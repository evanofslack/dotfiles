local status_ok, lens = pcall(require, "lsp-lens")
if not status_ok then
	return
end

lens.setup({
	enable = true,
	include_declaration = false, -- Reference include declaration
	sections = { -- Enable / Disable specific request
		definition = false,
		references = true,
		implementation = true,
	},
	ignore_filetype = {
		"prisma",
	},
})
