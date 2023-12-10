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

	-- tpope magic
	use {'tpope/vim-surround'}
  use {'tpope/vim-unimpaired'}
  use {'tpope/vim-repeat'}
	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	use {"nvim-telescope/telescope-fzy-native.nvim"}
	-- Autopairs
	use {"windwp/nvim-autopairs"}
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
	use {"hrsh7th/nvim-cmp",
       requires = {'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-nvim-lsp',
       'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip',
       'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets'}
  }
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

	------------------------------------------------------------------------
	----------------------------- Programming ------------------------------
	------------------------------------------------------------------------
	-- LSP
	use {'neovim/nvim-lspconfig',
       requires = {
         -- Automatically install LSPs to stdpath for neovim
         'williamboman/mason.nvim',
         'williamboman/mason-lspconfig.nvim',

         'SmiteshP/nvim-navic',  -- code context in status bar
         'folke/neodev.nvim',    -- nvim lua autocompletion
         'j-hui/fidget.nvim',    -- lsp status
      }
  }

	-- Syntax
	use {'nvim-treesitter/nvim-treesitter',
       run = function()
              pcall(require('nvim-treesitter.install').update { with_sync = true })
       end,
  }
	use {'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-textobjects',
       after = 'nvim-treesitter',
  }
  -- Debugger
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { 'mfussenegger/nvim-dap-python', requires = {"mfussenegger/nvim-dap"} }
	-- Git interface
	use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
  use {"lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim"}
  -- Languages
  use {'numtostr/comment.nvim'}
  use {'stevearc/aerial.nvim'}
  use {'sbdchd/neoformat'}
  use {
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    tag = "*"
  }
	------------------------------------------------------------------------
	--------------------------------- GUI ----------------------------------
	------------------------------------------------------------------------
	-- Status line
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
	-- The best theme of them all
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use {'lukas-reineke/indent-blankline.nvim'}

	------------------------------------------------------------------------
	------------------------------- Documents ------------------------------
	------------------------------------------------------------------------
        -- GPG Encription
  use {"jamessan/vim-gnupg"}
  -- Obsidian
  use {'epwalsh/obsidian.nvim'}
	-- Org mode
	use {'kristijanhusak/orgmode.nvim'}
	-- Neorg
	-- use {"nvim-neorg/neorg", requires = {{"nvim-lua/plenary.nvim"},
  --                {"nvim-neorg/neorg-telescope"} }}
	-- Latex
	use {"lervag/vimtex"}
  -- Ledger
  use {"ledger/vim-ledger"}
  -- Table mode
  use {"dhruvasagar/vim-table-mode"}
  -- Remove trailing whitespaces
  use {"zakharykaplan/nvim-retrail"}
  -- Markdown
  use({ "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end, })
end)

