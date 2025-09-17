local PKGS = {
    -- { 'savq/paq-nvim', pin = true },
    -- { 'savq/melange-nvim', pin = true },
    'neovim/nvim-lspconfig',
    { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',

    'echasnovski/mini.completion',
    'echasnovski/mini.diff',
    'echasnovski/mini.pick',
    'echasnovski/mini.trailspace',
    'lervag/wiki.vim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    { 'mattn/emmet-vim', opt = true },
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
