lua << EOF
    local lsp_conf = require'lspconfig'
    local lsp_cmpl = require'completion'
    lsp_conf.rls.setup{on_attach = lsp_cmpl.on_attach}
    lsp_conf.texlab.setup{on_attach = lsp_cmpl.on_attach}
EOF

"autocmd BufEnter * lua require'completion'.on_attach()

" Complete with tab
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Navigate diagnostics
nnoremap <silent>d, <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent>d; <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{}

" Auto-format *.rs files prior to saving them
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil)
