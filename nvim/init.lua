setmetatable(_G, {__index=vim})
cmd "source ~/.vimrc"

savq = {} -- Namespace for functions in mappings, autocmds, etc

local function map(lhs, rhs, mode, expr)    -- wait for lua keymaps: neovim/neovim#13823
    mode = mode or "n"
    if mode == "n" then rhs = "<cmd>" .. rhs .. "<cr>" end
    api.nvim_set_keymap(mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
end

local function au(s) cmd("au!" .. s) end

require("paq"):setup{verbose=false} {
    -- {"savq/paq-nvim", branch="dev", pin=true};
    -- {"savq/melange", branch="rewrite", pin=true};

    --- Tree-sitter
    -- {"nvim-treesitter/nvim-treesitter", run=function() cmd "TSUpdate" end, pin=true};
    "nvim-treesitter/nvim-treesitter-textobjects";
    "nvim-treesitter/playground";

    --- LSP & language support
    "neovim/nvim-lspconfig";
    "hrsh7th/nvim-compe";
    "rust-lang/rust.vim";
    "JuliaEditorSupport/julia-vim";

    --- Markup & Prose
    "lervag/VimTeX";
    "lervag/wiki.vim";
    "gabrielelana/vim-markdown";
    {"mattn/emmet-vim", opt=true};

    --- Telescope
    "nvim-lua/popup.nvim";
    "nvim-lua/plenary.nvim";
    "nvim-telescope/telescope.nvim";

    --- Misc
    "tpope/vim-commentary";
    "rktjmp/lush.nvim";
    {"norcalli/nvim-colorizer.lua", as="colorizer", opt=true};
    {"junegunn/vim-easy-align", as="easy-align", opt=true};
    {"mechatroner/rainbow_csv", opt=true};
}


do ---- General
    opt.inccommand = "nosplit"
    au "TextYankPost * lua vim.highlight.on_yank()"
    map("<leader>rc", "e ~/.config/nvim/init.lua")
    map("<leader>ss", "source %")
end


do ---- Appearance
    opt.termguicolors = true
    local h = tonumber(os.date("%H"))
    if 9 <= h and h < 16 then opt.background = "light" end
    cmd "colorscheme melange"
    --require "lush" (require "melange") --dev

    opt.statusline = table.concat({
        "%2{mode()} | ",
        "f",            -- relative path
        "m",            -- modified flag
        "r",
        "=",
        "{&spelllang}",
        "y",            -- filetype
        "8(%l,%c%)",    -- line, column
        "8p%% ",        -- file percentage
    }, " %")
end


--- Tree-sitter
require("nvim-treesitter.configs").setup {
    ensure_installed = {"c", "javascript", "julia", "lua", "python", "rust"; "html", "query", "toml"},
    highlight = {enable = true};
    indent = {enable = true};
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ar"] = "@parameter.outer",
                ["at"] = "@class.outer",
                ["ac"] = "@call.outer",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.outer",
                ["ak"] = "@conditional.outer",
                ["ik"] = "@conditional.outer",
            },
        },
    };
}


do --- Auto-completion
    require("compe").setup {
        --min_length = 3;
        preselect = "disable";
        source = {
            path = true,
            tags = true,
            omni = {filetypes = {"tex"}},
            spell = {filetypes = {"markdown", "tex"}},
            buffer = true,
            nvim_lsp = true,
        };
    }

    --- Complete with tab
    map("<Tab>",   "pumvisible() ? '<C-n>' : '<Tab>'", "i", true)
    map("<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", "i", true)

    -- Unicode completion (julia.vim)
    g.latex_to_unicode_tab = 0
    g.latex_to_unicode_auto = 1
    g.latex_to_unicode_file_types = {"julia", "javascript"}
end


do ---- LSP
    local conf = require("lspconfig")
    local function on_attach(client, bufnr)
        --- GOTO Mappings
        map("gd", "lua vim.lsp.buf.definition()")
        map("gr", "lua vim.lsp.buf.references()")
        map("gs", "lua vim.lsp.buf.document_symbol()")

        --- Diagnostics navegation mappings
        map("dn", "lua vim.lsp.diagnostic.goto_prev()")
        map("dN", "lua vim.lsp.diagnostic.goto_next()")

        map("<space>rn", "lua vim.lsp.buf.rename()")
        map("<space>ca", "lua vim.lsp.buf.code_action()")
        -- map("<space>e",  "lua vim.lsp.diagnostic.show_line_diagnostics()")
        map("<C-k>",     "lua vim.lsp.buf.signature_help()")
        -- map("<space>f",  "lua vim.lsp.buf.formatting()")

        --- auto-commands
        au "BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync()"
        au "CursorHold *.rs,*.c lua vim.lsp.diagnostic.show_line_diagnostics()"

        opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    --- Disable virtual text
    lsp.handlers["textDocument.publishDiagnostics"] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            signs = false,
            update_in_insert = false,
        }
    )

    for _, lsp in ipairs {"clangd", "rust_analyzer"} do
        conf[lsp].setup {
            on_attach = on_attach,
            flags = {debounce_text_changes = 150}
        }
    end
end


do ---- Markup & Prose
    g.markdown_enable_conceal = 1
    g.user_emmet_leader_key = "<C-e>"

    --- wiki.vim
    g.wiki_root = "~/Documents/wiki"
    g.wiki_filetypes = {"md"}
    g.wiki_link_target_type = "md"
    g.wiki_map_link_create = "CreateLinks" -- cannot use anonymous functions
    cmd [[
    function! CreateLinks(text) abort
        return substitute(tolower(a:text), "\s\+", "-", "g")
    endfunction
    ]]

    --- spelling
    map("<leader>c", "1z=1", "") -- fix current word
    map("<leader>sl", "lua savq.cycle_spelllang()")
    local i = 1
    local langs = {"", "en", "es", "de"}
    function savq.cycle_spelllang()
        i = (i % #langs) + 1
        opt.spell = (langs[i] ~= "")
        opt.spelllang = langs[i]
    end
end


do ---- Telescope
    require("telescope").setup {
        defaults = {
            layout_config = {prompt_position = "top"},
            sorting_strategy = "ascending",
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    }
    map("<leader>tt", "Telescope find_files")
    map("<leader>tg", "Telescope live_grep")
    map("<leader>tb", "Telescope buffers")
    map("<leader>th", "Telescope help_tags")
end


do ---- Utils
    function _G.dump(...)
        print(unpack(tbl_map(inspect, {...})))
    end

    map("<leader>z", "lua savq.toggle_zen()")
    local zen = false
    function savq.toggle_zen()
        opt.list         = zen
        opt.number       = zen
        opt.cursorline   = zen
        opt.cursorcolumn = zen
        opt.colorcolumn  = zen and "80" or ""
        opt.conceallevel = zen and 0 or 2
        zen = not zen
    end
end

