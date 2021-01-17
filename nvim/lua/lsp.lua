local cmd  = vim.cmd
local conf = require('lspconfig')
local cmpl = {on_attach = require('completion').on_attach}

local function lspmap(lhs, rhs, mode)
    vim.api.nvim_set_keymap(
        mode or 'n',
        '<silent>' .. lhs,
        '<cmd>lua ' .. rhs .. '<cr>',
        {noremap=true, silent=true})
end

conf.rls.setup(cmpl)
conf.clangd.setup(cmpl)
conf.texlab.setup(cmpl)
conf.julials.setup{} -- Completion doesn't work

lspmap('gd', 'vim.lsp.buf.definition()')
lspmap('gr', 'vim.lsp.buf.references()')
lspmap('gs', 'vim.lsp.buf.document_symbol()')
lspmap('ga', 'vim.lsp.buf.code_action()')

-- Navigate diagnostics
lspmap('d,', 'vim.lsp.diagnostic.goto_prev()')
lspmap('d;', 'vim.lsp.diagnostic.goto_next()')

-- Complete with tab
cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]

-- Auto commands
cmd[[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil)]]
cmd[[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
