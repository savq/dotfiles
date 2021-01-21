--NOTE: packages are in the runtimepath, this file is only loaded for updates.

vim.cmd 'packadd paq-nvim' -- Only needed once

-- Refresh list of packages every time this file is loaded
require('plenary.reload').reload_module('paq-nvim')

local Paq = require 'paq-nvim'
local paq = Paq.paq

paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-treesitter/nvim-treesitter'

paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'

paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'
paq 'JuliaEditorSupport/julia-vim'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'ayu-theme/ayu-vim'
paq 'rktjmp/lush.nvim'
paq{'norcalli/nvim-colorizer.lua', opt=true}

paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

--Paq.install()
Paq.update()
--Paq.clean()
