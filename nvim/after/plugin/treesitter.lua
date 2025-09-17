local fts = { 'c', 'html', 'julia', 'lua', 'python', 'query', 'rust', 'typescript', 'markdown', 'markdown_inline' }

-- require'nvim-treesitter'.install(fts)

vim.api.nvim_create_autocmd('FileType', {
    pattern = fts,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require('nvim-treesitter-textobjects').setup {
    select = {
        lookahead = true,
    },
}

local select_textobject = require('nvim-treesitter-textobjects.select').select_textobject

for keys, obj in pairs {
    ['ac'] = '@call.outer',
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['ak'] = '@conditional.outer',
    ['at'] = '@class.outer',
} do
    vim.keymap.set({ 'x', 'o' }, keys, function() select_textobject(obj, 'textobjects') end)
end
