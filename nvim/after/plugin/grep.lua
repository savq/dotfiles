function _grep(mode)
    local start, fin
    if mode == 'V' or mode == 'v' then
        start, fin = vim.fn.getpos "'<", vim.fn.getpos "'>"
    elseif mode == 'char' or mode == 'line' then
        start, fin = vim.fn.getpos "'[", vim.fn.getpos "']"
    end

    local args = vim.fn.shellescape(table.concat(vim.fn.getregion(start, fin)))

    vim.cmd('silent grep! -- ' .. args)
    vim.cmd 'copen'
end

vim.keymap.set('n', '<leader>g', ':set operatorfunc=v:lua._grep<cr>g@', { silent = true })
vim.keymap.set('v', '<leader>g', ':<c-u>call v:lua._grep(visualmode())<cr>', { silent = true })
