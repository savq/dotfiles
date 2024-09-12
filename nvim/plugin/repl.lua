local function open_repl(lang)
    local repls = {
        julia = { 'julia', '--project', '--startup-file=no', '-q' },
        python = { 'python3', '-q' },
        typescript = { 'deno', '-q' },
        javascript = { 'deno', '-q' },
    }
    local repl = repls[lang] or { opt.shell:get() }
    cmd '12new'
    g.term_id = fn.termopen(repl)
    cmd 'wincmd k'
end

function _send_to_repl(mode)
    local start, fin
    if mode == 'V' or mode == 'v' then
        start, fin = fn.getpos "'<", fn.getpos "'>"
    elseif mode == 'char' or mode == 'line' then
        start, fin = fn.getpos "'[", fn.getpos "']"
    end
    local lines = fn.getregion(start, fin)
    table.insert(lines, '')
    fn.chansend(g.term_id, lines) -- :h nvim_list_chans()
end

api.nvim_create_autocmd('TermOpen', {
    command = 'setlocal nonumber nospell',
    group = api.nvim_create_augroup('Terminal', {}),
})

api.nvim_create_user_command('Sterminal', 'horizontal terminal', {})
api.nvim_create_user_command('Vterminal', 'vertical terminal', {})

-- FIXME
keymap.set('n', '<leader>e', ':set operatorfunc=v:lua._send_to_repl<cr>g@', { silent = true })
keymap.set('v', '<leader>e', ':<c-u>call v:lua._send_to_repl(visualmode())<cr>', { silent = true })
keymap.set('n', '<leader>jl', function() open_repl 'julia' end)
keymap.set('n', '<leader>py', function() open_repl 'python' end)
keymap.set('n', '<leader>sh', function() open_repl() end)
keymap.set('n', '<leader>t', function() open_repl(opt.filetype:get()) end)
keymap.set('t', '<Esc>', [[<C-\><C-n>]])
