local pkg = require 'savq.pkg' {
    --'savq/melange';  --dev

    ---- LSP & language support
    'neovim/nvim-lspconfig';
    'hrsh7th/nvim-compe';
    'rust-lang/rust.vim';
    'JuliaEditorSupport/julia-vim';

    ---- Tree-sitter
    'nvim-treesitter/nvim-treesitter';
    'nvim-treesitter/playground';
    --'nvim-treesitter/nvim-treesitter-textobjects'; --dev

    ---- Markup & Prose
    'lervag/vimtex';
    'lervag/wiki.vim';
    'gabrielelana/vim-markdown';
    'mattn/emmet-vim';

    ---- Telescope
    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    ---- Misc
    --'rktjmp/lush.nvim'; --dev
    {'norcalli/nvim-colorizer.lua', opt=true};
    {'cocopon/inspecthi.vim', opt=true};
    {'junegunn/vim-easy-align', opt=true};
    {'mechatroner/rainbow_csv', opt=true};
}

--pkg.install()
pkg.update()
--pkg.clean()
