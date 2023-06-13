local status_ok, hlundo = pcall(require, "highlight-undo")
if not status_ok then
	return
end

vim.cmd([[highlight HighlightUndo guibg=#434343 gui=nocombine]])

hlundo.setup({
    hlgroup = 'HighlightUndo',
    duration = 500,
    keymaps = {
      {'n', 'u', 'undo', {}},
      {'n', '<C-r>', 'redo', {}},
    }
})
