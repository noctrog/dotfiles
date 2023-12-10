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
require('orgmode').setup_ts_grammar()

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
    mappings = {
      n = {
        close_unpinned = "<M-c>",
        delete_buffer = "<M-x>",
        pin_all = "<M-a>",
        unpin_all = "<M-u>",
        toggle_selections = "<M-y>",
      },
      i = {
        -- as above
      },
    },
    -- Pinned/unpinned icons and their hl groups. Defaults to nerdfont icons
    pin_icons = {
      pinned = { "󰐃 ", hl = "DiagnosticOk" },
      unpinned = { "󰤱 ", hl = "DiagnosticError" },
    },
  },
})

return M
