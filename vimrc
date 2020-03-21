"I use vimrc only for basic settings.
"For plugins and mappings see init.vim

"Place viminfo in .vim directory.
"Neovim causes problems with viminfo,
"so it's good to check what vim is being used.
if !has('nvim')
  set viminfo+=n~/.viminfo
  """ STATUSLINE
  set laststatus=2 "nvim-d
  set stl=
  set stl+=%f%m                 " Relative path[modified flag]
  set stl+=%h%w                 " Relative path[modified flag]
  set stl+=%=                   " Left/right separator
  set stl+=%y[%{&fenc}][%{&ff}] " Syntax[encoding][format]
  set stl+=\ %3.3p%%            " Percentage through file
  set stl+=\ %3l/%-3L           " Current line/# of lines
  set stl+=:\ %3c%V             " Current columns.
endif

""" GENERAL
syntax on "nvim-d
set ruler "nvim-d
set showcmd "nvim-d
set autoread "nvim-d
set wildmenu "nvim-d
set langnoremap "for colemak key mappings "nvim-d

set mouse=a
set number
set confirm "Ask to save stuff
set hidden  "Hides buffers instead of closing them
set conceallevel=2 "Hide markup


""" ENCODING
set encoding=utf-8     "Encoding displayed "nvim-d
set fileencoding=utf-8 "Encoding written to file

""" POSITION 
set cursorline
set cursorcolumn
set colorcolumn=81

""" SEARCH 
set hlsearch "nvim-d
set incsearch "nvim-d
set ignorecase
set smartcase

""" INDENTATION
set autoindent "nvim-d
set smartindent

""" FOLDS
"set foldmethod=indent
"set foldlevel=1

""" INVISIBLE CHARACTERS
set list listchars=tab:\|·,space:·,trail:•,eol:¬,extends:>,precedes:<

""" WHITESPACE
set expandtab     "tab key inserts spaces
set tabstop=2     "witdh of \t
set softtabstop=2
set shiftwidth=2  "size of indent (2 spaces)

""" SCROLLING
set nowrap
set scrolloff=40
set sidescrolloff=40

""" TRANSLATION
"set scrollbind
"set cursorbind

