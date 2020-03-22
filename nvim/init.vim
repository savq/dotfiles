"""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')
    """" ESSENTIALS
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'vim-airline/vim-airline' "Status line with word count, spelling locale
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive' "Git stuff

    """" PROGRAMMING
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tmhedberg/simpylfold',    { 'for' : 'python' }
    Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

    """" WRITING PROSE & FORMATTED TEXT
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'} "
    Plug 'lervag/vimtex'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    """" CSV FILES
    Plug 'mechatroner/rainbow_csv'
    Plug 'junegunn/vim-easy-align'

    """" COLORSCHEME
    Plug 'ayu-theme/ayu-vim'

call plug#end()

""" GENERAL SETTINGS
set mouse=a
set number
set confirm            "Ask to save stuff
set hidden             "Hides buffers instead of closing them
set conceallevel=2     "Hide markup
set smartindent        "autoindent is nvim default
set fileencoding=utf-8 "Encoding written to file

""" POSITION
set cursorline
set cursorcolumn
set colorcolumn=81

""" SEARCH
set ignorecase
set smartcase

""" FOLDS
"set foldmethod=indent
"set foldlevel=1

""" INVISIBLE CHARACTERS
set list listchars=tab:\|·,space:·,trail:•,eol:¬,extends:>,precedes:<

""" WHITESPACE
set expandtab     "tab key inserts spaces
set tabstop=4     "witdh of \t
set softtabstop=4
set shiftwidth=4  "size of indent (2 spaces)

""" SCROLLING
set nowrap
set scrolloff=40
set sidescrolloff=40

""" TRANSLATION
"set scrollbind "Keeps buffers vertically aligned
"set cursorbind

""" APPEARANCE (Let the TUI decide the font)
set termguicolors "Enables true color support
let ayucolor="dark"
colorscheme ayu
let g:airline_theme='ayu'
highlight Comment gui=italic

""" MAPPINGS
let mapleader=","
"inoremap `` <Esc> "When there's no escape :o

""" File tree shortcut
    noremap <silent><leader>m :NERDTreeToggle<CR>

""" Print date & time
    noremap <silent><leader>d !!date +"\%Y-\%m-\%d \%H:\%M"<cr>

""" SPELLING
    "Correct last word
    noremap <Leader>z b1z=e
    "Toggle spelling
    noremap <silent><leader>s :set spell!<CR>
    "Change spelllang
    noremap <silent><space> :call CycleLang()<CR>

fun! CycleLang() "Credit to Kev at: <stackoverflow.com/questions/12006508>
    let langs = ['', 'en', 'es', 'de']
    let i = index(langs, &spl)
    let &spelllang = langs[(i + 1) % len(langs)]
    if empty(&spl)
        set nospell
    else
        set spell
    endif
endfun

""" COLEMAK (Navegation keys: j = up; l = right; h = left; k = down)
    "set langmap=jk,kj "
    "noremap <C-j> <C-W>k
    "noremap <C-k> <C-W>j
    "noremap <C-h> <C-W>h
    "noremap <C-l> <C-W>l

""" STATUSLINE
"set laststatus=2 "nvim-d
"set stl=
"set stl+=%f%m                 " Relative path[modified flag]
"set stl+=%h%w                 " Relative path[modified flag]
"set stl+=%=                   " Left/right separator
"set stl+=%y[%{&fenc}][%{&ff}] " Syntax[encoding][format]
"set stl+=\ %3.3p%%            " Percentage through file
"set stl+=\ %3l/%-3L           " Current line/# of lines
"set stl+=:\ %3c%V             " Current columns.

