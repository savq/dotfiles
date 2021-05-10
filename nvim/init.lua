local cmd, g = vim.cmd, vim.g
cmd 'source ~/.vimrc'

local function map(lhs, rhs, mode, expr)-- Wait for lua keymaps: neovim/neovim#13823
    mode = mode or 'n'
    if mode == 'n' then rhs = '<cmd>' .. rhs .. '<cr>' end
    vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
end


---- Plugins
map('<leader>pq', 'lua plugins()')
function plugins()
    require 'pkg' {
    --'savq/melange';  --dev

    ---- LSP & language support
    'neovim/nvim-lspconfig';
    'hrsh7th/nvim-compe';
    'rust-lang/rust.vim';
    'JuliaEditorSupport/julia-vim';

    ---- Tree-sitter
    'nvim-treesitter/nvim-treesitter';
    'nvim-treesitter/playground';
    'nvim-treesitter/nvim-treesitter-textobjects';

    ---- Markup & Prose
    'lervag/vimtex';
    'lervag/wiki.vim';
    'gabrielelana/vim-markdown';
    {'mattn/emmet-vim', opt=true};

    ---- Telescope
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    ---- Misc
    {'rktjmp/lush.nvim', opt=true};
    {'norcalli/nvim-colorizer.lua', opt=true};
    {'cocopon/inspecthi.vim', opt=true};
    {'junegunn/vim-easy-align', opt=true};
    {'mechatroner/rainbow_csv', opt=true};
    }:install()
     :update()
     :clean()
end



do ---- General settings
    vim.o.inccommand = 'nosplit'
    cmd [[au TextYankPost * lua vim.highlight.on_yank()]]

    --- mappings
    map('<leader>rc', 'e ~/.config/nvim')             -- open config directory
    map('<leader>l',  'luafile %')
    map('<leader>t',  'sp<cr><cmd>term')              -- open terminal
    map('<Esc>',      '<C-\\><C-n>', 't')             -- terminal escape
end


do ---- Appearance
    vim.o.termguicolors = true
    local h = tonumber(os.date('%H'))
    if 9 < h and h < 17 then vim.o.background = 'light' end
    cmd 'colorscheme melange'

    vim.o.statusline = table.concat({
        '  ',
        'f',            -- relative path
        'm',            -- modified flag
        'r',
        '=',
        '{&spelllang}',
        'y',            -- filetype
        '8(%l,%c%)',    -- line, column
        '8p%% ',        -- file percentage
    }, ' %')
end


--- Tree-sitter
require('nvim-treesitter.configs').setup {
    --ensure_installed = {'c', 'javascript', 'julia', 'lua', 'python', 'rust'},
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['ar'] = '@parameter.outer',
                ['at'] = '@class.outer',
                ['ac'] = '@call.outer',
                ['al'] = '@loop.outer',
                ['ak'] = '@conditional.outer',
            },
        },
    },
}


--- Auto-completion
require('compe').setup {
    min_length = 3,
    preselect = 'disable',
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
        spell = true,
        tags = true,
        omni = true,
    },
}


do ---- LSP
    local conf = require('lspconfig')
    conf.clangd.setup{}        --llvm
    --conf.julials.setup{}       --Pkg.jl
    conf.texlab.setup{}        --brew
    conf.rust_analyzer.setup{} --rustup

    --- Complete with tab
    map('<Tab>',   [[pumvisible() ? '\<C-n>' : '\<Tab>']], 'i', true)
    map('<S-Tab>', [[pumvisible() ? '\<C-p>' : '\<S-Tab>']], 'i', true)
    g.latex_to_unicode_tab = 0 -- julia.vim messes up completion
    g.latex_to_unicode_auto = 1

    --- GOTO Mappings
    map('gd', 'lua vim.lsp.buf.definition()')
    map('gr', 'lua vim.lsp.buf.references()')
    map('gs', 'lua vim.lsp.buf.document_symbol()')
    map('ga', 'lua vim.lsp.buf.code_action()')

    --- diagnostics navegation mappings
    map('d,', 'lua vim.lsp.diagnostic.goto_prev()')
    map('d;', 'lua vim.lsp.diagnostic.goto_next()')

    --- auto-commands
    cmd[[au BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync()]]
    cmd[[au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
    --cmd[[au Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc]]

    --- Disable virtual text
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            underline = true,
            signs = true,
        }
    )
end


do ---- Telescope
    require('telescope').setup {
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    }
    map('<leader>ff', 'Telescope find_files')
    map('<leader>fg', 'Telescope live_grep')
    map('<leader>fb', 'Telescope buffers')
    map('<leader>fh', 'Telescope help_tags')
end


do ---- Markup & Prose
    g.markdown_enable_conceal = 1
    g.user_emmet_leader_key = '<C-e>'

    --- wiki.vim
    g.wiki_root = '~/Documents/wiki'
    g.wiki_filetypes = {'md'}
    g.wiki_link_target_type = 'md'
    g.wiki_map_link_create = 'CreateLinks' -- cannot use anonymous functions
    cmd [[
    function! CreateLinks(text) abort
        return substitute(tolower(a:text), '\s\+', '-', 'g')
    endfunction
    ]]

    --- spelling
    cmd('nnoremap <leader>c 1z=1')            -- fix current word
    map('<leader>s', 'lua cycle_spelllang()') -- change spelling language
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cycle_spelllang()
        i = (i % #langs) + 1
        vim.bo.spelllang = langs[i]
        vim.wo.spell = (langs[i] ~= '')
    end
end


do ---- Utils
    --- better print
    function dump(...)
        local objects = vim.tbl_map(vim.inspect, {...})
        print(unpack(objects))
    end

    --- zen mode
    map('<leader>z', 'lua toggle_zen()')
    function toggle_zen()
        vim.wo.list         = not vim.wo.list
        vim.wo.number       = not vim.wo.number
        vim.wo.cursorline   = not vim.wo.cursorline
        vim.wo.cursorcolumn = not vim.wo.cursorcolumn
        vim.wo.conceallevel = vim.wo.conceallevel == 1 and 0 or 1
    end
end

