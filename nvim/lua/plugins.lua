local PKGS = {
    -- { 'savq/paq-nvim', pin = true },
    -- { 'savq/melange-nvim', pin = true },

    -- Tree-sitter
    -- { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-textobjects',

    -- Completion, LSP & Language plugins
    'echasnovski/mini.completion',
    'neovim/nvim-lspconfig',
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',

    -- Markup
    'lervag/wiki.vim',
    'rhysd/vim-gfm-syntax',
    { 'mattn/emmet-vim', opt = true },

    -- Git
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',

    -- Misc
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'echasnovski/mini.trailspace',
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
}

return {
    bootstrap = function()
        -- NOTE: Makefile handles paq installation
        vim.cmd 'packadd paq-nvim'
        vim.cmd 'autocmd User PaqDoneInstall quit'
        require 'paq'(PKGS):install()
    end,

    sync_all = function()
        -- package.loaded.paq = nil -- For development only
        require 'paq'(PKGS):sync()
    end,
}
