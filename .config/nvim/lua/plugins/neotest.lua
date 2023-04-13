require("neotest").setup({
	adapters = {
		require("neotest-rust"),
		require("neotest-plenary"),
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
			args = { "-count=1", "-timeout=60s" },
		}),
		-- require("neotest-vim-test")({
		-- 	ignore_file_types = { "python", "vim", "lua", "rust", "go" },
		-- }),
	},
})
