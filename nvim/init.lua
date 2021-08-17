setmetatable(_G, {__index=vim})
cmd "runtime vimrc"

local utils = require("utils")
local map, bufmap, import = utils.map, utils.bufmap, utils.import

savq = {} -- Namespace for functions in mappings, autocmds, etc

do -- Tree-sitter
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    import "nvim-treesitter.configs" {
        ensure_installed = {"c", "javascript", "julia", "lua", "python", "rust", "html", "query", "toml"};
        highlight = {enable = true};
        indent = {enable = false};
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ac = "@call.outer",
                    af = "@function.outer",
                    at = "@class.outer"
                },
            },
        };
    }
end


do -- LSP
    local function on_attach(client, bufnr)
        bufmap("gd", "lua vim.lsp.buf.definition()")
        bufmap("gr", "lua vim.lsp.buf.references()")
        bufmap("gs", "lua vim.lsp.buf.document_symbol()")

        bufmap("dn", "lua vim.lsp.diagnostic.goto_prev()")
        bufmap("dN", "lua vim.lsp.diagnostic.goto_next()")

        bufmap("<leader>rn", "lua vim.lsp.buf.rename()")
        bufmap("<leader>ca", "lua vim.lsp.buf.code_action()")
        bufmap("<leader>dl", "lua vim.lsp.diagnostic.show_line_diagnostics()")

        cmd "au BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync()"
        opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    --- disable virtual text
    lsp.handlers["textDocument.publishDiagnostics"] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {virtual_text=false, signs=false, update_in_insert=false}
    )

    local lspconfig = require("lspconfig")
    for _,ls in ipairs{"clangd", "rust_analyzer"} do
        lspconfig[ls].setup {
            on_attach = on_attach,
            flags = {debounce_text_changes = 150},
        }
    end
end


do -- Auto-completion
    import "compe" {
        min_length = 2;
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
    map("<Tab>",   "pumvisible() ? '<C-n>' : '<Tab>'", "i", true)
    map("<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", "i", true)
end


do -- Julia.vim
    g.latex_to_unicode_tab = 0
    g.latex_to_unicode_auto = 1
    g.latex_to_unicode_file_types = {"julia", "javascript"}
end


do -- Telescope
    import "telescope" {
        defaults = {
            layout_config = {prompt_position = "top"},
            sorting_strategy = "ascending",
        },
    }
    map("<leader>ff", "Telescope find_files")
    map("<leader>fg", "Telescope live_grep")
    map("<leader>fb", "Telescope buffers")
    map("<leader>fh", "Telescope help_tags")
end


do -- Markup
    g.user_emmet_leader_key = "<C-e>"
    g.vimtex_compiler_method = "tectonic"
    g.wiki_root = "~/Documents/wiki"
    g.wiki_filetypes = {"md"}
    g.wiki_link_target_type = "md"
    g.wiki_map_link_create = function(txt) return txt:lower():gsub("%s+", "-") end
end


do -- Spelling
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


do -- Zen mode
    map("<leader>z", "lua savq.toggle_zen()")
    local zen = false
    function savq.toggle_zen()
        opt.list         = zen
        opt.number       = zen
        opt.cursorline   = zen
        opt.cursorcolumn = zen
        opt.colorcolumn  = zen and "81" or ""
        opt.conceallevel = zen and 0 or 2
        zen = not zen
    end
end


do -- Appearance
    opt.statusline = "%2{mode()} | %f %m %r %= %{&spelllang} %y %8(%l,%c%) %8p%%"
    opt.termguicolors = true
    cmd "colorscheme melange"
    cmd "au TextYankPost * lua vim.highlight.on_yank()"
end


map("<leader>pq", "lua savq.plugins()")
function savq.plugins()
  require "paq" {
    -- {"savq/paq-nvim", branch="dev", pin=true};

    ---- Tree-sitter
    -- {"nvim-treesitter/nvim-treesitter", run=function() cmd "TSUpdate" end, pin=true};
    "nvim-treesitter/nvim-treesitter-textobjects";
    "nvim-treesitter/playground";

    ---- LSP & language support
    "neovim/nvim-lspconfig";
    "hrsh7th/nvim-compe";
    "rust-lang/rust.vim";
    "JuliaEditorSupport/julia-vim";

    ---- Markup
    "lervag/VimTeX";
    "lervag/wiki.vim";
    "rhysd/vim-gfm-syntax";
    {"mattn/emmet-vim", opt=true};

    ---- Colorschemes
    {"savq/melange", branch="dev", pin=true};
    "rktjmp/lush.nvim";

    ---- Misc
    "tpope/vim-commentary";
    "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim";
    {"norcalli/nvim-colorizer.lua", as="colorizer", opt=true};
    {"junegunn/vim-easy-align", as="easy-align", opt=true};
    {"mechatroner/rainbow_csv", opt=true};
  }:setup({verbose=false}):sync()
end

