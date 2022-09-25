vim.fn.matchadd('TrailWS', [[\s\{1,}$]])
vim.api.nvim_set_hl(0, 'TrailWS', { link = 'diffText' })

require('utils').augroup('Whitespace', {
    BufWritePre = {
        pattern = {
            '*.c',
            '*.h',
            '*.html',
            -- '*.jl',
            '*.js',
            '*.lua',
            '*.py',
            '*.rs',
            '*.tex',
        },
        callback = function()
            local st = vim.fn.winsaveview()
            vim.cmd [[%s/\s\+$//e]]
            vim.fn.winrestview(st)
        end,
    },
})
