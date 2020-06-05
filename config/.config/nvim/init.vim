call plug#begin()

" Vim functionality
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'ekiim/vim-mathpix'
Plug 'sheerun/vim-polyglot'

" Vim GUI
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
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
set cursorline
set mouse=a  " scroll with mouse
set scrolloff=3
"set wildoptions=pum
"set pumblend=20
set termguicolors
" swap
set directory=$HOME/.vim/swap//

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END 

set hlsearch
set smartcase	
set ignorecase
set incsearch	

" ident options
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set cindent
"set smartindent
filetype plugin indent on " smart autoindentaton
"set nowrap
set smarttab
set softtabstop=4

" search options
set incsearch
set hlsearch
set ignorecase
set smartcase

" Disable beep and flash
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"" Advanced
set ruler	 
set undolevels=1000
set backspace=indent,eol,start
set fillchars+=stl:\ ,stlnc:\

" spell
setlocal spell
set spelllang=es,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" netwr
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1

let mapleader = "\<Space>"

" Normal mode mappings
"nmap <leader>w :w!<cr>
nmap <leader>t :terminal<cr>

" Windows
nmap <leader>wj <C-W>j
nmap <leader>wh <C-W>h
nmap <leader>wk <C-W>k
nmap <leader>wl <C-W>l
nmap <leader>wq <C-W>q
nmap <leader>ws <C-w>s
nmap <leader>wn <C-w>n
nmap <leader>wv <C-w>v
nmap <leader>wx <C-w>x
nmap <leader>wr <C-w>r

" tabs
nmap <leader>tn :tabnew<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>to :tabonly<CR>
nmap <leader>to :tabmove
nmap <leader>tl :tabnext<CR>
nmap <leader>th :tabprevious<CR>

" buffer 
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bd :bdelete<CR>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Placeholder
inoremap <c-j> <Esc>/<++><CR><Esc>cf>

" FZF
nnoremap <leader>. :Files<CR>
nnoremap <leader>ht :Colors<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fT :Tags<CR>
nnoremap <leader>ft :BTags<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fs :Snippets<CR>
nnoremap <leader>fc :Commits<CR>

" Lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
	    \   'colorscheme': 'gruvbox',
	    \   'active': {
	    \     'left':[ [ 'mode', 'paste' ],
	    \              [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ]
	    \     ]
	    \   },
	    \   'component': {
	    \     'lineinfo': ' %3l:%-2v',
	    \   },
	    \  'component_function': {
	    \   'cocstatus': 'coc#status',
	    \   'currentfunction': 'CocCurrentFunction'
	    \ },
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
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']
let g:UltiSnipsSnippetDirectories=['UltiSnips']

" Vimtex
let g:polyglot_disabled = ['latex']
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \}
" Disable all warnings
let g:vimtex_quickfix_latexlog = {'default' : 0}
set conceallevel=1
let g:tex_conceal='abdmg'
autocmd Filetype tex,latex inoremap <C-s> <Esc>:silent exec ".!scrot -s -e 'latexscrot $f && mv $f ./figures/'" <CR><CR>:w<CR>
autocmd Filetype tex,latex inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
autocmd Filetype tex,latex nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

let g:gruvbox_italic=1
"colorscheme gruvbox
colorscheme gruvbox
set background=dark

hi Normal ctermbg=NONE

"" coc.vim stuff
set hidden
"set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
