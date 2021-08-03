-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	---- Utilities
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
	-- Hop
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}

	---- Programming
	-- LSP
	use {"neovim/nvim-lspconfig"}
	use {"hrsh7th/nvim-compe"}
	use {"glepnir/lspsaga.nvim"}

	-- Syntax
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"nvim-treesitter/playground"}
	-- Git interface
	use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }

	---- GUI
	-- Status line
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	-- The best theme of them all
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
end)

