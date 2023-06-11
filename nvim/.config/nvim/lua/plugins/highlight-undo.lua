local status_ok, hlundo = pcall(require, "highlight-undo")
if not status_ok then
	return
end

hlundo.setup({
    hlgroup = 'HighlightUndo',
    duration = 300,
    keymaps = {
      {'n', 'u', 'undo', {}},
      {'n', '<C-r>', 'redo', {}},
    }
})
