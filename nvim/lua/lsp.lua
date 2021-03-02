local cmd  = vim.cmd
local map  = require('utils').map
local conf = require('lspconfig')
local cmpl = {on_attach = require('completion').on_attach}

local lspmap = map

conf.rust_analyzer.setup(cmpl)    -- rustup
conf.clangd.setup(cmpl)           -- llvm
conf.texlab.setup(cmpl)           -- brew
conf.julials.setup(cmpl)          -- Pkg.jl

-- Disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

---- GO-TO Mappings
map('gd', 'lua vim.lsp.buf.definition()')
map('gr', 'lua vim.lsp.buf.references()')
map('gs', 'lua vim.lsp.buf.document_symbol()')
map('ga', 'lua vim.lsp.buf.code_action()')

-- Diagnostics navegation mappings
map('d,', 'lua vim.lsp.diagnostic.goto_prev()')
map('d;', 'lua vim.lsp.diagnostic.goto_next()')

-- Complete with tab
cmd [[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]


-- Auto-commands
cmd[[autocmd BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync(nil)]]
cmd[[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]  -- floating window diagnostics

cmd[[autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
