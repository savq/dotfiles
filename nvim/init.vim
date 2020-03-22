"NOTE:
"I use init.vim for plugins and mappings.
"For basic configuration see my vimrc.
source ~/.vimrc
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

"""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')
    """" ESSENTIALS
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    "Plug 'kyazdani42/nvim-tree.lua'
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
    Plug 'vim-airline/vim-airline' " statusline w/ wordcount, spelling locale
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'      " Git stuff

    """" THEME
    Plug 'morhetz/gruvbox'
    Plug 'joshdick/onedark.vim'
    Plug 'ayu-theme/ayu-vim'

    """" WRITING & FORMATTED TEXT
    Plug 'lervag/vimtex'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    """" CSV FILES
    Plug 'mechatroner/rainbow_csv'
    Plug 'junegunn/vim-easy-align'

    """" PROGRAMMING

    Plug 'tmhedberg/simpylfold',    { 'for' : 'python' }
    Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
call plug#end()


""" APPEARANCE
    set termguicolors "Enables true color support
    let ayucolor="dark"
    colorscheme ayu
    let g:airline_theme='ayu'
    "colorscheme onedark
    "let g:airline_theme='onedark'
    "let g:onedark_termcolors=256
    highlight Comment gui=italic
    "set guifont=IBMPlexMono "Let the terminal decide what font to use


""" MAPPINGS
    let mapleader=","
    "inoremap `` <Esc> "When there's no escape :o

""" Filetree shortcut
    noremap <silent><leader>m :NERDTreeToggle<CR>
    "noremap <silent><leader>m :LuaTreeToggle<CR>

""" Print date & time
    noremap <silent><leader>d !!date +"\%Y-\%m-\%d \%H:\%M"<cr>

""" SPELLING
    "Correct last word
    noremap <Leader>z b1z=e
    "Toggle spelling
    noremap <silent><leader>s :set spell!<CR>
    "Change spelllang
    noremap <silent><space> :call CycleLang()<CR>

fun! CycleLang() 
    "Credit to Kev at: <stackoverflow.com/questions/12006508>
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

