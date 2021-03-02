local cmd  = vim.cmd
local conf = require('lspconfig')
local cmpl = {on_attach = require('completion').on_attach}

local function lspmap(lhs, rhs, mode)
    vim.api.nvim_set_keymap(
        mode or 'n',
        lhs,
        '<cmd>lua ' .. rhs .. '<cr>',
        {noremap=true, silent=true})
end

conf.rust_analyzer.setup(cmpl)    -- rustup
conf.clangd.setup(cmpl)           -- llvm
conf.texlab.setup(cmpl)           -- brew

lspmap('gd', 'vim.lsp.buf.definition()')
lspmap('gr', 'vim.lsp.buf.references()')
lspmap('gs', 'vim.lsp.buf.document_symbol()')
lspmap('ga', 'vim.lsp.buf.code_action()')

-- Navigate diagnostics
lspmap('d,', 'vim.lsp.diagnostic.goto_prev()') -- FIXME: Use other mappings for this
lspmap('d;', 'vim.lsp.diagnostic.goto_next()')

-- Complete with tab
cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]

cmd[[imap <Tab> <Plug>(completion_smart_tab)]]
cmd[[imap <S-Tab> <Plug>(completion_smart_s_tab)]]

-- Auto commands
cmd[[autocmd BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync(nil)]]
cmd[[autocmd Filetype c set shiftwidth=2]] -- move this elsewhere???

cmd[[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
