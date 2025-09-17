setmetatable(_G, { __index = vim })

-- Load basic configuration
cmd.runtime 'vimrc'

do -- Paq
    keymap.set('n', '<leader>pq', function()
        package.loaded.paq = nil
        package.loaded.plugins = nil
        require('plugins').sync_all()
    end)

    keymap.set('n', '<leader>pg', function() cmd.edit(fn.stdpath 'config' .. '/lua/plugins.lua') end)
end

require('mini.diff').setup()
require('mini.pick').setup()
require('mini.trailspace').setup()
