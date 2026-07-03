local buf_repl_map = {}

local function open_repl(repl_cmd)
    return function()
        local buf = vim.fn.bufnr()
        vim.cmd '12new'
        buf_repl_map[buf] = vim.fn.termopen(repl_cmd)
        vim.cmd 'wincmd k'
    end
end

local function get_selection(mode)
    local first, last
    if mode == 'V' or mode == 'v' then
        first, last = "'<", "'>"
    elseif mode == 'char' or mode == 'line' then
        first, last = "'[", "']"
    end
    return vim.fn.getregion(vim.fn.getpos(first), vim.fn.getpos(last))
end

function _send_to_repl(mode)
    local lines = get_selection(mode)
    table.insert(lines, '')
    vim.fn.chansend(buf_repl_map[vim.fn.bufnr()], lines) -- :h nvim_list_chans()
end

vim.api.nvim_create_user_command('Sterminal', 'horizontal terminal', {})
vim.api.nvim_create_user_command('Vterminal', 'vertical terminal', {})

vim.keymap.set('n', '<leader>e', ':set operatorfunc=v:lua._send_to_repl<cr>g@', { silent = true })
vim.keymap.set('v', '<leader>e', ':<c-u>call v:lua._send_to_repl(visualmode())<cr>', { silent = true })
vim.keymap.set('n', '<leader>jl', open_repl { 'julia', '--project', '--startup-file=no', '-q' })
vim.keymap.set('n', '<leader>js', open_repl { 'deno', '-q' })
vim.keymap.set('n', '<leader>py', open_repl { 'uv', 'run', 'python3', '-q' })
vim.keymap.set('n', '<leader>sh', open_repl { vim.opt.shell:get() })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.api.nvim_create_autocmd('TermOpen', { pattern = '*', command = 'setlocal nospell' })
