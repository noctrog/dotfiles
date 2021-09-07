require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
	["core.keybinds"] = { -- Configure core.keybinds
		config = {
			default_keybinds = true, -- Generate the default keybinds
			neorg_leader = "<Leader>n" -- This is the default if unspecified
		}
	},
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/Sync/neorg"
                }
            }
        },
	["core.integrations.telescope"] = {}, -- Enable the telescope module
    },
}
