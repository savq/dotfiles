_buf_repl_map = {}

local function open_repl(lang)
    local repls = {
        julia = { 'julia', '--project', '--startup-file=no', '-q' },
        python = { 'python3', '-q' },
        typescript = { 'deno', '-q' },
        javascript = { 'deno', '-q' },
    }
    return function()
        local repl = repls[lang] or { opt.shell:get() }
        local buf = fn.bufnr()
        cmd '12new'
        _buf_repl_map[buf] = fn.termopen(repl)
        cmd 'wincmd k'
    end
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
    fn.chansend(_buf_repl_map[fn.bufnr()], lines) -- :h nvim_list_chans()
end

api.nvim_create_user_command('Sterminal', 'horizontal terminal', {})
api.nvim_create_user_command('Vterminal', 'vertical terminal', {})

keymap.set('n', '<leader>e', ':set operatorfunc=v:lua._send_to_repl<cr>g@', { silent = true })
keymap.set('v', '<leader>e', ':<c-u>call v:lua._send_to_repl(visualmode())<cr>', { silent = true })
keymap.set('n', '<leader>jl', open_repl 'julia')
keymap.set('n', '<leader>py', open_repl 'python')
keymap.set('n', '<leader>sh', open_repl())
keymap.set('n', '<leader>t', open_repl(opt.filetype:get()))
keymap.set('t', '<Esc>', [[<C-\><C-n>]])
