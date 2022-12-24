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
	T = { "<cmd>Telescope<cr>", "Telescope"},
	f = {
		name = "file", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		F = { "<cmd>Telescope file_browser<cr>", "File Broswer" },
		g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },    -- live grep
		b = { "<cmd>Telescope buffers<cr>", "Switch buffers" }, -- switch buffer
		h = { "<cmd>Telescope help_tags<cr>", "Help tags"},
                t = { "<cmd>Telescope<cr>", "Telescope"},
		["1"] = "which_key_ignore",  -- special label to hide it in the popup
	},
	-- Buffers
	b = {
		b = { "<cmd>Telescope buffers<cr>", "Change buffer"},
		c = { "<cmd>bdelete<cr>", "Close buffer"},
		n = { "<cmd>bnext<cr>", "Next buffer"},
		p = { "<cmd>bprevious<cr>", "Previous buffer"},
	},
	-- Tabs
	t = {
                t = { "<cmd>Telescope<cr>", "Telescope" },
		n = { "<cmd>tabnew<cr>", "New tab" },
		c = { "<cmd>tabclose<cr>", "Close tab"},
		l = { "<cmd>tabnext<cr>", "Next tab"},
		h = { "<cmd>tabprevious<cr>", "Previous tab"},
	},
	-- Undotree
	u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
	-- Neogit
	m = { "<cmd>Neogit<cr>", "Neogit" },
	-- LSP
	l = {
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action"},
		s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help"},
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
	},
        -- Aerial
        a = {
                "<cmd>AerialToggle!<cr>", "Aerial Toggle"
        },
	-- vimrc
	v = {
		r = {
			c = { "<cmd>lua require('init').search_dotfiles()<cr>", "Search Dotfiles" }
		}
	},
	--
	n = {
		h = { "<cmd>nohl<cr>", ":nohl" },
                c = { "<cmd>Neorg gtd capture<cr>", "Neorg gtd capture"},
                v = { "<cmd>Neorg gtd views<cr>", "Neorg gtd views"},
                e = { "<cmd>Neorg gtd edit<cr>", "Neorg gtd edit"}
	},
        -- org mode
        o = {
                R = { "<cmd>lua require('init').search_org_roam()<cr>", "Search org roam" },
        },
        -- Neogen
        N = {
                f = { "<cmd>Neogen func<cr>", "Neogen func" },
                F = { "<cmd>Neogen file<cr>", "Neogen file" },
                c = { "<cmd>Neogen class<cr>", "Neogen class" },
                t = { "<cmd>Neogen type<cr>", "Neogen type" },
        },
        -- Debugging
        d = {
                b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "DAP Toggle Breakpoint" },
                B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "DAP Set BP w/ cond" },
                c = { "<cmd>lua require'dap'.continue()<CR>", "DAP Continue" },
                n = { "<cmd>lua require'dap'.step_over()<CR>", "DAP Step Over" },
                s = { "<cmd>lua require'dap'.step_into()<CR>", "DAP Step Into" },
                r = { "<cmd>lua require'dap'.repl.open()<CR>", "DAP REPL" },
                t = { "<cmd>lua require'dap'.terminate()<CR>", "DAP Terminate session"}
        },
}, { prefix = "<leader>" })

