local augroup = require('utils').augroup


augroup('Enter', {
    InsertEnter = {
        callback = function()
            vim.opt.cursorline = true
        end,
    },
    ModeChanged = {
        pattern = '*:[vV\x16]*',
        callback = function() vim.opt.cursorcolumn = true end,
    },
})

augroup('Leave', {
    InsertLeave = {
        callback = function()
            vim.opt.cursorline = false
        end,
    },
    ModeChanged = {
        pattern = '[vV\x16]*:*',
        callback = function()
            vim.opt.cursorcolumn = false
        end,
    },
})
