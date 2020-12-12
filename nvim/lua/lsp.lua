local cmd = vim.cmd
local lsp_conf = require'lspconfig'
local lsp_cmpl = require'completion'
lsp_conf.rls.setup{on_attach = lsp_cmpl.on_attach}
lsp_conf.texlab.setup{on_attach = lsp_cmpl.on_attach}

--autocmd BufEnter * lua require'completion'.on_attach()

local function lspmap(lhs, rhs, mode)
    vim.api.nvim_set_keymap(mode or 'n', '<silent>' .. lhs, '<cmd>lua '..rhs..'<cr>', {noremap=true, silent=true})
end

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

-- Enable type inlay hints
cmd[[autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{}]]

-- Auto-format *.rs files prior to saving them
cmd[[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil)]]
