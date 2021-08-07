-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	---- Utilities
	-- tpope magic
	use {'tpope/vim-surround'}
	-- Nerd commenter
	use {'preservim/nerdcommenter'}
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use {"nvim-telescope/telescope-fzy-native.nvim"}
	-- use {"nvim-telescope/telescope-cheat.nvim", requires = "tami5/sql.nvim"} -- use in the future
	-- Autopairs
	use {"windwp/nvim-autopairs"}
	-- Snippets
	use {"L3MON4D3/LuaSnip"}
	-- Hop
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
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

	---- Programming
	-- LSP
	use {"neovim/nvim-lspconfig"}
	use {"hrsh7th/nvim-compe"}
	use {"glepnir/lspsaga.nvim"}

	-- Syntax
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter"}
	use {"nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter"}
	-- Git interface
	use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }

	---- GUI
	-- Status line
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	-- Bar prettifier
	-- use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
	-- The best theme of them all
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

	---- Documents
	-- Org mode
	use {'kristijanhusak/orgmode.nvim'}
	-- Neorg
	use {"vhyrro/neorg", requires = "nvim-lua/plenary.nvim"}
	-- Latex
	use {"lervag/vimtex"}
end)

