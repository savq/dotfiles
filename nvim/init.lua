-- Useful aliases
local cmd, g, o, w, b = vim.cmd, vim.g, vim.o, vim.wo, vim.bo
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

require 'lsp'
cmd'runtime vimrc'

---- Colorscheme
cmd 'colorscheme ayu'
g.ayucolor = 'mirage'
o.termguicolors = true

---- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {'rust', 'c', 'lua'},
    highlight = {enable = true},
}

---- Lightline
g.lightline = {
    colorscheme = 'ayu_mirage',
    active = {
        right = {
            {'percent', 'lineinfo'},
            {'spell', 'filetype', 'fileencoding', 'fileformat'}
        }
    }
}

-- Vimtex
g.tex_flavor = 'xelatex'

-- Wiki.vim
g.wiki_root = '~/Documents/wiki/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinks'
cmd [[function CreateLinks(text) abort
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction]]

-- Pandoc markdown
g['pandoc#spell#enabled'] = 0
g['pandoc#syntax#conceal#use'] = 0
g['pandoc#syntax#codeblocks#embeds#langs'] = {'c', 'sh', 'lua'}
cmd[[augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    augroup END]]

-- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'lisp', 'pandoc'}
map('j', ':!julia %<cr>') -- Execute julia file

-- Spelling
map('x', 'b1z=e')                -- Correct previous word
map('c', '1z=1')                 -- Correct current word
map('s', ':lua cyclelang()<cr>') -- Change spelling language
do
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1     -- update index
        b.spelllang = langs[i]   -- change spelllang
        w.spell = langs[i] ~= '' -- if empty then nospell
    end
end

-- Poor man's Zen mode
map('z', ':lua togglezen()<cr>')
function togglezen()
    w.list           = not w.list            --(hidden chars)
    w.number         = not w.number
    w.relativenumber = not w.relativenumber
    w.cursorline     = not w.cursorline
    w.cursorcolumn   = not w.cursorcolumn
    w.colorcolumn    = w.colorcolumn == '0' and '80' or '0'
    o.laststatus     = o.laststatus == 2 and 0 or 2
    o.ruler          = not o.ruler
end

-- Other mappings
map('l',  '<cmd>luafile %<cr>')           -- source lua file
map('t',  '<cmd> sp<cr>|<cmd>te   <cr>i') -- open terminal
map('rc', '<cmd> e ~/.config/nvim <cr>')  -- open config directory
