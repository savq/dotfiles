setmetatable(_G, { __index = vim })
cmd 'runtime vimrc'

-- Utils
local command = vim.api.nvim_create_user_command
local function keymap(lhs, rhs, mode)
    vim.keymap.set(mode or 'n', lhs, rhs)
end
local function augroup(name, autocmds)
    local group = vim.api.nvim_create_augroup(name, {})
    for event, cmd in pairs(autocmds) do
        cmd.group = group
        vim.api.nvim_create_autocmd(event, cmd)
    end
end

do -- Paq
    keymap('<leader>pq', function()
        package.loaded.plugins = nil
        require('plugins').sync_all()
    end)

    keymap('<leader>pg', '<cmd>edit ' .. fn.stdpath 'config' .. '/lua/plugins.lua<cr>')
end

do -- Tree-sitter
    opt.foldmethod = 'expr'
    opt.foldexpr = 'nvim_treesitter#foldexpr()'
    require 'tsjl' -- local Julia grammar
    require('nvim-treesitter.configs').setup {
        -- ensure_installed = { 'c', 'javascript', 'julia', 'lua', 'python', 'rust', 'html', 'query', 'toml' },
        highlight = { enable = true },
        indent = { enable = false },
        incremental_selection = {
            enable = true,
            keymaps = { init_selection = '+', node_incremental = '+', node_decremental = '_' },
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ac = '@call.outer',
                    af = '@function.outer',
                    ak = '@conditional.outer',
                    at = '@class.outer',
                },
            },
        },
    }
end

do -- Auto-completion
    local cmp = require 'cmp'

    cmp.setup {
        completion = {
            keyword_length = 3,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
        }, {
            { name = 'buffer' },
            { name = 'path' },
            { name = 'latex_symbols' },
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
            { name = 'cmdline' }, -- keyword_pattern = [[^\@<!Man\s]] },
        }),
    })

    -- Don't use julia-vim unicode (use latex_symbols instead)
    g.latex_to_unicode_tab = 0
end

do -- LSP & Diagnostics
    local lsp_cmds = {
        LspDef = lsp.buf.definition,
        LspRefs = lsp.buf.references,
        LspDocSymbols = lsp.buf.document_symbol,
        LspCodeAction = lsp.buf.code_action,
        LspRename = lsp.buf.rename,

        LineDiagnostics = diagnostic.open_float,
        LspGotoPrev = diagnostic.goto_prev,
        LspGotoNext = diagnostic.goto_next,
    }
    for name, cmd in pairs(lsp_cmds) do
        command(name, cmd, {})
    end

    diagnostic.config {
        -- virtual_text = false,
        signs = true,
        float = { focus = false },
    }

    local function on_attach(client, bufnr)
        opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
        pat = { '*.rs', '*.c', '*.h', '<buffer>' }
        augroup('Lsp', {
            BufWritePre = { pattern = pat, callback = lsp.buf.formatting_sync, desc = 'format' },
            CursorHold = { pattern = pat, callback = diagnostic.open_float, desc = 'diagnostic floating window' },
        })
    end

    local lspconfig = require 'lspconfig'
    local servers = { 'clangd', 'rust_analyzer' }
    for _, ls in ipairs(servers) do
        lspconfig[ls].setup {
            capabilities = require('cmp_nvim_lsp').update_capabilities(lsp.protocol.make_client_capabilities()),
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
        }
    end
end

do -- Markup: markdown, HTML, LaTeX
    g.markdown_enable_conceal = true
    g.markdown_enable_insert_mode_mappings = false
    -- g.user_emmet_leader_key = '<C-e>'

    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_quickfix_mode = 2

    g.wiki_filetypes = { 'md' }
    g.wiki_link_target_type = 'md'
    g.wiki_map_link_create = function(txt)
        return txt:lower():gsub('%s+', '-')
    end
    g.wiki_root = '~/Documents/wiki'
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
    keymap('<leader>ff', builtin.find_files)
    keymap('<leader>fg', builtin.live_grep)
    keymap('<leader>fr', builtin.registers)
end

do -- Spelling
    local i = 1
    local langs = { '', 'en', 'es', 'de' }

    keymap('<leader>l', function()
        i = (i % #langs) + 1
        opt.spell = langs[i] ~= ''
        opt.spelllang = langs[i]
    end)

    keymap('<c-s>', function()
        vim.fn.execute 'normal! mmb1z=`m'
    end, { 'n', 'i' })
end

do -- Focus mode
    local active = false
    function focus_toggle()
        opt.list = active
        opt.number = active
        opt.cursorline = active
        opt.cursorcolumn = active
        opt.colorcolumn = active and '81' or ''
        opt.conceallevel = active and 0 or 2
        active = not active
    end
    keymap('<leader>z', focus_toggle)
end

do -- Appearance
    opt.laststatus = 3 -- global statusline
    opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y %8(%l,%c%) %8p%%'
    opt.termguicolors = true

    augroup('Highlights', {
        TextYankPost = { callback = highlight.on_yank, desc = 'highlight.on_yank' },
        FileType = { pattern = 'tex', command = 'highlight! link Conceal Normal' },
    })
    cmd 'colorscheme melange'
end

do -- Lua
    function show(...)
        print(unpack(vim.tbl_map(vim.inspect, { ... })))
        return ...
    end
    command('L', ':lua _=show(<args>)', { nargs = '*', complete = 'lua' })

    augroup('LuaHelp', {
        FileType = {
            pattern = 'lua',
            callback = function()
                vim.bo.keywordprg = ':help'
            end,
        },
    })
end
