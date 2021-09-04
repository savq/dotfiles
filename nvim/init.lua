setmetatable(_G, {__index=vim})
cmd "runtime vimrc"
local keymap = require("keymap").keymap

do -- Tree-sitter
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    require("nvim-treesitter.configs").setup {
        -- ensure_installed = {"c", "javascript", "julia", "lua", "python", "rust", "html", "query", "toml"};
        highlight = {enable = true};
        indent = {enable = false};
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ac = "@call.outer",
                    af = "@function.outer",
                    ak = "@conditional.outer",
                    at = "@class.outer",
                }
            }
        }
    }
end


do -- LSP
    local function on_attach(client, bufnr)
        keymap({
            g = {
                d = vim.lsp.buf.definition,
                r = vim.lsp.buf.references,
                s = vim.lsp.buf.document_symbol,
            },
            ["[d"] = vim.lsp.diagnostic.goto_prev,
            ["]d"] = vim.lsp.diagnostic.goto_next,
            ["<leader>"] = {
                ca = vim.lsp.buf.code_action,
                rn = vim.lsp.buf.rename,
                ld = vim.lsp.diagnostic.show_line_diagnostics,
            }
        }, {buffer=0})
        cmd "au BufWritePre *.rs,*.c lua vim.lsp.buf.formatting_sync()"
        cmd "au CursorHold,CursorHoldI *.rs,*.c lua vim.lsp.diagnostic.show_line_diagnostics{focusable=false}"
        opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {underline=false, update_in_insert=false, virtual_text=false}
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
    require("compe").setup {
        min_length = 2;
        preselect = "disable";
        source = {
            path = true,
            tags = true,
            omni = {filetypes = {"tex"}},
            spell = {filetypes = {"markdown", "tex"}},
            buffer = true,
            nvim_lsp = true,
        }
    }
    keymap({
        ["<Tab>"] = "pumvisible() ? '<C-n>' : '<Tab>'",
        ["<S-Tab>"] = "pumvisible() ? '<C-p>' : '<S-Tab>'",
    }, {mode="i", opts={expr=true}})
end


do -- Julia.vim
    g.latex_to_unicode_tab = 0
    g.latex_to_unicode_auto = 1
    g.latex_to_unicode_file_types = {"julia", "javascript", "markdown"}
end


do -- Telescope
    require("telescope").setup {
        defaults = {
            layout_config = {prompt_position = "top"},
            sorting_strategy = "ascending",
        }
    }
    local builtin = require "telescope.builtin"
    keymap {
        ["<leader>f"] = {
            f = builtin.find_files,
            b = builtin.buffers,
            h = builtin.help_tags,
            g = builtin.live_grep,
            r = builtin.registers,
        }
    }
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
    local i = 1
    local langs = {"", "en", "es", "de"}
    keymap {
        ["<leader>sl"] = function()
            i = (i % #langs) + 1
            opt.spell = langs[i] ~= ""
            opt.spelllang = langs[i]
        end,
        ["<c-s>"] = "mmb1z=`m", -- TODO: How to combine these two mappings?
    }
    keymap ({["<c-s>"] = "<esc>mmb1z=`ma"}, {mode="i"})
end


do -- Zen mode
    local active = false
    zen = {
        toggle = function()
            opt.list         = active
            opt.number       = active
            opt.cursorline   = active
            opt.cursorcolumn = active
            opt.colorcolumn  = active and "81" or ""
            opt.conceallevel = active and 0 or 2
            active = not active
        end
    }
    keymap {["<leader>z"] = zen.toggle}
end


do -- Appearance
    opt.statusline = "%2{mode()} | %f %m %r %= %{&spelllang} %y %8(%l,%c%) %8p%%"
    opt.termguicolors = true
    cmd "colorscheme melange"
    cmd "au TextYankPost * lua vim.highlight.on_yank()"
end


keymap {["<leader>pq"] = function()
  require "paq" {
    -- {"savq/paq-nvim", branch="dev", pin=true};

    ---- Tree-sitter
    {"nvim-treesitter/nvim-treesitter", run=function() cmd "TSUpdate" end, pin=true};
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
    "nvim-telescope/telescope.nvim"; "nvim-lua/plenary.nvim";
    {"norcalli/nvim-colorizer.lua", as="colorizer", opt=true};
    {"junegunn/vim-easy-align", as="easy-align", opt=true};
    {"mechatroner/rainbow_csv", opt=true};
  }:setup({verbose=false}):sync()
end}

-- For debugging
function dump(...) print(unpack(tbl_map(inspect, {...}))) return ... end

