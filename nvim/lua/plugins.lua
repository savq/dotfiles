vim.cmd 'packadd paq-nvim'
local Paq = require'paq-nvim'
local paq = Paq.paq
paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-treesitter/nvim-treesitter'

paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'
paq 'JuliaEditorSupport/julia-vim'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
--paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'ayu-theme/ayu-vim'
--paq 'itchyny/lightline.vim'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors
paq 'rktjmp/lush.nvim'
paq 'savq/lush-template' --Prevent template from being deleted

paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

--Paq.install()
Paq.update()
Paq.clean()
