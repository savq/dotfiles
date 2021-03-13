vim.cmd 'runtime vimrc'  -- general options
require 'lsp'            -- LSP configuration
require 'prose'          -- Prose and markup formats

local map = require('utils').map

-- wait for vim.opt (nvim PR #13479)
local g, opt, win = vim.g, vim.o, vim.wo
local cmd = vim.cmd

--- nice neovim nuggets
opt.inccommand = 'nosplit'
cmd[[autocmd TextYankPost * lua vim.highlight.on_yank()]]


--- some mappings
map('<leader>rc', 'e ~/.config/nvim')        -- open config directory
map('<leader>pq', "lua require('plugins')")  -- update packages
map('<leader>t',  'sp<cr><cmd>term')         -- open terminal
map('<leader>l',  'luafile %')               -- source lua file


--- Color scheme
opt.termguicolors = true
cmd 'colorscheme melange'


--- Tree-sitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {'c', 'javascript', 'julia', 'lua', 'python', 'rust'},
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["al"] = "@loop.outer",
                ["ac"] = "@conditional.outer",
            },
        },
    },
}


--- nvim-compe (auto completion)
require('compe').setup {
    min_length = 3,
    preselect = 'disable',
    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = true,
        omni = true,
    },
}


--- Telescope (fuzzy finder)
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


--- Zen mode
map('<leader>z', 'lua togglezen()')
function togglezen()
    win.list         = not win.list
    win.number       = not win.number
    win.cursorline   = not win.cursorline
    win.cursorcolumn = not win.cursorcolumn
    win.conceallevel = win.conceallevel == 1 and 0 or 1
    opt.laststatus   = opt.laststatus == 2 and 0 or 2
end
