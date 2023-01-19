local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
	return
end

barbecue.setup({
	attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
	theme = {
		basename = { bold = false },
	},
	modifiers = {
		-- dirname = ":s?.*??",
	},
})
