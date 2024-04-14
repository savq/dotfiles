setmetatable(_G, { __index = vim })

local function augroup(name, autocmds)
    local group = api.nvim_create_augroup(name, {})
    for event, opts in pairs(autocmds) do
        opts.group = group
        api.nvim_create_autocmd(event, opts)
    end
end

-- Load basic configuration
cmd 'runtime vimrc'

do -- Appearance
    opt.laststatus = 2
    opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y #%{bufnr()} %8(%l,%c%) %8p%%'

    opt.termguicolors = true
    cmd.colorscheme 'melange'

    augroup('Highlights', {
        TextYankPost = {
            callback = function() highlight.on_yank() end,
        },
    })

    -- Set cursor hints according to mode
    augroup('Enter', {
        InsertEnter = { command = 'set cursorline' },
        ModeChanged = { command = 'set cursorcolumn', pattern = '*:[vV\x16]*' },
    })

    augroup('Leave', {
        InsertLeave = { command = 'set nocursorline' },
        ModeChanged = { command = 'set nocursorcolumn', pattern = '[vV\x16]*:*' },
    })
end


do -- "Focus" mode
    local active = false
    local function focus_toggle()
        active = not active
        opt.colorcolumn = active and '' or '100'
        opt.conceallevel = active and 2 or 0
        opt.foldcolumn = active and '0' or '1'
        opt.list = not active
        opt.number = not active
    end
    api.nvim_create_user_command('Focus', focus_toggle, {})
    keymap.set('n', '<leader>z', focus_toggle)
end

do -- Spelling
    -- NOTE: Use i_CTRL-X_s to correct spelling of previous misspelled word
    keymap.set('n', '<leader>l', function()
        ui.select({ 'en', 'es', 'de' }, {}, function(lang)
            opt.spell = lang ~= nil
            opt.spelllang = lang
        end)
    end)
end

do -- Embedded terminal (NOTE: send-to-REPL keymaps are in `term.vim`)
    augroup('Terminal', { TermOpen = { command = 'setlocal nospell nonumber' } })

    api.nvim_create_user_command('Sterminal', ':split | terminal', {})
    api.nvim_create_user_command('Vterminal', ':vsplit | terminal', {})

    -- Use escape key in terminal
    keymap.set('t', '<Esc>', [[<C-\><C-n>]])

    -- Open REPLs in small vertical split window
    for ext, bin in pairs {
        sh = '/bin/zsh',
        jl = 'julia --project -q',
        js = 'deno -q',
        py = 'python3 -q',
    } do
        keymap.set('n', '<leader>' .. ext, function()
            cmd '12split'
            cmd('edit term://' .. bin)
            cmd 'wincmd k'
        end)
    end
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
end

do -- Tree-sitter
    opt.foldmethod = 'expr'
    opt.foldexpr = 'nvim_treesitter#foldexpr()'

    require('nvim-treesitter.configs').setup {
        -- ensure_installed = { 'c', 'html', 'julia', 'lua', 'python', 'query', 'rust', 'typescript' },
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

do -- Auto-completion
    require('mini.completion').setup()
    keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
end

do -- LSP & Diagnostics
    local lspconfig = require 'lspconfig'
    for _, ls in ipairs {
        'clangd',
        'rust_analyzer',
        'denols',
        -- 'svelte',
        -- 'tsserver',
    } do
        lspconfig[ls].setup {}
    end

    local function on_attach(args)
        -- Disable virtual text
        diagnostic.config {
            float = { focus = false },
            virtual_text = false,
        }

        -- stylua: ignore
        for name, fn in pairs {
            Diagnostic = diagnostic.show,
            LspAction  = lsp.buf.code_action,
            LspSymbols = lsp.buf.document_symbol,
            LspFormat  = lsp.buf.format,
            LspImpls   = lsp.buf.implementation,
            LspRefs    = lsp.buf.references,
            LspRename  = lsp.buf.rename,
        } do
            api.nvim_create_user_command(name, function(_) fn() end, {})
        end

        keymap.set('n', '[d', diagnostic.goto_prev)
        keymap.set('n', ']d', diagnostic.goto_next)
        keymap.set('n', 'gd', lsp.buf.definition)

        augroup('Lsp', {
            BufWritePre = { buffer = args.buf, callback = function(_) lsp.buf.format() end },
            CursorHold = { buffer = args.buf, callback = function(_) diagnostic.open_float() end },
        })
    end

    augroup('LspConfig', { LspAttach = { callback = on_attach } })
end

require('gitsigns').setup { numhl = true, signcolumn = false }

require('mini.trailspace').setup()
