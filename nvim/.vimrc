""" MAPPINGS

let mapleader = ' '
let maplocalleader = ','
nnoremap ; :

" Repeat search (typed with `alt <` and `alt >`)
noremap ≤ ,
noremap ≥ ;

" Help
noremap <C-]> K

" Copy to system clipboard
noremap Y "+y

" Navigation
noremap J 5j
noremap K 5k
noremap H ^
noremap L $

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

""" OPTIONS
set mouse=a
set noshowmode      " not needed when modes are displayed on the statusline
set spelllang=
set conceallevel=1  " conceal but leave spaces
set wildignorecase

set completeopt=menuone,noinsert,noselect
set shortmess+=c    " No ins-completion-menu messages
set shortmess+=I    " No intro message

set updatetime=1000 " for CursorHold
set noswapfile      " living a dangerous life

set number
set signcolumn=number

""" Position
set cursorcolumn
set cursorline
set colorcolumn=81

""" Buffer management
set confirm               " ask to save stuff
set hidden                " hides buffers instead of closing them
set fileencoding=utf-8    " encoding written to file

""" Split windows
set splitbelow
set splitright

""" Search
set ignorecase
set smartcase

""" Whitespace
set list
set listchars=tab:\|-,trail:*,extends:>,precedes:<,nbsp:_,eol:~
set listchars+=space:· "not ASCII

""" Indentation
set expandtab     "<tab> inserts spaces
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
augroup Indents "some exceptions
    au!
    au FileType c,scheme setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

""" Folds
set foldlevel=3
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

""" Scrolling
set nowrap
set scrolloff=5
set sidescrolloff=5

""" Persistent undo
set undofile
set undolevels=100     " How many undos
set undoreload=1000    " number of lines to save for undo


""" Vim 8
if !has('nvim')
    syntax enable
    set ruler
    set showcmd
    set autoread
    set wildmenu
    set hlsearch
    set incsearch
    set autoindent
    set foldmethod=indent
endif

""" Netrw
let g:netrw_banner = 0        " no banner
let g:netrw_liststyle = 3     " tree style listing
let g:netrw_dirhistmax = 0    " no netrw history
