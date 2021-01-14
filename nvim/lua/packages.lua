--NOTE: packages are in the runtimepath, this file is only loaded for updates.

vim.cmd 'packadd paq-nvim'
local Paq = require 'paq-nvim'
local paq = Paq.paq

-- Refresh list of packages everytime file is loaded
require('plenary.reload').reload_module 'paq-nvim'

paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-treesitter/nvim-treesitter'

paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'
paq 'JuliaEditorSupport/julia-vim'
paq 'wlangstroth/vim-racket'
paq 'Olical/conjure'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
--paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'ayu-theme/ayu-vim'
paq 'rktjmp/lush.nvim'
paq{'norcalli/nvim-colorizer.lua', opt=true}

paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

--Paq.install()
Paq.update()
--Paq.clean()
