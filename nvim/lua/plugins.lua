---- PLUGINS ----

local cmd = vim.cmd
local g = vim.g

-- My WIP package manager
vim.cmd 'packadd paq-nvim'
local Paq = require 'paq-nvim'
local paq = Paq.paq
paq{'savq/paq-nvim', opt=true}


-- LSP Client: coc.nvim
paq{'neoclide/coc.nvim', branch='release'}
noremap(SL ..'f :call CocAction("format")<cr>')


-- Theme: Ayu mirage
paq 'ayu-theme/ayu-vim'
vim.o.termguicolors = true
g.ayucolor='mirage'
cmd'colorscheme ayu'
cmd'hi Comment gui=italic'


-- Julia
paq 'JuliaEditorSupport/julia-vim'
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
noremap'<expr> <F7> LaTeXtoUnicode#Toggle()'
noremap(SL ..'j :!julia %<cr>')


-- Vimtex
paq 'lervag/vimtex'
g.tex_flavor = 'xelatex'
g.vimtex_quickfix_mode = 2 -- Open _only_ if there are errors


-- Wiki.vim
paq 'lervag/wiki.vim'
g.wiki_root = '~/Documents/notes/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinkNames'
--TODO write CreateLinkNames() in Lua and pass it to vimscript


-- Pandoc markdown
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'
cmd 'let pandoc#spell#enabled = 0'
cmd 'let pandoc#syntax#conceal#use = 0'
cmd 'let g:pandoc#syntax#conceal#urls = 1'
cmd 'au BufNewFile,BufRead *.md set nowrap'


-- Misc
paq 'itchyny/lightline.vim'
paq 'junegunn/vim-easy-align'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors
paq{'mechatroner/rainbow_csv', opt=true}
cmd 'au BufNewFile,BufRead *.csv packadd rainbow_csv'

-- Netrw
g.netrw_banner = 0
g.netrw_liststyle = 3

