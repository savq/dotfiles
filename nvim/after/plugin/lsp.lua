local lsp_buf = vim.lsp.buf

vim.lsp.enable {
    'clangd',
    'rust_analyzer',
    -- 'denols',
    -- 'julials',
    -- 'ocamllsp',
    -- 'svelte',
    'tinymist',
    'ts_ls', -- npm add --save-dev typescript-language-server typescript;
}

local lsp_augroup = vim.api.nvim_create_augroup('Lsp', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_augroup,
    callback = function(args)
        -- stylua: ignore
        for name, fn in pairs {
            DxList = vim.diagnostic.setloclist,
            DxShow = vim.diagnostic.show,
            LspAction   = lsp_buf.code_action,
            LspDef      = lsp_buf.definition,
            LspFormat   = lsp_buf.format,
            LspImpl     = lsp_buf.implementation,
            LspRefs     = lsp_buf.references,
            LspRename   = lsp_buf.rename,
            LspSymbols  = lsp_buf.document_symbol,
            LspTypeDef  = lsp_buf.type_definition,
        } do
            vim.api.nvim_buf_create_user_command(args.buf, name, function(_) fn() end, {})
        end

        -- NOTE: By default: ]d -> jump +1, [d -> jump -1, K -> hover
        vim.keymap.set('n', 'gd', lsp_buf.definition)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if
            not client:supports_method 'textDocument/willSaveWaitUntil'
            and client:supports_method 'textDocument/formatting'
        then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function(_) lsp_buf.format() end,
                group = lsp_augroup,
            })
        end

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = args.buf,
            callback = function(_)
                lsp_buf.document_highlight()
                vim.diagnostic.open_float()
            end,
            group = lsp_augroup,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = args.buf,
            callback = function(_) lsp_buf.clear_references() end,
            group = lsp_augroup,
        })
    end,
})

-- SERVER SPECIFIC CONFIG

local config_typst = vim.lsp.config['tinymist']
config_typst.root_markers = { 'main.typ' }
vim.lsp.config('tinymist', config_typst)

local config_tsls = vim.lsp.config['ts_ls']
config_tsls.cmd = { 'npx', 'typescript-language-server', '--stdio' }
vim.lsp.config('ts_ls', config_tsls)
