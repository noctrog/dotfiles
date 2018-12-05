call plug#begin()
" Vim functionality
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'vimwiki/vimwiki'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" Vim GUI
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
call plug#end()

"let g:ale_completion_enabled = 1
let g:ale_enabled = 0
let g:ale_c_parse_compile_commands = 0
let g:ale_c_parse_makefile = 1

"" General
set number	
set relativenumber
set linebreak	
set showbreak=+++
set textwidth=100
set showmatch	
set visualbell
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set undofile
set undodir=~/.vim/undodir

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END 

set hlsearch
set smartcase	
set ignorecase
set incsearch	

set autoindent
set cindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=2

" Disable beep and flash
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"" Advanced
set ruler	 
set undolevels=1000
set backspace=indent,eol,start
set fillchars+=stl:\ ,stlnc:\

" Normal mode mappings
nmap <leader>w :w!<cr>
nmap <leader>t :terminal<cr>

nmap <C-j> <C-W>j
nmap <C-h> <C-W>h
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" tabs
nmap <leader>tn :tabnew<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>to :tabmove

" buffer 
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>

" MAKE
" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" If no errors, it closes any open cwindow.
:command -nargs=* Make make <args> | cwindow 3
:map <Leader>m :Make<CR>

" Omnicomplete
"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

" Goyo mappings
" Lightline
let g:lightline = {
	    \   'colorscheme': 'onedark',
	    \   'active': {
	    \     'left':[ [ 'mode', 'paste' ],
	    \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
	    \     ]
	    \   },
	    \   'component': {
	    \     'lineinfo': ' %3l:%-2v',
	    \   },
	    \   'component_function': {
	    \     'gitbranch': 'fugitive#head',
	    \   }
	    \ }
let g:lightline.separator = {
	    \   'left': '', 'right': ''
	    \}
let g:lightline.subseparator = {
	    \   'left': '', 'right': '' 
	    \}
let g:lightline.tabline = {
	    \   'left': [ ['tabs'] ],
	    \   'right': [ ['close'] ]
	    \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" Omnicomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Goyo mappings
"map <leader>z :Goyo<cr>

" NERDTree 
"autocmd VimEnter * NERDTree
noremap <leader>nn :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark
noremap <leader>nf :NERDTreeFind<cr>
noremap <leader>nc :NERDTreeCWD<cr>

" Vim-session
noremap <leader>ss :SaveSession<Space>
noremap <leader>so :OpenSession!<Space>
noremap <leader>sc :CloseSession
noremap <leader>sd :DeleteSession!<Space>

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Vimwiki
set nocompatible
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings = 0

syntax on
colorscheme onedark

" Transparent background 
"hi Normal ctermbg=NONEmap <leader>z :Goyo<cr>

" Vimtex
let g:polyglot_disabled = ['latex']
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

" YouCompleteMe
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

hi Normal ctermbg=NONE
