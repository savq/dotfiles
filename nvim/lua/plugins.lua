return {
-- {"savq/paq-nvim", branch="dev", pin=true};

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


--- Colorschemes
{"savq/melange", branch="dev", pin=true};
"rktjmp/lush.nvim";
-- "mhartington/oceanic-next";
-- "folke/tokyonight.nvim";
-- "ayu-theme/ayu-vim"
-- "sainnhe/everforest";
-- "gruvbox-community/gruvbox";

--- Misc
"tpope/vim-commentary";
{"norcalli/nvim-colorizer.lua", as="colorizer", opt=true};
{"junegunn/vim-easy-align", as="easy-align", opt=true};
{"mechatroner/rainbow_csv", opt=true};
}
