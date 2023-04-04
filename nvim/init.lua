setmetatable(_G, { __index = vim })

local command = vim.api.nvim_create_user_command
local keymap = vim.keymap.set

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
    opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y %8(%l,%c%) %8p%%'

    opt.termguicolors = true
    cmd.colorscheme 'melange'

    augroup('Highlights', {
        TextYankPost = {
            callback = function()
                highlight.on_yank() -- FIXME
            end,
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

do -- Trailing whitespace
    fn.matchadd('WhitespaceTrailing', [[\s\{1,}$]])
    api.nvim_set_hl(0, 'WhitespaceTrailing', { link = 'diffText' })

    augroup('Whitespace', {
        BufWritePre = {
            pattern = { '*' },
            callback = function()
                local view = fn.winsaveview()
                cmd [[%s/\s\+$//e]]
                fn.winrestview(view)
            end,
        },
    })
end

do -- "Focus" mode
    local active = false
    local function focus_toggle()
        opt.list = active
        opt.number = active
        opt.colorcolumn = active and '100' or ''
        opt.conceallevel = active and 0 or 2
        active = not active
    end
    command('Focus', focus_toggle, {})
    keymap('n', '<leader>z', focus_toggle)
end

do -- Spelling
    local i = 1
    local langs = { '', 'en', 'es', 'de' }

    keymap('n', '<leader>l', function()
        i = (i % #langs) + 1
        opt.spell = langs[i] ~= ''
        opt.spelllang = langs[i]
    end)

    -- Fix spelling of previous word
    keymap({ 'n', 'i' }, '<c-s>', function()
        fn.execute 'normal! mmb1z=`m'
    end)
end

do -- Embedded terminal (NOTE: send-to-REPL keymaps are in `term.vim`)
    augroup('Terminal', { TermOpen = { command = 'set nospell nonumber' } })

    command('Sterminal', ':split | terminal', {})
    command('Vterminal', ':vsplit | terminal', {})

    -- Use escape key in terminal
    keymap('t', '<Esc>', [[<C-\><C-n>]])

    -- Open REPLs in small vertical split window
    for ext, bin in pairs {
        sh = '/bin/zsh',
        jl = 'julia --project -q',
        js = 'deno -q',
        py = 'python3 -q',
    } do
        keymap('n', '<leader>' .. ext, function()
            cmd '12split'
            cmd('edit term://' .. bin)
            cmd 'wincmd k'
        end)
    end
end

do -- Lua
    show = vim.pretty_print
    command('L', ':lua _=show(<args>)', { nargs = '*', complete = 'lua' })
end

----- Plugins ------------------------------------------------------------------

do -- Paq
    keymap('n', '<leader>pq', function()
        package.loaded.paq = nil
        package.loaded.plugins = nil
        require('plugins').sync_all()
    end)

    keymap('n', '<leader>pg', function()
        cmd.edit(fn.stdpath 'config' .. '/lua/plugins.lua')
    end)
end

do -- Markup
    g.disable_rainbow_hover = true

    g.markdown_enable_conceal = true
    g.markdown_enable_insert_mode_mappings = false

    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_quickfix_mode = 2

    g.wiki_filetypes = { 'wiki', 'md' }
    g.wiki_root = '~/Documents/wiki'
    g.wiki_map_text_to_link = function(txt)
        return { txt:lower():gsub('%s+', '-'), txt }
    end
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
    local cmp = require 'cmp'

    cmp.setup {
        completion = {
            keyword_length = 2,
            -- keyword_pattern = [[\k\+]], -- autocomplete non-ascii characters
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
        }, {
            { name = 'buffer' },
            { name = 'omni' },
            { name = 'path' },
            -- { name = 'latex_symbols' },
        }),
        mapping = cmp.mapping.preset.insert {
            ['<cr>'] = cmp.mapping.confirm { select = false },
            ['<tab>'] = function(fallback)
                return cmp.visible() and cmp.select_next_item() or fallback()
            end,
            ['<s-tab>'] = function(fallback)
                return cmp.visible() and cmp.select_prev_item() or fallback()
            end,
        },
    }

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' },
        }),
    })

    -- Don't use julia-vim unicode (use latex_symbols instead)
    g.latex_to_unicode_tab = 0
end

do -- LSP & Diagnostics
    for name, fn in pairs {
        LspDef = lsp.buf.definition,
        LspRefs = lsp.buf.references,
        LspDocSymbols = lsp.buf.document_symbol,
        LspCodeAction = lsp.buf.code_action,
        LspRename = lsp.buf.rename,

        LineDiagnostics = diagnostic.open_float,
        LspGotoPrev = diagnostic.goto_prev,
        LspGotoNext = diagnostic.goto_next,
    } do
        command(name, fn, {})
    end

    diagnostic.config {
        virtual_text = false,
        signs = true,
        float = { focus = false },
    }

    local function on_attach(client, bufnr)
        opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
        pat = { '*.rs', '*.c', '*.h', '<buffer>' }
        augroup('Lsp', {
            BufWritePre = { pattern = pat, callback = lsp.buf.format },
            CursorHold = { pattern = pat, callback = diagnostic.open_float },
        })
    end

    local lspconfig = require 'lspconfig'
    for _, ls in ipairs {
        'clangd',
        'rust_analyzer',
        'tsserver',
        'svelte',
    } do
        lspconfig[ls].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
        }
    end
end

do -- Git
    require('gitsigns').setup {
        numhl = true,
        signcolumn = false,
    }
end

do -- Telescope
    require('telescope').setup {
        defaults = {
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
        },
    }
    local builtin = require 'telescope.builtin'
    keymap('n', '<leader>ff', builtin.find_files)
    keymap('n', '<leader>fg', builtin.live_grep)
    keymap('n', '<leader>fr', builtin.registers)
end
