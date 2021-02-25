local cmd = vim.cmd

require 'lsp'       -- LSP configuration
require 'utils'
cmd 'runtime vimrc' -- general options

-- wait for vim.opt (nvim PR #13479)
local g, opt, win = vim.g, vim.o, vim.wo

-- wait for lua keymaps (nvim PR #13823)
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n',
                            '<leader>' .. lhs,
                            '<cmd>' .. rhs .. '<cr>',
                            {noremap=true, silent=true}
                            )
end

---- nice neovim stuff
opt.inccommand = 'nosplit' -- live substitution
cmd 'au TextYankPost * lua vim.highlight.on_yank()'

---- some mappings
map('pq', "lua require('packages')") -- update packages
map('l',  'luafile %')               -- source lua file
map('t',  'sp<cr> | <cmd>te')        -- open terminal
map('rc', 'e ~/.config/nvim')        -- open config directory


---- Colorscheme
opt.termguicolors = true
cmd 'colorscheme melange_dev' --WIP colorscheme

---- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {'c', 'julia', 'lua', 'rust'},
    highlight = {enable = true},
}


---- Statusline
opt.statusline = table.concat({
    '%2{mode()} | ',
    '%f ',        -- relative path
    '%m ',        -- modified flag
    '%=',
    '%{&spelllang} ',
    '%y',         -- filetype
    '%8(%l,%c%)', -- line, column
    '%6p%%',      -- file percentage
})

---- Telescope
require('telescope').setup {
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
}
map('ff', 'Telescope find_files')
map('fg', 'Telescope live_grep')
map('fb', 'Telescope buffers')
map('fh', 'Telescope help_tags')


---- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'markdown'}


---- Markdown and Wiki
g.markdown_enable_conceal = 1
g.wiki_root = '~/Documents/wiki'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinks' -- cannot use anonymous functions
cmd [[
function! CreateLinks(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction
]]

---- Spelling
cmd 'nnoremap <leader>c 1z=1' -- fix current word
map('s', 'lua cyclelang()')   -- change spelling language
do
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1
        vim.bo.spelllang = langs[i]
        win.spell = (langs[i] ~= '')
    end
end

---- Zen mode
map('z', 'lua togglezen()')
function togglezen()
    win.list           = not win.list
    win.number         = not win.number
    win.relativenumber = not win.relativenumber
    win.cursorline     = not win.cursorline
    win.cursorcolumn   = not win.cursorcolumn
    win.colorcolumn    = win.colorcolumn == '0' and '80' or '0'
    opt.laststatus     = opt.laststatus == 2 and 0 or 2
    opt.ruler          = not opt.ruler
end
