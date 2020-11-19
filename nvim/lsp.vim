" Based on <sharksforarms.dev/posts/neovim-rust/>

packadd nvim-lspconfig
packadd completion-nvim
packadd diagnostic-nvim

lua << EOF
    local lsp_conf = require'nvim_lsp'
    local lsp_cmpl = require'completion'
    local lsp_diag = require'diagnostic'

    -- function to attach completion and diagnostics when setting up lsp
    local function on_attach(client)
        lsp_cmpl.on_attach(client)
        lsp_diag.on_attach(client)
    end

    lsp_conf.rls.setup{on_attach=on_attach} --NOTE: Wait for rust-analyzer to become default
EOF

" Code navigation shortcuts
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Complete with tab
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

" Auto-format *.rs files prior to saving them
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil)

