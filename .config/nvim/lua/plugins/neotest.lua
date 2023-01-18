require("neotest").setup({
	adapters = {
		require("neotest-rust"),
		require("neotest-plenary"),
		require("neotest-vim-test")({
			ignore_file_types = { "python", "vim", "lua", "rust", "go" },
		}),
	},
})
