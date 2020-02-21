"NOTE:
"I use init.vim for plugins and mappings.
"For basic configuration see my vimrc.

source ~/.vimrc

""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')
    """" ESSENTIALS
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'vim-airline/vim-airline' " statusline w/ wordcount, spelling locale
    Plug 'tpope/vim-fugitive'      " Git stuff
    
    """" THEME
    Plug 'morhetz/gruvbox'
    "Plug 'joshdick/onedark.vim'
    
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


"OPTIONS
set nowrap

"APPEARANCE
set termguicolors
colorscheme gruvbox "nvim background defaults to dark
highlight Comment gui=italic
let g:lightline = {'colorscheme': 'gruvbox'}
"set guifont=IBMPlexMono "Let the terminal decide what font to use


"MAPPINGS
let mapleader=","
"inoremap `` <Esc> "When there's no escape :o
"NOTE:Colemak nav keys: j = up; l = right; h = left; k = down.
set langmap=jk,kj "
noremap <C-j> <C-W>k
noremap <C-k> <C-W>j
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Nerdtree shortcut
noremap <silent> <leader>m :NERDTreeToggle<CR>

"SPELLING
"Correct last word
noremap <Leader>z b1z=e
"Toggle spelling (Credit to Kev at: stackoverflow.com/questions/12006508)
noremap <silent> <leader>s :call CycleLang()<CR>
fun! CycleLang() 
    let langs = ['', 'en', 'es', 'de']
    let i = index(langs, &spl)
    let &spelllang = langs[(i + 1) % len(langs)]
    if empty(&spl)
        set nospell
    else
        set spell
    endif
endfun

