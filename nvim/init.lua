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
o.termguicolors = true
g.ayucolor = 'mirage'
cmd 'colorscheme ayu'
cmd 'au ColorScheme * hi Comment gui=italic'
cmd 'au ColorScheme * hi link TSParameter Normal'

---- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {'c', 'julia', 'lua', 'rust'},
    highlight = {enable = true},
}

---- Telescope
-- TODO: better telescope defaults
require('telescope')
map('ff', "Telescope find_files")
map('fg', "Telescope live_grep")
map('fb', "Telescope buffers")
map('fh', "Telescope help_tags")

---- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'markdown'}
map('j', '!julia %')


---- Prose
g.tex_flavor = 'xelatex'
g.markdown_enable_conceal = 1

---- Wiki.vim
g.wiki_root = 'WikiRoot'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinks' -- cannot use anonymous functions
cmd [[
function! CreateLinks(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction
]]

---- Spelling
map('s', 'lua cyclelang()') -- change spelling language
map('c', '1z=1', 1)         -- fix current word
do
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1
        b.spelllang = langs[i]
        w.spell = (langs[i] ~= '')
    end
end

---- Zen mode
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
