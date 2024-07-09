local TERM_ID

local function open_repl(lang)
    local repls = {
        julia = { 'julia', '--project', '-q' },
        python = { 'python3', '-q' },
        typescript = { 'deno', '-q' },
        javascript = { 'deno', '-q' },
    }
    local repl = repls[opt.filetype:get()] or { opt.shell:get() }
    cmd '12new'
    TERM_ID = fn.termopen(repl)
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
    fn.chansend(TERM_ID, lines)
end

api.nvim_create_autocmd('TermOpen', {
    command = 'setlocal nonumber nospell',
    group = api.nvim_create_augroup('Terminal', {}),
})

api.nvim_create_user_command('Sterminal', 'horizontal terminal', {})
api.nvim_create_user_command('Vterminal', 'vertical terminal', {})

-- FIXME
keymap.set('n', '<leader>e', ':set operatorfunc=v:lua._send_to_terminal<cr>g@', { silent = true })
keymap.set('v', '<leader>e', ':<c-u>call v:lua._send_to_terminal(visualmode())<cr>', { silent = true })
keymap.set('n', '<leader>t', open_repl)
keymap.set('t', '<Esc>', [[<C-\><C-n>]])
