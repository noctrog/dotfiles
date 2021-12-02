local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

parser_configs.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}


local treesitter_conf = require("nvim-treesitter.configs")
treesitter_conf.setup {
	highlight = {
		enable = true,
                disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
                additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
	},
	ensure_installed = { "cpp", "c", "python", "latex", "rust",
			     "query", "vim", "json", "julia", "org" },
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

