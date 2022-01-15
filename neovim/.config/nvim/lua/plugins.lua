-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	------------------------------------------------------------------------
	----------------------------- Utilities --------------------------------
	------------------------------------------------------------------------
	
        use {'nathom/filetype.nvim'}
	-- tpope magic
	use {'tpope/vim-surround'}
        use {'tpope/vim-unimpaired'}
        use {'tpope/vim-repeat'}
        use {'tpope/vim-obsession'} -- allows to resurrect nvim with tmux
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
        -- Completion
	use {"hrsh7th/nvim-cmp"}
        use {"hrsh7th/cmp-nvim-lua", requires = {"hrsh7th/nvim-cmp"}}
        use {"hrsh7th/cmp-nvim-lsp", requires = {"hrsh7th/nvim-cmp"}}
        use {"hrsh7th/cmp-buffer", requires = {"hrsh7th/nvim-cmp"}}
        use {"hrsh7th/cmp-path", requires = {"hrsh7th/nvim-cmp"}}
        use {"saadparwaiz1/cmp_luasnip", requires = {"hrsh7th/nvim-cmp"}}

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
        use {"lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim"}
        -- Languages
        use {'numtostr/comment.nvim'}
        use {'stevearc/aerial.nvim'}
        use({
                "JuliaEditorSupport/julia-vim",
                ft = { "julia" },
                fn = { "LaTeXToUnicode#Refresh" },
                config = function()
                        vim.g.latex_to_unicode_tab = "off"
                        vim.g.latex_to_unicode_auto = 0
                end,
        })
	------------------------------------------------------------------------
	--------------------------------- GUI ----------------------------------
	------------------------------------------------------------------------
	-- Status line
        use {
                'hoob3rt/lualine.nvim',
                requires = {'kyazdani42/nvim-web-devicons', opt = true}
        }
	-- use {
		-- 'famiu/feline.nvim',
		-- requires = {'kyazdani42/nvim-web-devicons', opt = true}
	-- }
	-- Bar prettifier
	-- use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
	-- The best theme of them all
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

	------------------------------------------------------------------------
	------------------------------- Documents ------------------------------
	------------------------------------------------------------------------
        -- GPG Encription
        use {"jamessan/vim-gnupg"}
	-- Org mode
	use {'kristijanhusak/orgmode.nvim'}
	-- Neorg
	use {"nvim-neorg/neorg", requires = {{"nvim-lua/plenary.nvim"}, 
                {"nvim-neorg/neorg-telescope"} }}
	-- Latex
	use {"lervag/vimtex"}
        -- Ledger
        use {"ledger/vim-ledger"}
        -- Table mode
        use {"dhruvasagar/vim-table-mode"}
end)

