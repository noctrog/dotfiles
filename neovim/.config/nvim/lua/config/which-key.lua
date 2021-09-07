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
	-- LSP
	l = {
		f = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>", "Find def and ref" },
		a = { "<cmd>lua require('lspsaga.codeaction').code_action()<cr>", "Code action"},
		s = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>", "Signature help"},
		r = { "<cmd>lua require('lspsaga.rename').rename()<cr>", "Rename"},
		d = { "<cmd>lua require'lspsaga.provider'.preview_definition()<cr>", "Preview definition"},
	},
	-- Hop
	[";"] = {
		"<cmd>:HopChar2<cr>", "Hop"
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
	}
}, { prefix = "<leader>" })

