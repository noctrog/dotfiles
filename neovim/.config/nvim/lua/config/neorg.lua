require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
                -- Load all the default modules
                ["core.defaults"] = {},
                -- Configure the keybinds
                ["core.keybinds"] = {
                        config = {
                                default_keybinds = true, -- Generate the default keybinds
                                neorg_leader = "<Leader>n" -- This is the default if unspecified
                        }
                },
                ["core.norg.concealer"] = {}, -- Allows for use of icons
                -- Manage Neorg directories
                ["core.norg.dirman"] = {
                        config = {
                                workspaces = {
                                        my_workspace = "~/Sync/neorg",
                                }
                        }
                },
                -- Enable GTD
                ["core.gtd.base"] = {
                        config = {
                                workspace = "my_workspace",
                        }
                },
                -- Enable the Telescope module
                ["core.integrations.telescope"] = {},
                -- Enable the completion module
                ["core.norg.completion"] = {
                        config = {
                                engine = "nvim-cmp"
                        }
                },
                ["core.norg.esupports.metagen"] = {
                        config = {
                                type = "auto",
                        }
                },
        },
}
