-- Telescope
require('config.telescope')

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.dotfiles/neovim/.config/nvim",
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
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})

-- Neogit initialize
-- require("config.neogit")
require("config.gitsigns")

-- Which key
require("config.which-key")

-- Neorg
require("config.neorg")

-- Org mode
require('orgmode').setup({
  org_agenda_files = {'~/Sync/org/agenda/*'},
  org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\nSCHEDULED: %t',
                target = '~/Sync/org/agenda/tasks.org'},
          u = { description = 'University', template = '* TODO %?\nDEADLINE: %t',
                target = '~/Sync/org/agenda/university.org'},
          b = { description = 'BibTex', template = '%?\n\n',
                target = '~/Sync/org/references.bib'},
  }
})

-- Markdown
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDCompactSexyComs = 1

return M
