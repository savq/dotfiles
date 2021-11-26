setmetatable(_G, { __index = vim })
cmd 'runtime vimrc'
local utils = require 'utils'
local augroup = utils.augroup
local command = utils.command
local keymap = utils.keymap

do -- Tree-sitter
    opt.foldmethod = 'expr'
    opt.foldexpr = 'nvim_treesitter#foldexpr()'
    require('nvim-treesitter.configs').setup {
        -- ensure_installed = { 'c', 'javascript', 'julia', 'lua', 'python', 'rust', 'html', 'query', 'toml' },
        highlight = { enable = true },
        indent = { enable = false },
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

do -- LSP
    command('LspDef', lsp.buf.definition)
    command('LspRefs', lsp.buf.references)
    command('LspDocSymbols', lsp.buf.document_symbol)
    command('LspCodeAction', lsp.buf.code_action)
    command('LspRename', lsp.buf.rename)
    command('LspLineDiagnostics', vim.diagnostic.show_line_diagnostics)
    -- command('LspGotoPrev', diagnostic.goto_prev) -- different on stable/nightly
    -- command('LspGotoNext', diagnostic.goto_next)

    local function on_attach(client, bufnr)
        opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
        augroup.Lsp = {
            { 'BufWritePre', '*.rs,*.c', vim.lsp.buf.formatting_sync },
            { 'CursorHold,CursorHoldI', '*.rs,*.c', vim.lsp.diagnostic.show_line_diagnostics },
        }
    end

    lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        { underline = false, update_in_insert = false, virtual_text = false } -- No virtual text.
    )

    local lspconfig = require 'lspconfig'
    for _, ls in ipairs { 'clangd', 'rust_analyzer' } do
        lspconfig[ls].setup {
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
        }
    end
end

do -- Auto-completion
    require('compe').setup {
        min_length = 2,
        preselect = 'disable',
        source = {
            path = true,
            tags = true,
            omni = { filetypes = { 'tex' } },
            spell = { filetypes = { 'markdown', 'tex' } },
            buffer = true,
            nvim_lsp = true,
        },
    }
    keymap({ mode = 'i', opts = { expr = true } }, {
        ['<Tab>'] = 'pumvisible() ? \'<C-n>\' : \'<Tab>\'',
        ['<S-Tab>'] = 'pumvisible() ? \'<C-p>\' : \'<S-Tab>\'',
    })
end

do -- Julia.vim
    g.latex_to_unicode_tab = 0
    g.latex_to_unicode_auto = 1
    g.latex_to_unicode_file_types = { 'julia', 'javascript', 'markdown' }
end

do -- Telescope
    require('telescope').setup {
        defaults = {
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
        },
    }
    local builtin = require 'telescope.builtin'
    keymap {
        ['<leader>ff'] = builtin.find_files,
        ['<leader>fb'] = builtin.buffers,
        ['<leader>fh'] = builtin.help_tags,
        ['<leader>fg'] = builtin.live_grep,
        ['<leader>fr'] = builtin.registers,
    }
end

do -- Markup
    g.markdown_enable_conceal = true
    g.markdown_enable_insert_mode_mappings = false
    g.user_emmet_leader_key = '<C-e>'

    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_quickfix_mode = 2

    g.wiki_filetypes = { 'md' }
    g.wiki_link_target_type = 'md'
    g.wiki_map_link_create = function(txt)
        return txt:lower():gsub('%s+', '-')
    end
    g.wiki_root = '~/Documents/wiki'
end

do -- Spelling
    local i = 1
    local langs = { '', 'en', 'es', 'de' }
    keymap {
        ['<leader>sl'] = function()
            i = (i % #langs) + 1
            opt.spell = langs[i] ~= ''
            opt.spelllang = langs[i]
        end,
    }
    keymap({ mode = 'ni' }, {
        ['<c-s>'] = function()
            vim.fn.execute 'normal! mmb1z=`m'
        end,
    })
end

do -- Zen mode
    local active = false
    zen = {
        toggle = function()
            opt.list = active
            opt.number = active
            opt.cursorline = active
            opt.cursorcolumn = active
            opt.colorcolumn = active and '81' or ''
            opt.conceallevel = active and 0 or 2
            active = not active
        end,
    }
    keymap { ['<leader>z'] = zen.toggle }
end

do -- Appearance
    opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y %8(%l,%c%) %8p%%'
    opt.termguicolors = true
    cmd 'colorscheme melange'
    augroup.Highlights = {
        { 'TextYankPost', '*',  vim.highlight.on_yank },
        { 'ColorScheme', '*',   'hi! markdownLinkText gui=NONE' },
        { 'ColorScheme', '*',   'hi! link markdownRule PreProc' },
        { 'ColorScheme', '*',   'hi! link markdownXmlComment Comment' },
        { 'FileType', 'tex',    'hi! link Conceal Normal' }
    }
end

do -- Inspection
    function show(...)
        print(unpack(vim.tbl_map(vim.inspect, { ... })))
        return ...
    end
    command('L', ':lua _=show(<args>)', { nargs = '*', complete = 'lua' })
end

-- stylua: ignore
keymap {['<leader>pq'] = function()
  package.loaded.paq = nil
  local paq = require 'paq' {
    -- { 'savq/paq-nvim', pin=true },
    -- { 'savq/melange', pin=true },
    'rktjmp/lush.nvim',

    -- Tree-sitter
    -- { 'nvim-treesitter/nvim-treesitter', run = function() cmd 'TSUpdate' end },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    -- LSP & language support
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-compe',
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',
    'LnL7/vim-nix',

    -- Markup
    'lervag/VimTeX',
    'lervag/wiki.vim',
    'gabrielelana/vim-markdown',
    { 'mattn/emmet-vim', opt = true },

    -- Misc
    'tpope/vim-fugitive',
    { 'tpope/vim-commentary', run=function() print 'running hook...' end },
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
  }:sync()
end}
