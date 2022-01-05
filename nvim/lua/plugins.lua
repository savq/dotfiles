return {
    -- { 'savq/paq-nvim', pin=true },
    -- { 'savq/melange', pin=true },

    -- Tree-sitter
    -- { 'nvim-treesitter/nvim-treesitter', run = function() cmd 'TSUpdate' end },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    -- LSP & Auto-completion
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',

    -- Language plugins
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',

    -- Markup
    'lervag/VimTeX',
    'lervag/wiki.vim',
    'gabrielelana/vim-markdown',
    { 'mattn/emmet-vim', opt = true },

    -- Git
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',

    -- Misc
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'tpope/vim-commentary',
    'rktjmp/lush.nvim',
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
}
