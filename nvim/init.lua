setmetatable(_G, {__index=vim})
cmd "source ~/.vimrc"

savq = {} -- Namespace for functions in mappings, autocmds, etc

local function map(lhs, rhs, mode, expr)    -- wait for lua keymaps: neovim/neovim#13823
    mode = mode or "n"
    if mode == "n" then rhs = "<cmd>" .. rhs .. "<cr>" end
    api.nvim_set_keymap(mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
end

local function au(s) cmd("au!" .. s) end


map("<leader>pq", "lua savq.plugins()")
function savq.plugins()
  require "paq" {
    --{"savq/paq-nvim", branch="dev"};
    --{"savq/melange", branch="dev"};

    --- Tree-sitter
    {"savq/nvim-treesitter", run=function() cmd "TSUpdate" end}; -- dev
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
  :install()
  :update()
  :clean()
end

do ---- General
    opt.inccommand = "nosplit"
    au "TextYankPost * lua highlight.on_yank()"
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

do  --- Tree-sitter
    ---- Local Julia parser
    -- require("nvim-treesitter.parsers").get_parser_configs().julia = {
    --     install_info = {
    --         url = "~/.projects/tree-sitter-julia/",
    --         files = { "src/parser.c", "src/scanner.c" },
    --     }
    -- }

    require("nvim-treesitter.configs").setup {
        ensure_installed = {"c", "javascript", "julia", "lua", "python", "rust"; "html", "query", "toml"},
        highlight = {enable = true};
        indent = {enable = false};
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
end


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

    -- Unicode completion (julia.vim)
    g.latex_to_unicode_tab = 0
    g.latex_to_unicode_auto = 1
    g.latex_to_unicode_file_types = {"julia", "javascript"}
end


do ---- LSP
    local conf = require("lspconfig")

    conf.clangd.setup{}        --llvm
    --conf.julials.setup{}       --Pkg.jl
    --conf.texlab.setup{}        --brew
    conf.rust_analyzer.setup{} --rustup

    --- Complete with tab
    map("<Tab>",   "pumvisible() ? '<C-n>' : '<Tab>'", "i", true)
    map("<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", "i", true)

    --- GOTO Mappings
    map("gd", "lua lsp.buf.definition()")
    map("gr", "lua lsp.buf.references()")
    map("gs", "lua lsp.buf.document_symbol()")
    map("ga", "lua lsp.buf.code_action()")

    --- diagnostics navegation mappings
    map("d,", "lua lsp.diagnostic.goto_prev()")
    map("d;", "lua lsp.diagnostic.goto_next()")

    --- auto-commands
    au "BufWritePre *.rs,*.c lua lsp.buf.formatting_sync()"
    au "CursorHold * lua lsp.diagnostic.show_line_diagnostics()"
    --au "Filetype julia setlocal omnifunc=v:lua.lsp.omnifunc"

    --- Disable virtual text
    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            underline = true,
            signs = true,
        }
    )
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
    cmd("nnoremap <leader>c 1z=1") -- fix current word
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
            prompt_position = "top",
            sorting_strategy = "ascending",
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    }
    map("<leader>ff", "Telescope find_files")
    map("<leader>fg", "Telescope live_grep")
    map("<leader>fb", "Telescope buffers")
    map("<leader>fh", "Telescope help_tags")
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

