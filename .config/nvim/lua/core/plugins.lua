local use = require("packer").use

return require("packer").startup({
    function()
        -- packer itself
        use({"wbthomason/packer.nvim"})

        ---------- ui ----------

        -- theme (gruvbox)
        use ({"ellisonleao/gruvbox.nvim",
            config = function() require("plugins/gruvbox") end
        })

        -- statusline and bufferline
        use ({'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function() require("plugins/lualine") end
        })

        -- tree file explorer
        use ({'nvim-tree/nvim-tree.lua',
          requires = {
            'nvim-tree/nvim-web-devicons',
          },
        config = function() require("plugins/nvim-tree") end
        })

        -- git icons in gutter
        use {'lewis6991/gitsigns.nvim',
        config = function() require("plugins/gitsigns") end
        }

        -- visual identation guide
        use ({"lukas-reineke/indent-blankline.nvim",
        config = function() require("plugins/indent-blankline") end
        })

        -- start page
        use ({'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function() require("plugins/alpha-nvim") end
        })

        -- switch between relative and absolute line numbers
        use ({"sitiom/nvim-numbertoggle"})

        -- icons 
        use({"kyazdani42/nvim-web-devicons", event = "BufEnter"})

        ---------- core ----------

        -- fuzzy finder (telescope)
        use({"nvim-lua/plenary.nvim"})
        use ({'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
        use ({"debugloop/telescope-undo.nvim"})
        use ({'nvim-telescope/telescope.nvim', tag = '0.1.0',
            config = function() require("plugins/telescope") end
        })
        
        -- treesitter
        use({"nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function() require("plugins/treesitter") end
        })
        use ({ 'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
        })

        -- lsp
        use({'VonHeikemen/lsp-zero.nvim',
          requires = {
            -- lsp Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
          },
        config = function() require('plugins/lsp') end
        })

        ---------- utility ----------

        -- comments
        use ({'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
        })
        
        -- delete buffers without changing layout
        use ({'famiu/bufdelete.nvim'})

        -- track coding stats
        use ({'wakatime/vim-wakatime'})

        -- color highlighter
        use ({'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
        })

        use ({'rcarriga/nvim-notify',
        config = function() require('plugins/notify') end
        })

        -- detect tabstop and shiftwidth automatically
        use ({'tpope/vim-sleuth'})

        ---------- movement ----------
        
        -- navigate tmux 
        use ({"alexghergh/nvim-tmux-navigation",
        config = function() require("plugins/nvim-tmux-navigation") end
        })

        -- quick jumping
        use ({"ggandor/leap.nvim",
        config = function() require('leap').add_default_mappings() end
        })

end,
})
