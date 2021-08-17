local cmd = vim.cmd
local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo

--------------------------------------------------------------------------
-- General settings
--------------------------------------------------------------------------
g.mapleader = ' '    -- change the leader key
o.mouse = 'a'        -- enable mouse support
bo.swapfile = false  -- don't use swapfile
o.encoding = "utf-8" -- Set default encoding to UTF-8
o.ignorecase = true
o.wrap = false       -- disable line breaking
o.sidescroll = 1     -- horizontal scrolling
o.sidescrolloff = 4  -- horizontal scrolling offset
o.inccommand = 'nosplit' -- show live changes in search and replace

--------------------------------------------------------------------------
-- Neovim UI
--------------------------------------------------------------------------
o.syntax = 'enable' -- enable syntax highlighting
wo.number = true    -- show line number
wo.relativenumber = true -- relative line numbering
o.showmatch = true  -- highlight matching parethesis
wo.foldmethod = 'marker' -- enable folding
wo.colorcolumn = '80' -- show line length marker at 80 columns
o.splitright = true
o.splitbelow = true
o.smartcase = true  -- ignore lowercase for the whole pattern
o.cursorline = true
o.scrolloff = 8
vim.api.nvim_exec([[
  set undodir=~/.vim/undodir
  set undofile]], true)

--augroup numbertoggle
--    autocmd!
--    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
--    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
--augroup END 

--------------------------------------------------------------------------
-- Memory, CPU
--------------------------------------------------------------------------
-- o.hidden = true     -- enable background buffers
o.history = 300     -- remember n lines in history
o.lazyredraw = true -- faster scrolling

--------------------------------------------------------------------------
-- Tabs, indentation
--------------------------------------------------------------------------
bo.tabstop = 4      -- 1 tab == 4 spaces
bo.smartindent = true -- autoindent new lines

-- remove line lenght marker for selected filetypes
cmd([[
	autocmd Filetype text,markdown,xml,html,xhtml setlocal cc=0
]])

-- 2 spaces for selected filetypes
cmd([[
	autocmd Filetype xml,html,xhtml,css,scss,yaml setlocal shiftwidth=2 tabstop=2
]])

--------------------------------------------------------------------------
-- Filetype specific configs
--------------------------------------------------------------------------
-- Markdown
cmd([[autocmd Filetype markdown setlocal tw=80]])

