-- Gruvbox colorscheme
vim.o.termguicolors = true -- enable 24-bit RGB colors
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Status line
require('config.statusline')

require('ibl').setup{ }
