" NOTE: Plugins and mappings are in init.vim. Options are in vimrc
source $HOME/.config/nvim/vimrc

"""" PLUGINS
call plug#begin(stdpath('data') . '/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
"""" PROGRAMMING
Plug 'neoclide/coc.nvim', {'branch': 'release'} "rls, ccls, etc
Plug 'JuliaEditorSupport/julia-vim'
"""" PROSE & FORMATTED TEXT
Plug 'lervag/vimtex'
Plug 'lervag/wiki.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"""" OTHER STUFF
Plug 'mechatroner/rainbow_csv'     "Highlight csv columns
Plug 'norcalli/nvim-colorizer.lua' "Highlight hex and rgb colors
Plug 'junegunn/vim-easy-align'
call plug#end()

runtime coc.vim "CoC settings go here
lua require('config')

""" LIGHTLINE
let g:lightline = {
  \ 'colorscheme': 'ayu_mirage',
  \ 'active': {
  \   'left': [ ['mode', 'paste'],
  \             ['gitbranch', 'readonly', 'filename', 'modified'],
  \             ['cocstatus', 'cocCurrentFun'] ],
  \  'right': [ ['percent', 'lineinfo'],
  \             ['spell', 'filetype', 'fileencoding', 'fileformat'] ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status',
  \   'cocCurFun': 'CocCurrentFunction'
  \ },
  \ }

"function CreateLinkNames(text) abort
"  "return substitute(tolower(a:text), '\s\+', '_', 'g')
"  return strftime("%Y%m%dT%H%M-") . substitute(tolower(a:text), '\s\+', '-', 'g')
"endfunction

" PANDOC FIXME Find alternative markdown plugins. variables with number signs can't be called from Lua
let pandoc#spell#enabled = 0
let pandoc#syntax#conceal#urls = 1
let pandoc#syntax#conceal#use = 0
au BufNewFile,BufRead *.md set nowrap

