local utils = require 'utils'
local keymap = utils.keymap
local augroup = utils.augroup

augroup.scripting = {
    -- run scripts with <cr>
    { 'FileType', 'julia', 'noremap <buffer><cr> <cmd>!julia %<cr>' },
    { 'FileType', 'lua,vim', 'noremap <buffer><cr> <cmd>source %<cr> ' },
    { 'FileType', 'python', 'noremap <buffer><cr> <cmd>!python3 %<cr>' },
    { 'FileType', 'rust', 'noremap <buffer><cr> <cmd>Cargo run<cr>' },

    -- compile with <bs>
    { 'FileType', 'c,lua', 'noremap <silent><buffer><bs> <cmd>make<cr>' },
    { 'FileType', 'rust', 'noremap <silent><buffer><bs> <cmd>Cargo build<cr>' },

    { 'TermOpen', '*', 'set nospell nonumber nocursorcolumn nocursorline' },
    { 'TermClose', '*', 'quit' },
}

-- Open shell or REPLs in small vertical split window
local rhs = [[<cmd>12sp | %s<cr>]] -- | wincmd k<cr>]]
keymap {
    ['<leader>sh'] = rhs:format 'term',
    ['<leader>jl'] = rhs:format 'e term://julia -q',
    ['<leader>py'] = rhs:format 'e term://python3 -q',
    ['<leader>4'] = rhs:format 'e term://gforth',
}

-- Use escape key in terminal
keymap({ mode = 't' }, { ['<esc>'] = [[<C-\><C-n>]] })

-- Keymap to send things to the REPL
keymap({ mode = 'n' }, { ['<leader>e'] = [[set operatorfunc=v:lua.require'term'.operator<cr>g@]] })
keymap({ mode = 'v' }, { ['<leader>e'] = [[<c-u>call v:lua.require'term'.operator(visualmode())]] })

-- TODO: Allow horizontal splits as well as vertical splits
local function operator(type)
    show(type)
    local reg = vim.fn.getreg()
    if type == 'V' or type == 'v' or type == '\22' then
        vim.cmd 'normal! `<v`>y'
    elseif type == 'char' or type == 'line' then
        vim.cmd 'normal! `[v`]y'
    else
        return
    end
    vim.cmd [[wincmd j | put | call feedkeys("i\<cr>\<esc>\<c-w>k")]]
    vim.fn.setreg('', reg)
end

return { operator = operator }
