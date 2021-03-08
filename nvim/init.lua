vim.cmd 'runtime vimrc'  -- general options
require 'lsp'            -- LSP configuration
local map = require('utils').map

-- wait for vim.opt (nvim PR #13479)
local g, opt, win = vim.g, vim.o, vim.wo
local cmd = vim.cmd

--- nice neovim stuff
opt.inccommand = 'nosplit'
cmd 'autocmd TextYankPost * lua vim.highlight.on_yank()'


--- some mappings
map('<leader>rc', 'e ~/.config/nvim')        -- open config directory
map('<leader>pq', "lua require('plugins')")  -- update packages
map('<leader>t',  'sp<cr><cmd>term')         -- open terminal
map('<leader>l',  'luafile %')               -- source lua file


--- Color scheme
opt.termguicolors = true
cmd 'colorscheme melange'


--- Tree-sitter
--require('nvim-treesitter.configs').setup {
--    ensure_installed = {'c', 'julia', 'lua', 'rust'},
--    highlight = {enable = true},
--}


--- Status line
opt.statusline = table.concat({
    '  ',
    'f',            -- relative path
    'm',            -- modified flag
    'r',
    '=',
    '{&spelllang}',
    'y',            -- filetype
    '8(%l,%c%)',    -- line, column
    '8p%% ',        -- file percentage
}, ' %')


--- Telescope
require('telescope').setup {
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
}
map('<leader>ff', 'Telescope find_files')
map('<leader>fg', 'Telescope live_grep')
map('<leader>fb', 'Telescope buffers')
map('<leader>fh', 'Telescope help_tags')


--- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'markdown'}


--- Markdown and Wiki
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
g.user_emmet_leader_key = '<C-e>'


--- Spelling
cmd('nnoremap <leader>c 1z=1')         -- fix current word
map('<leader>s', 'lua cyclelang()')    -- change spelling language
do
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1
        vim.bo.spelllang = langs[i]
        win.spell = (langs[i] ~= '')
    end
end


--- Zen mode
map('<leader>z', 'lua togglezen()')
function togglezen()
    win.list         = not win.list
    win.number       = not win.number
    win.cursorline   = not win.cursorline
    win.cursorcolumn = not win.cursorcolumn
    opt.laststatus   = opt.laststatus == 2 and 0 or 2
end
