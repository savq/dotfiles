setmetatable(_G, { __index = vim })

-- Load basic configuration
cmd.runtime 'vimrc'

-- NOTE: UI config is in plugin/ui.lua

cmd.colorscheme 'melange'

opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y #%{bufnr()} %8(%l,%c%) %8p%%'

do -- Spelling
    -- NOTE: Use i_CTRL-X_s to correct spelling of previous misspelled word
    keymap.set('n', '<leader>l', function()
        ui.select({ 'en', 'es', 'de' }, {}, function(lang)
            opt.spell = lang ~= nil
            opt.spelllang = lang or ''
        end)
    end)
end

----- Plugins ------------------------------------------------------------------

do -- Paq
    keymap.set('n', '<leader>pq', function()
        package.loaded.paq = nil
        package.loaded.plugins = nil
        require('plugins').sync_all()
    end)

    keymap.set('n', '<leader>pg', function() cmd.edit(fn.stdpath 'config' .. '/lua/plugins.lua') end)
end

do -- Markup
    g.disable_rainbow_hover = true

    g.latex_to_unicode_file_types = { 'julia', 'typst' }

    g.markdown_enable_conceal = true
    g.markdown_enable_insert_mode_mappings = false

    g.wiki_root = '~/Documents/wiki'
    g.wiki_link_creation = {
        md = {
            url_transform = function(txt) return txt:lower():gsub('%s+', '-') end,
        },
    }

    --- TODO: Refactor
    api.nvim_create_user_command(
        'WikiPick',
        function() MiniPick.builtin.grep_live(nil, { source = { cwd = g.wiki_root } }) end,
        {}
    )
end

do -- Tree-sitter
    opt.foldmethod = 'expr'
    opt.foldexpr = 'nvim_treesitter#foldexpr()'

    require('nvim-treesitter.configs').setup {
        -- ensure_installed = { 'c', 'html', 'julia', 'lua', 'python', 'query', 'rust', 'typescript', 'markdown', 'markdown_inline' },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = { init_selection = '+', node_incremental = '+', node_decremental = '_' },
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['ac'] = '@call.outer',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ak'] = '@conditional.outer',
                    ['at'] = '@class.outer',
                },
            },
        },
    }
end

do -- LSP & Diagnostics
    local lspconfig = require 'lspconfig'
    for _, ls in ipairs {
        'clangd',
        'rust_analyzer',
        'denols',
        -- 'ocamllsp',
        -- 'svelte',
        -- 'ts_ls',
    } do
        lspconfig[ls].setup {}
    end

    api.nvim_create_autocmd('LspAttach', {
        group = api.nvim_create_augroup('LspConfig', {}),
        callback = function(args)
            -- Disable virtual text
            diagnostic.config {
                float = { focus = false },
                virtual_text = false,
            }

            -- stylua: ignore
            for name, fn in pairs {
                DxList      = diagnostic.setloclist,
                DxShow      = diagnostic.show,
                LspAction   = lsp.buf.code_action,
                LspSymbols  = lsp.buf.document_symbol,
                LspFormat   = lsp.buf.format,
                LspImpl     = lsp.buf.implementation,
                LspRefs     = lsp.buf.references,
                LspRename   = lsp.buf.rename,
                LspTypeDef  = lsp.buf.type_definition,
            } do
                api.nvim_create_user_command(name, function(_) fn() end, {})
            end

            -- NOTE: By default: ]d -> goto_next, [d -> goto_prev, K -> hover
            keymap.set('n', 'gd', lsp.buf.definition)

            local gr = api.nvim_create_augroup('Lsp', {})
            api.nvim_create_autocmd(
                'BufWritePre',
                { buffer = args.buf, callback = function(_) lsp.buf.format() end, group = gr }
            )
            api.nvim_create_autocmd(
                'CursorHold',
                { buffer = args.buf, callback = function(_) diagnostic.open_float() end, group = gr }
            )
        end,
    })
end

do -- Auto-completion
    require('mini.completion').setup()
    keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
end

require('mini.diff').setup()
require('mini.pick').setup()
require('mini.trailspace').setup()
