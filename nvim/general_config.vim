set mouse=a
set number
set relativenumber
set wildignorecase
set confirm            "Ask to save stuff
set hidden             "Hides buffers instead of closing them
set conceallevel=2     "Hide markup
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

""" INDENTATION & WHITESPACE
set smartindent   "autoindent is nvim default
set expandtab     "<Tab> inserts spaces
set shiftwidth=2
set softtabstop=2

""" FOLDS
set foldmethod=indent
set foldlevel=2

""" SCROLLING
set nowrap
set scrolloff=20
set sidescrolloff=20

""" TRANSLATION
"set scrollbind "Keeps buffers vertically aligned
"set cursorbind

""" STATUS LINE
"set stl=
"set stl+=%f%m                 " Relative path[modified flag]
"set stl+=%h%w                 " Relative path[modified flag]
"set stl+=%=                   " Left/right separator
"set stl+=%y%{&fenc}\|%{&ff}\| " Syntax[encoding][format]
"set stl+=\ %3.3p%%            " Percentage through file
"set stl+=\ %3l/%-3L           " Current line/# of lines
"set stl+=:\ %3c%V             " Current columns.

