local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	return
end

scrollview.setup({
  excluded_filetypes = {'nerdtree'},
  current_only = true,
  winblend = 75,
  base = 'right',
  column = 2,
  signs_on_startup = {'search', 'diagnostics'},
  diagnostics_severities = {vim.diagnostic.severity.ERROR}
})
