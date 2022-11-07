local augroup = require('utils').augroup
local keymap = require('utils').keymap
local cmds = require('utils').cmds

augroup('Term', {
    TermOpen = { command = 'set nospell nonumber nocursorcolumn nocursorline' },
    -- TermClose = { command = 'bdelete' },
})

-- Use escape key in terminal
keymap('<Esc>', [[<C-\><C-n>]], 't')

-- Open REPLs in small vertical split window

local function cmds(cs)
    return function()
        vim.tbl_map(vim.cmd, cs)
    end
end

keymap('<leader>sh', cmds { '10sp', 'term' })
keymap('<leader>jl', cmds { '10sp', 'e term://julia --project -q', 'wincmd k' })
keymap('<leader>js', cmds { '10sp', 'e term://deno', 'wincmd k' })
keymap('<leader>py', cmds { '10sp', 'e term://python3 -q', 'wincmd k' })

-- NOTE: The commands to send things to REPL are in `term.vim`
