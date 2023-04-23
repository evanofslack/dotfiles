local status_ok, statuscol = pcall(require, "statuscol")
if not status_ok then
	return
end

local builtin = require("statuscol.builtin")

cfg = {
	setopt = true,
	relculright = true,
	segments = {
		{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	},
}

statuscol.setup(cfg)
