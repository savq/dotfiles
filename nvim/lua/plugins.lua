---- PLUGINS ----

-- My WIP package manager
vim.cmd 'packadd paq-nvim'
local Paq = require 'paq-nvim'
local paq = Paq.paq
paq{'savq/paq-nvim', opt=true}


-- coc.nvim
paq{'neoclide/coc.nvim', branch='release'}
noremap(SL ..'f :call CocAction("format")<cr>')


-- Ayu theme
paq 'ayu-theme/ayu-vim'
vim.o.termguicolors = true
vim.g.ayucolor='mirage'
vim.cmd'colorscheme ayu'
vim.cmd'hi Comment gui=italic'


-- Julia
paq 'JuliaEditorSupport/julia-vim'
vim.g.latex_to_unicode_tab = 0
vim.g.latex_to_unicode_auto = 1
noremap'<expr> <F7> LaTeXtoUnicode#Toggle()'
noremap(SL ..'j :!julia %<cr>')


-- Vimtex
paq 'lervag/vimtex'
vim.g.tex_flavor = 'xelatex'
vim.g.vimtex_quickfix_mode = 2 -- Open _only_ if there are errors


-- Wiki.vim
paq 'lervag/wiki.vim'
vim.g.wiki_root = '~/Documents/notes/'
vim.g.wiki_filetypes = {'md'}
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_map_link_create = 'CreateLinkNames'
--TODO write CreateLinkNames() in Lua and pass it to vimscript


-- Pandoc markdown
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'
vim.cmd'let pandoc#spell#enabled = 0'
vim.cmd'let pandoc#syntax#conceal#use = 0'
vim.cmd'let g:pandoc#syntax#conceal#urls = 1'
vim.cmd'au BufNewFile,BufRead *.md set nowrap'


-- Misc
paq 'itchyny/lightline.vim'
paq 'junegunn/vim-easy-align'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors
paq{'mechatroner/rainbow_csv', opt=true}
vim.cmd'au BufNewFile,BufRead *.csv packadd rainbow_csv'

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

