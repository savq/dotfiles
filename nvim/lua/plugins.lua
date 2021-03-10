--NOTE: Packages are in the runtimepath, this file is only loaded for updates.

vim.cmd 'packadd paq-nvim'       -- Only needed once
package.loaded['paq-nvim'] = nil -- refresh package list
local Pq = require('paq-nvim')
local paq = Pq.paq

--[[ under development, use local
--paq{'savq/paq-nvim', opt=true}
--paq 'savq/melange'
--paq 'Olical/conjure'
--]]

paq 'neovim/nvim-lspconfig'
--paq 'nvim-treesitter/nvim-treesitter'
paq{'theHamsta/nvim-treesitter', branch='lockfile'} -- branch with update parsers
paq 'nvim-treesitter/playground'

paq 'hrsh7th/nvim-compe'

paq 'JuliaEditorSupport/julia-vim'
paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'
paq 'Olical/aniseed'

paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim' --uses popup & plenary

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'gabrielelana/vim-markdown'
paq 'mattn/emmet-vim'

paq 'rktjmp/lush.nvim'
paq{'norcalli/nvim-colorizer.lua', opt=true}
paq{'cocopon/inspecthi.vim', opt=true}

paq{'junegunn/vim-easy-align', opt=true}
paq{'mechatroner/rainbow_csv', opt=true}

Pq.install()
Pq.update()
Pq.clean()