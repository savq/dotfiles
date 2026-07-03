local function get_selection(mode)
    local first, last
    if mode == 'V' or mode == 'v' then
        first, last = "'<", "'>"
    elseif mode == 'char' or mode == 'line' then
        first, last = "'[", "']"
    end
    return vim.fn.getregion(vim.fn.getpos(first), vim.fn.getpos(last))
end

function _grep(mode)
    local lines = get_selection(mode)
    local args = vim.fn.shellescape(table.concat(lines))
    vim.cmd('silent grep! -- ' .. args)
    vim.cmd 'copen'
end

vim.keymap.set('n', '<leader>rg', ':set operatorfunc=v:lua._grep<cr>g@', { silent = true })
vim.keymap.set('v', '<leader>rg', ':<c-u>call v:lua._grep(visualmode())<cr>', { silent = true })
