" NOTE:
"I use init.vim for plugins and mappings.
"For basic configuration see my vimrc.
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"""" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')

"""" ESSENTIALS
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'kyazdani42/nvim-tree.lua'
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
let ayucolor="dark"
colorscheme ayu
hi Comment gui=italic
hi Normal guibg=NONE ctermbg=NONE

""" COC SETTINGS GO HERE
runtime coc_config.vim

""" LIGHTLINE
let g:lightline = {
    \ 'colorscheme': 'ayu_mirage',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \             [ 'cocstatus', 'cocCurrentFun'] ],
    \  'right': [ [ 'percent', 'lineinfo'],
    \            [ 'spell', 'filetype', 'fileencoding', 'fileformat' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'cocstatus': 'coc#status',
    \   'cocCurFun': 'CocCurrentFunction'
    \ },
    \ }

""" WIKI.VIM
let g:wiki_root = '~/Documents/notes/'
let g:wiki_filetypes = ['md']
let g:wiki_link_target_type = 'md'
let g:wiki_link_target_map = 'CreateLinkNames'

function CreateLinkNames(text) abort
  "return substitute(tolower(a:text), '\s\+', '_', 'g')
  return strftime("%Y%m%d%H%M_") . substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction

""" PANDOC
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#conceal#urls = 1
au BufNewFile,BufRead *.md set nowrap " Vim-Pandoc can't fucking disable wrapping
"au BufNewFile,BufRead *.md call pandoc#formatting#DisableAutoformat()

""" GENERAL MAPPINGS
" NOTE: Currently using macOS ABC keyboard
let mapleader = ","

" When there's no escape :o
"inoremap `` <Esc>

" File tree shortcut
noremap <silent><leader>m :NERDTreeToggle<CR>
"noremap <silent><leader>m :LuaTreeToggle<CR>

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

