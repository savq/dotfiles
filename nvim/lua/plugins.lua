local PKGS = {
    -- { 'savq/paq-nvim', pin = true },
    -- { 'savq/melange-nvim', pin = true },

    -- Tree-sitter
    -- { 'nvim-treesitter/nvim-treesitter', run = function() cmd 'TSUpdate' end },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    -- Completion, LSP & Language plugins
    'echasnovski/mini.completion',
    'neovim/nvim-lspconfig',
    'rust-lang/rust.vim',
    'JuliaEditorSupport/julia-vim',

    -- Markup
    'lervag/VimTeX',
    'lervag/wiki.vim',
    'rhysd/vim-gfm-syntax',
    { 'mattn/emmet-vim', opt = true },

    -- Git
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',

    -- Misc
    'tpope/vim-commentary',
    'tpope/vim-surround',
    { 'norcalli/nvim-colorizer.lua', as = 'colorizer', opt = true },
    { 'junegunn/vim-easy-align', as = 'easy-align', opt = true },
    { 'mechatroner/rainbow_csv', opt = true },
}

local function clone_paq()
    local path = vim.fn.stdpath 'data' .. '/site/pack/paqs/start/paq-nvim'
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.system {
            'git',
            'clone',
            '--depth=1',
            'https://github.com/savq/paq-nvim.git',
            path,
        }
    end
end

local function bootstrap()
    clone_paq()

    -- Load Paq
    vim.cmd 'packadd paq-nvim'
    local paq = require 'paq'

    -- Exit nvim after installing plugins
    vim.cmd 'autocmd User PaqDoneInstall quit'

    -- Read and install packages
    paq(PKGS):install()
end

local function sync_all()
    require 'paq'(PKGS):sync()
end

return { bootstrap = bootstrap, sync_all = sync_all }
