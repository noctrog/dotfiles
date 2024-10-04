-- Telescope
require('config.telescope')

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.dotfiles/neovim/.config/nvim",
	})
end

M.search_org_roam = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Org roam >",
		cwd = "~/Sync/org/roam",
	})
end

-- Treeshitter
require('config.treesitter')

-- LSP
require('config.lsp')

-- Completion
require('config.completion')

-- Auto pairs
require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt", "vim" },
})
-- Remove trailing whitespaces
require("retrail").setup()


-- Neogit initialize
-- require("config.neogit")
require("config.gitsigns")

-- Which key
require("config.which-key")

-- Obsidian
require('config.obsidian')

-- Neorg
require("config.neorg")

-- Markdown
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDCompactSexyComs = 1

-- Commenter
require('Comment').setup()

-- Neogen
require('neogen').setup()

-- Debugger
require("config.nvim-dap")

-- hbac
require("hbac").setup({
  autoclose     = true, -- set autoclose to false if you want to close manually
  threshold     = 10, -- hbac will start closing unedited buffers once that number is reached
  close_command = function(bufnr)
    vim.api.nvim_buf_delete(bufnr, {})
  end,
  close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
  telescope = {
    -- See #telescope-configuration below
    },
})

return M
