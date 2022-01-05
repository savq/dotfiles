return {
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
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'lewis6991/gitsigns.nvim',
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
}
