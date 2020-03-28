"General setting go here:
runtime general_settings.vim

"""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')
"""" ESSENTIALS
Plug 'vim-airline/vim-airline' "Status line with word count, spelling locale
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-tree.lua'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive' "Git stuff

"""" PROGRAMMING
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tmhedberg/simpylfold',    {'for' : 'python'}
Plug 'pangloss/vim-javascript', {'for' : 'javascript'}

"""" WRITING PROSE & FORMATTED TEXT
Plug 'junegunn/goyo.vim', {'on': 'Goyo'} "Reduce clutter when writing prose
Plug 'lervag/vimtex'
Plug 'lervag/wiki.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

"""" CSV FILES
Plug 'mechatroner/rainbow_csv'
Plug 'junegunn/vim-easy-align'

"""" COLORSCHEME
Plug 'ayu-theme/ayu-vim'

call plug#end()


""" APPEARANCE (Let the TUI decide the font)
set termguicolors "Enables true color support
colorscheme ayu
let ayucolor="dark"
let g:airline_theme='ayu'
highlight Comment gui=italic


""" COC SETTINGS GO HERE
runtime coc_config.vim


""" WIKI SETTINGS
let g:wiki_root = '~/Documents/notes/'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = 'md'
let g:wiki_link_target_map = 'CreateLinkNames'

function CreateLinkNames(text) abort
  "Adds timestamp ID, turns text to lowercase and removes spaces
  return strftime("%Y%m%d%H%M_") . substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction


""" GENERAL MAPPINGS
" NOTE: Currently using macOS ABC keyboard
let mapleader = ","

" When there's no escape :o
"inoremap `` <Esc>

" File tree shortcut
"noremap <silent><leader>m :NERDTreeToggle<CR>
noremap <silent><leader>m :LuaTreeToggle<CR>

" Print date & time
noremap <silent><leader>d "=strftime("%Y-%m-%d %T")<CR>p


""" SPELLING MAPPINGS
" Correct last word
noremap <Leader>z b1z=e
" Change spelling language
noremap <silent><space> :call CycleLang()<CR>

function CycleLang() "Credit to Kev at: <stackoverflow.com/questions/12006508>
    let langs = ['en', 'es', 'de', '']
    let i = index(langs, &spl)
    let &spelllang = langs[(i + 1) % len(langs)]
    if empty(&spl)
        set nospell
    else
        set spell
    endif
endfun

