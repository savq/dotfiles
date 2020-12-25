--  NOTE: Paq doesn't need to be loaded at startup,
--  packages are already in `runtimepath`.
--  This file is only loaded when needed, like so:
--    :lua require 'packages'

vim.cmd 'packadd paq-nvim'
local Paq = require 'paq-nvim'
local paq = Paq.paq
require('plenary.reload').reload_module 'paq-nvim' -- Refresh list of packages everytime file is loaded

paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-treesitter/nvim-treesitter'

paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'
paq 'JuliaEditorSupport/julia-vim'
paq 'olical/conjure'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'ayu-theme/ayu-vim'
paq 'itchyny/lightline.vim'
paq{'norcalli/nvim-colorizer.lua', opt=true}
paq 'rktjmp/lush.nvim'

paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

Paq.install()
Paq.update()
--Paq.clean()
