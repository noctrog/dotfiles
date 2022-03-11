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


-- Neogit initialize
-- require("config.neogit")
require("config.gitsigns")

-- Which key
require("config.which-key")

-- Neorg
require("config.neorg")

-- Org mode
require('orgmode').setup({
  org_hide_leading_stars = true,
  org_indent_mode = 'noindent',
  org_highlight_latex_and_related = 'entities',
  org_agenda_files = {'~/Sync/org/agenda/*'},
  org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\nSCHEDULED: %t',
                target = '~/Sync/org/agenda/tasks.org'},
          u = { description = 'University', template = '* TODO %?\nDEADLINE: %t',
                target = '~/Sync/org/agenda/university.org'},
          b = { description = 'BibTex', template = '%?\n\n',
                target = '~/Sync/org/references.bib'},
  },
  org_todo_keywords = {'TODO(t)', '|', 'SKIPPED(s)', 'DONE(d)'},
})

-- Hop
require'hop'.setup { keys = 'etuhonaswjqv;zlrcpgdi' }

-- Markdown
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDCompactSexyComs = 1

-- Filetype.nvim
-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- Commenter
require('Comment').setup()

-- Neogen
require('neogen').setup()

return M
