local PKGS = {
    -- { 'savq/paq-nvim', pin = true },
    -- { 'savq/melange-nvim', pin = true },
    'neovim/nvim-lspconfig',
    { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',

    'lervag/wiki.vim',
    'nvim-mini/mini.completion',
    'nvim-mini/mini.diff',
    'nvim-mini/mini.pick',
    'nvim-mini/mini.trailspace',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    { 'mattn/emmet-vim', opt = true },
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
}

function _paq_bootstrap ()
    -- NOTE: Makefile handles paq installation
    vim.cmd 'packadd paq-nvim'
    vim.cmd 'autocmd User PaqDoneInstall quit'
    require 'paq'(PKGS):install()
end

local function sync_all()
    package.loaded.paq = nil
    require 'paq'(PKGS):sync()
end

vim.keymap.set('n', '<leader>pq', sync_all)

vim.keymap.set('n', '<leader>pg', function() vim.cmd.edit(vim.fn.stdpath 'config' .. '/after/plugin/paq.lua') end)
