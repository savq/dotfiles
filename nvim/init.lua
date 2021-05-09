vim.cmd 'runtime vimrc'
require 'savq.lsp'
require 'savq.markup'

local map = require('savq.utils').map

-- Wait for vim.opt: neovim/neovim#13479
local g, opt, win = vim.g, vim.o, vim.wo
local cmd = vim.cmd

--- Nice neovim nuggets
opt.inccommand = 'nosplit'
cmd[[autocmd TextYankPost * lua vim.highlight.on_yank()]]


--- Mappings
map('<leader>rc', 'e ~/.config/nvim')             -- open config directory
map('<leader>pq', "lua require('savq.plugins')")  -- update packages
map('<leader>l',  'luafile %')
map('<leader>t',  'sp<cr><cmd>term')              -- open terminal
map('<Esc>',      '<C-\\><C-n>', 't')             -- terminal escape


--- Color scheme
do
    opt.termguicolors = true
    local h = tonumber(os.date("%H"))
    if 9 < h and h < 17 then
        opt.background = 'light'
    end
    cmd 'colorscheme melange'
    --require('lush')(require('melange')) --dev
end


--- Tree-sitter
require('nvim-treesitter.configs').setup {
    --ensure_installed = {'c', 'javascript', 'julia', 'lua', 'python', 'rust'},
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["ar"] = "@parameter.outer",
                ["at"] = "@class.outer",
                ["ac"] = "@call.outer",
                ["al"] = "@loop.outer",
                ["ak"] = "@conditional.outer",
            },
        },
    },
}


--- Auto completion
require('compe').setup {
    --min_length = 3,
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


--- Fuzzy finder
require('telescope').setup {
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
}
map('<leader>ff', 'Telescope find_files')
map('<leader>fg', 'Telescope live_grep')
map('<leader>fb', 'Telescope buffers')
map('<leader>fh', 'Telescope help_tags')


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


--- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1

