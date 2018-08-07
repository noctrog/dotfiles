call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'Rip-Rip/clang_complete'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'junegunn/goyo.vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'

call plug#end()


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

map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-k> <C-W>k
map <C-l> <C-W>l

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>to :tabmove

map <leader>bn :bnext<CR>
map <leader>bp :bprevious<CR>

" Omnicomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Goyo mappings
map <leader>z :Goyo<cr>

" Clang Complete
let g:clang_library_path='/usr/lib64/libclang.so.6'
let g:clang_complete_macros = 1
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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

" Airline
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Vimtex
let g:polyglot_disabled = ['latex']
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Vimwiki
set nocompatible
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

syntax on
colorscheme onedark

" Transparent background 
hi Normal ctermbg=NONE
