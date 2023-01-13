local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	-- have packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 60, -- timeout, in seconds, for git clones
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- packer itself

	-------------------- ui --------------------

	use({ "ellisonleao/gruvbox.nvim" }) -- theme (gruvbox)
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }) -- statusline
	use({ "goolord/alpha-nvim", requires = { "nvim-tree/nvim-web-devicons" } }) -- start page
	use({ "sitiom/nvim-numbertoggle" }) -- switch between relative and absolute line numbers
	use({ "melkster/modicator.nvim", after = "gruvbox.nvim" }) -- line number corresponds w/ command mode
	use({ "kyazdani42/nvim-web-devicons", event = "BufEnter" }) -- icons
	use({ "lewis6991/gitsigns.nvim" }) -- git icons in gutter
	use({ "lukas-reineke/indent-blankline.nvim" }) -- visual identation guide
	use({ "j-hui/fidget.nvim" }) -- lsp loading progress
	use({ "yamatsum/nvim-cursorline" }) -- hightlight word under cursor

	-------------------- core --------------------

	-- telescope
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "debugloop/telescope-undo.nvim" })
	use({ "jvgrootveld/telescope-zoxide" })
	use({ "AckslD/nvim-neoclip.lua" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- formatting / linting
	use({ "SmiteshP/nvim-navic" }) -- winbar context
	use({ "utilyre/barbecue.nvim" }) -- winbar context

	-- cmp
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	-- use({ "hrsh7th/cmp-nvim-lsp-signature-help" }) -- function parameters
	-- use({ "folke/neodev.nvim" }) -- vim api completions

	-- snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })

	-------------------- utility --------------------

	use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } }) -- file explorer
	use({ "numToStr/Comment.nvim" }) -- comments
	use({ "famiu/bufdelete.nvim" }) -- delete buffers without changing layout
	use({ "wakatime/vim-wakatime" }) -- track coding stats
	use({ "norcalli/nvim-colorizer.lua" }) -- color highlighter
	use({ "tpope/vim-sleuth" }) -- detect tabstop and shiftwidth automatically
	use({ "windwp/nvim-autopairs" }) -- autopair symbols
	use({ "kylechui/nvim-surround", tag = "*" }) -- change matching tags
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- diagnostics
	use({ "akinsho/toggleterm.nvim", tag = "*" }) -- hover terminal
	use({ "karb94/neoscroll.nvim" }) -- smooth scroll
	use({ "rcarriga/nvim-notify" }) -- notifications
	use({ "folke/which-key.nvim" }) --keymappings
	use({ "folke/zen-mode.nvim" }) -- go zen mode
	use({ "dstein64/vim-startuptime" }) -- startup time
	use({ "lewis6991/impatient.nvim" }) -- load faster pls

	-------------------- movement --------------------

	use({ "alexghergh/nvim-tmux-navigation" }) -- navigate tmux
	use({ "ggandor/leap.nvim" }) -- quick jumping

	-- automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
