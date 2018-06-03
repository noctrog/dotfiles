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
 
"" Advanced
set ruler	 
set undolevels=1000
set backspace=indent,eol,start
set fillchars+=stl:\ ,stlnc:\
" Clang Complete
let g:clang_library_path='/usr/lib64/libclang.so.6'
let g:clang_complete_macros = 1
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" NERDTree load at startup
autocmd VimEnter * NERDTree

" Airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

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

syntax on
colorscheme onedark
