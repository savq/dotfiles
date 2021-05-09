local cmd  = vim.cmd
local map  = require('savq.utils').map
local conf = require('lspconfig')

conf.rust_analyzer.setup{}    -- rustup
conf.clangd.setup{}           -- llvm
conf.texlab.setup{}           -- brew
--conf.julials.setup{}          -- Pkg.jl

--- Complete with tab
map("<Tab>",  [[pumvisible() ? "\<C-n>" : "\<Tab>"]], 'i', true)
map("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], 'i', true)

--- GOTO Mappings
map('gd', 'lua vim.lsp.buf.definition()')
map('gr', 'lua vim.lsp.buf.references()')
map('gs', 'lua vim.lsp.buf.document_symbol()')
map('ga', 'lua vim.lsp.buf.code_action()')

--- Diagnostics navegation mappings
map('d,', 'lua vim.lsp.diagnostic.goto_prev()')
map('d;', 'lua vim.lsp.diagnostic.goto_next()')

--- Auto-commands
cmd[[au BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync()]]
cmd[[au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
--cmd[[au Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc]]

--- Disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)
