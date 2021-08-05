-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzy_native')

-- Treeshitter

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main"
    },
}

local treesitter_conf = require("nvim-treesitter.configs")
treesitter_conf.setup {
	highlight = {
		enable = true,
	},
	ensure_installed = { "norg", "cpp", "c", "python"},
}

-- Auto pairs
require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt" },
})
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

-- LSP
require('lsp')

-- Neogit initialize
local neogit = require("neogit")
neogit.setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },
  integrations = {
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    -- use { 
    --   'TimUntersberger/neogit', 
    --   requires = { 
    --     'nvim-lua/plenary.nvim',
    --     'sindrets/diffview.nvim' 
    --   }
    -- }
    --
    diffview = false  
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      -- ["B"] = "BranchPopup",
      -- Removes the default mapping of "s"
      -- ["s"] = "",
    }
  }
}

-- Which key
local wk = require("which-key")
wk.register({
	-- Packer
	P = {
		name = "packer",
		i = { "<cmd>PackerInstall<cr>", "Packer Install" },
		c = { "<cmd>PackerClean<cr>", "Packer Clean" },
		u = { "<cmd>PackerUpdate<cr>", "Packer Update" },
		s = { "<cmd>PackerSync<cr>", "Packer Sync" },
	},
	-- Telescope
	f = {
		name = "file", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Find File" },   -- create a binding with label
		g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },    -- live grep
		b = { "<cmd>Telescope buffers<cr>", "Switch buffers" }, -- switch buffer
		h = { "<cmd>Telescope help_tags<cr>", "Help tags"},
		["1"] = "which_key_ignore",  -- special label to hide it in the popup
	},
	-- Buffers
	b = {
		b = { "<cmd>Telescope buffers<cr>", "Change buffer"},
		c = { "<cmd>BufferClose<cr>", "Close buffer"},
		n = { "<cmd>BufferNext<cr>", "Next buffer"},
		p = { "<cmd>BufferPrevious<cr>", "Previous buffer"},
		P = { "<cmd>BufferPin<cr>", "Pin/Unpin buffer"},
	},
	-- Tabs
	t = {
		n = { "<cmd>tabnew<cr>", "New tab" },
		c = { "<cmd>tabclose<cr>", "Close tab"},
		l = { "<cmd>tabnext<cr>", "Next tab"},
		h = { "<cmd>tabprevious<cr>", "Previous tab"},
	},
	-- Undotree
	u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
	-- Neogit
	m = { "<cmd>Neogit<cr>", "Neogit" },
}, { prefix = "<leader>" })

-- Neorg
require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        }
    },
}

require('orgmode').setup({
  org_agenda_files = {'~/Sync/org/agenda/*'},
})

-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  --exclude_ft = ['javascript'],
  --exclude_name = ['package.json'],

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'aoeusnth;qjkzvwmlrcgAOEUSNTHQJKZVWMLRCG',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDCompactSexyComs = 1
