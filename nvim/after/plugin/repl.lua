_buf_repl_map = {}

local function open_repl(lang)
    local repls = {
        julia = { 'julia', '--project', '--startup-file=no', '-q' },
        python = { 'python3', '-q' },
        typescript = { 'deno', '-q' },
        javascript = { 'deno', '-q' },
    }
    return function()
        local buf = vim.fn.bufnr()
        local repl = repls[lang] or { vim.opt.shell:get() }
        vim.cmd '12new'
        _buf_repl_map[buf] = vim.fn.termopen(repl)
        vim.cmd 'wincmd k'
    end
end

function _send_to_repl(mode)
    local start, fin
    if mode == 'V' or mode == 'v' then
        start, fin = vim.fn.getpos "'<", vim.fn.getpos "'>"
    elseif mode == 'char' or mode == 'line' then
        start, fin = vim.fn.getpos "'[", vim.fn.getpos "']"
    end
    local lines = vim.fn.getregion(start, fin)
    table.insert(lines, '')
    vim.fn.chansend(_buf_repl_map[vim.fn.bufnr()], lines) -- :h nvim_list_chans()
end

vim.api.nvim_create_user_command('Sterminal', 'horizontal terminal', {})
vim.api.nvim_create_user_command('Vterminal', 'vertical terminal', {})

vim.keymap.set('n', '<leader>e', ':set operatorfunc=v:lua._send_to_repl<cr>g@', { silent = true })
vim.keymap.set('v', '<leader>e', ':<c-u>call v:lua._send_to_repl(visualmode())<cr>', { silent = true })
vim.keymap.set('n', '<leader>jl', open_repl 'julia')
vim.keymap.set('n', '<leader>py', open_repl 'python')
vim.keymap.set('n', '<leader>sh', open_repl())
vim.keymap.set('n', '<leader>t', open_repl(vim.opt.filetype:get()))
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
