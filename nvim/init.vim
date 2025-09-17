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

" Motions
noremap H ^
noremap L g_
noremap gh ^
noremap gl g_

" Arrow keys move window view, not cursor
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

" Allow `gf` to create file under cursor
noremap gf <cmd>e <cfile><cr>

" EDITING

""" Insert Mode Completion
set complete-=t     " No tag completion
set completeopt=menuone,noinsert,noselect,popup
set shortmess+=c    " No ins-completion-menu messages

""" Command Line Completion
set wildignorecase
set wildmenu
set wildoptions+=fuzzy

""" Indentation. See `:h editorconfig` and `../.editorconfig`
set autoindent
set smartindent

""" Spelling
" set spell
" set spelllang=en
set spelloptions=camel


" MOVING AROUND

""" Buffer Navigation
set mouse=a
set scrolloff=5
set sidescrolloff=5
set virtualedit=block
set linebreak
set nowrap
set whichwrap=<,>,[,]   " Left/Right arrows keys can move to next line

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase


" APPEARANCE

syntax enable
set shortmess+=I    " No intro message
set colorcolumn=100

""" Conceal & Whitespace
set conceallevel=1
set listchars=eol:~,extends:»,precedes:«,multispace:·,tab:├─,trail:•,nbsp:_
set listchars+=leadmultispace:▹\ \ \    " TODO: set depending on indentation level

""" Folds
set foldlevel=9
" set foldmethod=indent         " If not using tree-sitter
set fillchars=fold:\ ,eob:\ ,   " Hide fillchars
set foldtext=getline(v:foldstart).'\ …\ '.trim(getline(v:foldend))

""" Status Column (Gutter)
set number
" set foldcolumn=1
set signcolumn=number

""" Status Line
set ruler
set noshowmode
set showcmd


" FILES & BUFFERS

""" Files
set autoread
set confirm             " Ask to save stuff
set fileencoding=utf-8  " Encoding written to file
set noswapfile

""" Buffers
set hidden              " Hide buffers instead of closing them
set splitbelow
set splitright

""" Persistent Undo
set undodir="$HOME/.local/share/nvim/undo"
set undofile
set undolevels=100      " How many undos
set undoreload=1000     " Number of lines to save for undo
set updatetime=500

""" Netrw
let g:netrw_banner = 0        " No banner
let g:netrw_dirhistmax = 0    " No history
let g:netrw_liststyle = 3     " Tree-style listing


" DISABLE STANDARD PLUGINS (:help standard-plugin-list)

let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
" let g:loaded_man = 1
" let g:loaded_matchit = 1
" let g:loaded_matchparen = 1
" let g:loaded_netrwPlugin = 1
let g:loaded_remote_plugins = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
" let g:loaded_tutor_mode_plugin = 1
let g:loaded_zipPlugin = 1
let g:omni_sql_default_compl_type = 'syntax' " github.com/neovim/neovim/issues/14433

" CONFIGURE 3RD PARTY PLUGINS
"
let g:disable_rainbow_hover = 1     " rainbow_csv
let g:latex_to_unicode_tab = 0      " julia.vim


" NEOVIM SPECIFIC STUFF

if has('nvim')

colorscheme melange
set mousescroll=hor:1,ver:1

augroup FileTypeSpecificOptions
    autocmd!
    autocmd FileType lua setlocal keywordprg=:help
    autocmd FileType yaml setlocal lisp
augroup END

lua << EOF
    require('mini.diff').setup()
    require('mini.pick').setup()
    require('mini.trailspace').setup()
EOF

end
