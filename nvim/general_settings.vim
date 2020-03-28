""" GENERAL SETTINGS
set mouse=a
set number
set relativenumber
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

""" FOLDS
"set foldmethod=indent
"set foldlevel=1

""" TRANSLATION
"set scrollbind "Keeps buffers vertically aligned
"set cursorbind


""" COLEMAK (Navegation keys: j = up; l = right; h = left; k = down)
    "set langmap=jk,kj
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

