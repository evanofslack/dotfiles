local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-------------------- ui --------------------

	-- themes
	"evanofslack/gruvbox.nvim", -- the best colorscheme
	"sitiom/nvim-numbertoggle", -- switch between relative and absolute line numbers
	"lewis6991/gitsigns.nvim", -- git icons in gutter
	"lukas-reineke/indent-blankline.nvim", -- visual identation guide
	"yamatsum/nvim-cursorline", -- hightlight word under cursor
	"smjonas/inc-rename.nvim", -- visual renaming
	"stevearc/dressing.nvim", -- window ui
	"simrat39/symbols-outline.nvim", -- tree view for lsp symbols
	"noib3/nvim-cokeline", -- bufferline
	'dstein64/nvim-scrollview', -- scrollbar
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- statusline
	{ "goolord/alpha-nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- start page
	{ "j-hui/fidget.nvim", version = "legacy" }, -- lsp loading progress

	-------------------- core --------------------

	-- telescope
	"nvim-lua/plenary.nvim",
	"debugloop/telescope-undo.nvim",
	"jvgrootveld/telescope-zoxide",
	"AckslD/nvim-neoclip.lua",
	"nvim-telescope/telescope-live-grep-args.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	"aaronhallaert/advanced-git-search.nvim",
	"LinArcX/telescope-env.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope.nvim", version = "0.1.0" },

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
	},
	{ "haringsrob/nvim_context_vt", dependencies = { "nvim-treesitter/nvim-treesitter" } },

	-- lsp
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim", -- formatting / linting / diagnostics
	"SmiteshP/nvim-navic", -- winbar context
	"utilyre/barbecue.nvim", -- winbar context
	"kosayoda/nvim-lightbulb", -- code action indicator
	"aznhe21/actions-preview.nvim", -- show code actions
	"dnlhc/glance.nvim", -- lsp locations UI
	"VidocqH/lsp-lens.nvim", -- display reference counts
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- render lsp errors as virtual text

	-- cmp
	"hrsh7th/nvim-cmp", -- the completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp-signature-help", -- function parameters
	"hrsh7th/cmp-nvim-lsp", -- lsp completions
	"hrsh7th/cmp-nvim-lua", -- lua completions
	"dmitmel/cmp-cmdline-history", -- cmdline history completions
	"hrsh7th/cmp-cmdline", -- cmdline buffer completions
	"lukas-reineke/cmp-under-comparator", -- deprioritize underline prefixed suggestions

	-- snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	-------------------- utility --------------------

	"numToStr/Comment.nvim", -- comment lines
	"famiu/bufdelete.nvim", -- delete buffers without changing layout
	"wakatime/vim-wakatime", -- track coding stats
	"ActivityWatch/aw-watcher-vim", -- track activity stats
	"norcalli/nvim-colorizer.lua", -- color highlighter
	"tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
	"windwp/nvim-autopairs", -- autopair symbols
	"karb94/neoscroll.nvim", -- smooth scroll
	"rcarriga/nvim-notify", -- notifications
	"folke/which-key.nvim", --keymappings
	"folke/zen-mode.nvim", -- go zen mode
	"ziontee113/icon-picker.nvim", -- pick nerdfont icons
	"ziontee113/color-picker.nvim", -- color picker
	"tpope/vim-fugitive", -- git
	"tpope/vim-rhubarb", -- github
	"sindrets/diffview.nvim", -- diff and merge conflicts
	"ThePrimeagen/harpoon", -- mark-like navigator
	"nosduco/remote-sshfs.nvim", -- remote filesystem
	"luukvbaal/statuscol.nvim", -- status column improvements
	"tzachar/highlight-undo.nvim", -- highlight undos
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" }, -- folding
	{ "kylechui/nvim-surround", version = "*" }, -- change matching tags
	{ "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" }, -- diagnostics
	{ "akinsho/toggleterm.nvim", version = "*", config = true }, -- hover terminal
	{ "Bryley/neoai.nvim", dependencies = "MunifTanjim/nui.nvim" }, -- chatGPT in the editor
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- file explorer
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		  build = function()
			require("dbee").install("go")
		  end,
	}, -- db client
	{ "mfussenegger/nvim-dap", dependencies = { "rcarriga/nvim-dap-ui", "nvim-telescope/telescope-dap.nvim" } }, -- run debugger
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
			"nvim-neotest/neotest-vim-test",
		},
	}, -- run tests

	-------------------- movement --------------------

	"alexghergh/nvim-tmux-navigation", -- navigate tmux
	"ggandor/leap.nvim", -- quick jumping
	"cbochs/portal.nvim", -- quick jump through lists
})
