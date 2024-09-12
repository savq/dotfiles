function _grep(mode)
    local start, fin
    if mode == 'V' or mode == 'v' then
        start, fin = fn.getpos "'<", fn.getpos "'>"
    elseif mode == 'char' or mode == 'line' then
        start, fin = fn.getpos "'[", fn.getpos "']"
    end

    local args = fn.shellescape(table.concat(fn.getregion(start, fin)))

    cmd('silent grep! -- ' .. args)
    cmd 'copen'
end

keymap.set('n', '<leader>g', ':set operatorfunc=v:lua._grep<cr>g@', { silent = true })
keymap.set('v', '<leader>g', ':<c-u>call v:lua._grep(visualmode())<cr>', { silent = true })
