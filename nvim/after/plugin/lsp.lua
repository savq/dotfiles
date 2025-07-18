lsp.enable {
    'clangd',
    'rust_analyzer',
    -- 'denols',
    -- 'julials',
    -- 'ocamllsp',
    -- 'svelte',
    'tinymist',
    'ts_ls', -- npm add --save-dev typescript-language-server typescript;
}

local lsp_augroup = api.nvim_create_augroup('Lsp', {})
api.nvim_create_autocmd('LspAttach', {
    group = lsp_augroup,
    callback = function(args)
        -- stylua: ignore
        for name, fn in pairs {
            DxList = diagnostic.setloclist,
            DxShow = diagnostic.show,
            LspAction   = lsp.buf.code_action,
            LspDef      = lsp.buf.definition,
            LspFormat   = lsp.buf.format,
            LspImpl     = lsp.buf.implementation,
            LspRefs     = lsp.buf.references,
            LspRename   = lsp.buf.rename,
            LspSymbols  = lsp.buf.document_symbol,
            LspTypeDef  = lsp.buf.type_definition,
        } do
            api.nvim_buf_create_user_command(args.buf, name, function(_) fn() end, {})
        end

        -- NOTE: By default: ]d -> jump +1, [d -> jump -1, K -> hover
        keymap.set('n', 'gd', lsp.buf.definition)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if
            not client:supports_method 'textDocument/willSaveWaitUntil'
            and client:supports_method 'textDocument/formatting'
        then
            api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function(_) lsp.buf.format() end,
                group = lsp_augroup,
            })
        end

        api.nvim_create_autocmd('CursorHold', {
            buffer = args.buf,
            callback = function(_)
                lsp.buf.document_highlight()
                diagnostic.open_float()
            end,
            group = lsp_augroup,
        })
        api.nvim_create_autocmd('CursorMoved', {
            buffer = args.buf,
            callback = function(_) lsp.buf.clear_references() end,
            group = lsp_augroup,
        })
    end,
})

-- SERVER SPECIFIC CONFIG

local config_typst = vim.lsp.config['tinymist']
config_typst.root_markers = { 'main.typ' }
lsp.config('tinymist', config_typst)

local config_tsls = vim.lsp.config['ts_ls']
config_tsls.cmd = { 'npx', 'typescript-language-server', '--stdio' }
lsp.config('ts_ls', config_tsls)
