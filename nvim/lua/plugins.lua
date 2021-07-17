return {
-- {"savq/paq-nvim", branch="dev", pin=true};
-- {"savq/melange", branch="rewrite", pin=true};
"mhartington/oceanic-next";
"glepnir/zephyr-nvim";
"folke/tokyonight.nvim";
"morhetz/gruvbox";

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
