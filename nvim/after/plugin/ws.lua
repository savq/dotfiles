local hi = vim.api.nvim_set_hl
hi(0, 'TrailWS', { link = 'diffText' })
vim.fn.matchadd('TrailWS', [[\s\{2,}$]])

require('utils').augroup('Whitespace', {
    BufWritePre = {
        pattern = {
            '*.c',
            '*.h',
            '*.html',
            '*.jl',
            '*.js',
            '*.lua',
            '*.py',
            '*.rs',
        },
        callback = function()
            local st = vim.fn.winsaveview()
            vim.cmd [[%s/\s\+$//e]]
            vim.fn.winrestview(st)
        end,
    },
})
