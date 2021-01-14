-- Useful aliases
local cmd, g, o, w, b = vim.cmd, vim.g, vim.o, vim.wo, vim.bo -- wait for vim.opt
local function map(lhs, rhs, txtcmd)
    local c = not txtcmd and '<cmd>' .. rhs .. '<cr>' or rhs
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, c, {noremap=true, silent=true})
end

require 'lsp'       -- LSP configuration
cmd 'runtime vimrc' -- general options

---- nice neovim stuff
o.inccommand = 'nosplit' -- live substitution
cmd 'au TextYankPost * lua vim.highlight.on_yank()'

---- some mappings
map('pq', "lua require 'packages'") -- update packages
map('l',  'luafile %')              -- source lua file
map('t',  'sp<cr> | <cmd>te')       -- open terminal
map('rc', 'e ~/.config/nvim')       -- open config directory

---- Statusline
o.statusline = table.concat({
    '%2{mode()} | ',
    '%f ',        -- relative path
    '%m ',        -- modified flag
    '%=',
    '%{&spelllang} ',
    '%y',         -- filetype
    '%8(%l,%c%)', -- line, column
    '%6p%%',      -- file percentage
})

---- Colorscheme
cmd 'colorscheme ayu'
g.ayucolor = 'mirage'
o.termguicolors = true

---- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {'rust', 'c', 'lua'},
    highlight = {enable = true},
}

-- Vimtex
g.tex_flavor = 'xelatex'

-- Wiki.vim
g.wiki_root = '~/Documents/wiki/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinks'
cmd [[function! CreateLinks(text) abort
          return substitute(tolower(a:text), '\s\+', '-', 'g')
      endfunction]]

-- Pandoc markdown
g['pandoc#spell#enabled'] = 0
g['pandoc#syntax#conceal#use'] = 0
g['pandoc#syntax#codeblocks#embeds#langs'] = {'c', 'sh', 'lua', 'rust', 'julia'}
cmd[[augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    augroup END]]

-- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'lisp', 'pandoc'}
map('j', '!julia %') -- Execute julia file

-- Spelling
map('s', 'lua cyclelang()') -- change spelling language
map('w', '1z=1', 1)         -- fix current word
do
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1
        b.spelllang = langs[i]
        w.spell = (langs[i] ~= '')
    end
end

map('z', 'lua togglezen()')
function togglezen()
    w.list           = not w.list
    w.number         = not w.number
    w.relativenumber = not w.relativenumber
    w.cursorline     = not w.cursorline
    w.cursorcolumn   = not w.cursorcolumn
    w.colorcolumn    = w.colorcolumn == '0' and '80' or '0'
    o.laststatus     = o.laststatus == 2 and 0 or 2
    o.ruler          = not o.ruler
end
