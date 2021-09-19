-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	------------------------------------------------------------------------
	----------------------------- Utilities --------------------------------
	------------------------------------------------------------------------
	
	-- tpope magic
	use {'tpope/vim-surround'}
	-- Nerd commenter
	use {'preservim/nerdcommenter'}
	-- Sneak
	use {'justinmk/vim-sneak'}
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use {"nvim-telescope/telescope-fzy-native.nvim"}
	-- Autopairs
	use {"windwp/nvim-autopairs"}
	-- Snippets
	use {"L3MON4D3/LuaSnip"}
	use {"rafamadriz/friendly-snippets"}
	-- Hop
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etuhonaswjqv;zlrcpgdi' }
		end
	}
	-- Which key
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {}
		end
	}
	-- Undotree
	use {"mbbill/undotree"}
	-- Cheatshit
	use {"dbeniamine/cheat.sh-vim"}
        -- Completion
	use {"hrsh7th/nvim-cmp", 
                requires = {"hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip",
                            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path"}}

	------------------------------------------------------------------------
	----------------------------- Programming ------------------------------
	------------------------------------------------------------------------
	-- LSP
	use {"neovim/nvim-lspconfig"}
	use {"glepnir/lspsaga.nvim"}

	-- Syntax
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter"}
	use {"nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter"}
	-- Git interface
	use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }

	------------------------------------------------------------------------
	--------------------------------- GUI ----------------------------------
	------------------------------------------------------------------------
	-- Status line
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	-- Bar prettifier
	-- use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
	-- The best theme of them all
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

	------------------------------------------------------------------------
	------------------------------- Documents ------------------------------
	------------------------------------------------------------------------
	-- Org mode
	use {'kristijanhusak/orgmode.nvim'}
	-- Neorg
	use {"vhyrro/neorg", requires = {{"nvim-lua/plenary.nvim"}, {"vhyrro/neorg-telescope"} }}
	-- Latex
	use {"lervag/vimtex"}
end)

