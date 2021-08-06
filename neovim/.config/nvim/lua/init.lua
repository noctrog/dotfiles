-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzy_native')
-- require('telescope').load_extension('cheat')

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

require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
    move = {
	    enable = true,
	    set_jumps = true, -- whether to set jumps in the jumplist
	    goto_next_start = {
		    ["]m"] = "@function.outer",
	    },
	    goto_next_end = {
		    ["]M"] = "@function.outer",
	    },
	    goto_previous_start = {
		    ["[m"] = "@function.outer",
	    },
	    goto_previous_end = {
		    ["[M"] = "@function.outer",
	    },
    },
    swap = {
	    enable = true,
	    swap_next = {
		    -- Swap parameters (left to right)
		    ["<leader>sp"] = "@parameter.inner",
	    },
	    swap_previous = {
		    -- Swap parameters (right to left)
		    ["<leader>sP"] = "@parameter.inner",
	    },
    },
  },
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

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDCompactSexyComs = 1
