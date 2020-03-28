"General setting go here:
runtime general_settings.vim

"""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')
    """" ESSENTIALS
    "Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'vim-airline/vim-airline' "Status line with word count, spelling locale
    Plug 'vim-airline/vim-airline-themes'
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


""" PLUG-IN SETTINGS
    "CoC settings go here:
    runtime coc_config.vim

    "Wiki settings
    let g:wiki_root = '~/Documents/notes/'
    let g:wiki_filetypes = ['md', 'wiki']


""" GENERAL MAPPINGS
    "NOTE: Currently using macOS ABC keyboard
    "Good keys for harmless mappings: - _ + <space>
    let mapleader = ","

    "When there's no escape :o
    "inoremap `` <Esc>

    " File tree shortcut
    "noremap <silent><leader>m :NERDTreeToggle<CR>
    noremap <silent><leader>m :LuaTreeToggle<CR>

    " Print date & time
    noremap <silent><leader>d !!date +"\%Y-\%m-\%d \%H:\%M"<CR> 


""" SPELLING MAPPINGS
    "Correct last word
    noremap <Leader>z b1z=e
    "Change spelling language
    noremap <silent><space> :call CycleLang()<CR>

fun! CycleLang() "Credit to Kev at: <stackoverflow.com/questions/12006508>
    let langs = ['en', 'es', 'de', '']
    let i = index(langs, &spl)
    let &spelllang = langs[(i + 1) % len(langs)]
    if empty(&spl)
        set nospell
    else
        set spell
    endif
endfun

