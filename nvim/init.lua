-- Load basic configuration
vim.cmd.runtime 'vimrc'

do -- Paq
    vim.keymap.set('n', '<leader>pq', function()
        package.loaded.paq = nil
        package.loaded.plugins = nil
        require('plugins').sync_all()
    end)

    vim.keymap.set('n', '<leader>pg', function() vim.cmd.edit(vim.fn.stdpath 'config' .. '/lua/plugins.lua') end)
end

require('mini.diff').setup()
require('mini.pick').setup()
require('mini.trailspace').setup()
