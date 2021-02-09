--NOTE: packages are in the runtimepath, this file is only loaded for updates.

vim.cmd 'packadd paq-nvim' -- Only needed once

require('plenary.reload').reload_module('paq-nvim') -- Refresh list on file reload

local Pq = require 'paq-nvim'
local paq = Pq.paq

paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-treesitter/nvim-treesitter'

paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'

paq 'rust-lang/rust.vim'
paq 'JuliaEditorSupport/julia-vim'
--paq 'kylelaker/riscv.vim'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'

paq 'ayu-theme/ayu-vim'
paq 'rktjmp/lush.nvim'
paq{'norcalli/nvim-colorizer.lua', opt=true}

paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

Pq.install()
Pq.update()
Pq.clean()
