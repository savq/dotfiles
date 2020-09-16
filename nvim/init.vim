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

""" APPEARANCE (Let the TUI decide the font)
set termguicolors "Enables true color support
let ayucolor="mirage"
colorscheme ayu
hi Comment gui=italic
hi Normal guibg=NONE ctermbg=NONE

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
let g:wiki_map_link_create =  'CreateLinkNames'

function CreateLinkNames(text) abort
  "return substitute(tolower(a:text), '\s\+', '_', 'g')
  return strftime("%Y%m%dT%H%M-") . substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

""" VIMTEX
let g:tex_flavor = 'latex'

""" PANDOC
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#conceal#use = 0
au BufNewFile,BufRead *.md set nowrap "Vim-Pandoc can't disable wrapping

""" CoC settings go here
runtime coc.vim

""" MAPPINGS
let mapleader = " "
noremap ; :

"Why is K for help?
noremap <c-h> K

"Better navigation
noremap J }
noremap K {
noremap H ^
noremap L $

"Disable arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

"Copy to system clipboard
noremap Y "+y

"Terminal
noremap <silent><leader>t :vs\|:te<cr>

"Open this file
noremap <silent><leader>rc :e ~/.config/nvim/init.vim<cr>

"Print date & time
noremap <silent><leader>d "=strftime("%Y-%m-%d %T")<cr>p

"Coc Format
noremap <silent><leader>f :call CocAction('format')<cr>

""" Julia
let g:latex_to_unicode_tab = 0 "This messes with coc, FIXME after nvim 0.5 + lsp
noremap <silent><leader>j :!julia %<cr>

""" SPELLING MAPPINGS
" Correct last word
noremap <silent><Leader>z b1z=e
" Correct current word
noremap <silent><Leader>x 1z=1
" Change spelling language
noremap <silent><leader>s :lua CycleSpell()<cr>

"Lua version of this solution: <stackoverflow.com/questions/12006508>
lua << EOF
    local spl = {i = 1, langs = {'', 'en', 'es', 'de'}}
    function CycleLang()
        spl.i = (spl.i % #spl.langs) + 1      --update index
        vim.bo.spelllang = spl.langs[spl.i]   --change spelllang
        vim.wo.spell = spl.langs[spl.i] ~= '' --if empty then nospell
    end
EOF

