-- Useful aliases
local g = vim.g
local cmd = vim.cmd
function noremapsl(str) vim.cmd('noremap <silent><leader>' .. str) end

--- PLUGINS
cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'
paq 'tjdevries/lsp_extensions.nvim'

paq 'JuliaEditorSupport/julia-vim'
paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'ayu-theme/ayu-vim'
paq 'itchyny/lightline.vim'
paq 'junegunn/vim-easy-align'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors


-- Theme: Ayu mirage
vim.o.termguicolors = true
g.ayucolor = 'mirage'
cmd 'colorscheme ayu'
cmd 'hi Comment gui=italic'


-- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
cmd 'noremap <expr> <F7> LaTeXtoUnicode#Toggle()'
noremapsl 'j :!julia %<cr>'


-- Vimtex
g.tex_flavor = 'lualatex' --'xelatex'
g.vimtex_quickfix_mode = 2 -- Open _only_ if there are errors


-- Wiki.vim
g.wiki_root = '~/Documents/notes/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinkNames'
--TODO write CreateLinkNames() in Lua and pass it to vimscript


-- Pandoc markdown
cmd 'let pandoc#spell#enabled = 0'
cmd 'let pandoc#syntax#conceal#use = 0'
cmd 'let g:pandoc#syntax#conceal#urls = 1'
cmd 'au BufNewFile,BufRead *.md set nowrap'


-- Netrw
g.netrw_banner = 0     --no banner
g.netrw_liststyle = 3  --tree style listing
g.netrw_dirhistmax = 0 --no netrw history


-- SL MAPPINGS

noremapsl 't :sp\\|:te<cr>'           -- Open terminal
noremapsl 'rc :e ~/.config/nvim<cr>'  -- Open config directory
-- Print date & time
noremapsl('d "= "' .. vim.fn.strftime('%Y-%m-%d %T') .. '"<cr>p')

-- Spelling
noremapsl 'z b1z=e'                -- Correct previous word
noremapsl 'x 1z=1'                 -- Correct current word
noremapsl 's :lua CycleLang()<cr>' -- Change spelling language

do -- Lua version of this solution: stackoverflow.com/a/12006781
    local spl = {i = 1, langs = {'', 'en', 'es', 'de'}}
    function CycleLang()
        spl.i = (spl.i % #spl.langs) + 1      --update index
        vim.bo.spelllang = spl.langs[spl.i]   --change spelllang
        vim.wo.spell = spl.langs[spl.i] ~= '' --if empty then nospell
    end
end

