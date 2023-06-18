let mapleader = ' '
let maplocalleader = ','
noremap ; :

" Copy to system clipboard
noremap Y "+y

" Help
noremap <C-]> K
cabbrev vh vert help

" Edit configuration
noremap <leader>rc <cmd>edit $MYVIMRC<cr>

" Sessions
noremap <leader>ss <cmd>mksession! .session.vim<cr>
noremap <leader>sr <cmd>source     .session.vim<cr>

" Cursor navigation
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

noremap <up> <C-y>
noremap <down> <C-e>

" Buffer and window switching
noremap <s-left>  <cmd>bprev<cr>
noremap <s-right> <cmd>bnext<cr>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Repeat search
noremap <a-,> ,
noremap <a-.> ;
noremap ≤ ,
noremap ≥ ;
noremap N Nzz
noremap n nzz


""" UI
set foldcolumn=1
set noshowmode
set number
set ruler
set showcmd

set colorcolumn=100
" set cursorcolumn cursorline

set shortmess+=I        " no intro message

""" Movement
set mouse=a
set nowrap
set scrolloff=5
set sidescrolloff=5
set virtualedit=block
set whichwrap=<,>,[,] " Left/Right arrows keys can move to next line

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

""" Completion
set complete-=t     " No tag completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c    " no ins-completion-menu messages
set wildignorecase
set wildmenu

""" Conceal
set conceallevel=1
" set concealcursor=n  " conceal in normal mode

""" Folds
set foldlevel=2
set fillchars=fold:\ ,eob:\ ,   " Hide fillchars
set foldtext=getline(v:foldstart).'\ …\ '.trim(getline(v:foldend))

""" Whitespace
set list
set listchars=eol:~,extends:»,precedes:«,leadmultispace:·\ \ \ ,multispace:·,tab:├─,trail:•,nbsp:_

""" Indentation
set autoindent
set smartindent
set expandtab       " <tab> inserts spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
augroup IndentExceptions
    au!
    au FileType c,javascript,scheme,zsh,gitcommit,markdown,query,wiki
                \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
                \ | setlocal listchars+=leadmultispace:·\ ,
augroup END

""" Files, buffers, windows
set autoread
set confirm             " ask to save stuff
set fileencoding=utf-8  " encoding written to file
set hidden              " hide buffers instead of closing them
set noswapfile
set spelllang=
set spelloptions=camel
set splitbelow
set splitright

""" Persistent undo
set undodir="$HOME/.local/share/nvim/undo"
set undofile
set undolevels=100      " How many undos
set undoreload=1000     " number of lines to save for undo
set updatetime=500

""" Netrw
let g:netrw_banner = 0        " no banner
let g:netrw_dirhistmax = 0    " no history
let g:netrw_liststyle = 3     " tree style listing

""" Disable plugins (:help standard-plugin-list)
let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
" let g:loaded_man = 1
" let g:loaded_matchit = 1
" let g:loaded_matchparen = 1
" let g:loaded_netrwPlugin = 1
let g:loaded_remote_plugins = 1
let g:loaded_spellfile_plugin = 1
" let g:loaded_tarPlugin = 1
" let g:loaded_tutor_mode_plugin = 1
" let g:loaded_zipPlugin = 1


if has('nvim')
    autocmd FileType Lua setlocal keywordprg=:help
    lua require 'savq'
else
    color lunaperche      " if not melange
    syntax enable

    set foldmethod=indent " if not tree-sitter
    set signcolumn=number " if not gitsigns
endif

" Inform vim how to enable undercurl in wezterm
let &t_Cs = "\e[60m"
" Inform vim how to disable undercurl in wezterm (this disables all underline modes)
let &t_Ce = "\e[24m"

