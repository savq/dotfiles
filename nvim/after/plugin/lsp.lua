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

lsp.config('ts_ls', {
    cmd = { 'npx', 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'typescript' },
    init_options = {
        hostInfo = 'neovim',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
})

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

        api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function(_) lsp.buf.format() end,
            group = lsp_augroup,
        })
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
