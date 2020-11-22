-- Useful aliases
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo
local cmd = vim.cmd
local function map(str) vim.cmd('noremap <silent><leader>' .. str) end

cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'JuliaEditorSupport/julia-vim'
paq 'euclidianAce/BetterLua.vim'
paq 'rust-lang/rust.vim'
paq 'kylelaker/riscv.vim'

paq 'ayu-theme/ayu-vim'
paq 'itchyny/lightline.vim'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors
paq 'junegunn/vim-easy-align'
paq 'mechatroner/rainbow_csv'

-- Vimtex
g.tex_flavor = 'lualatex'


-- Wiki.vim
g.wiki_root = '~/Documents/wiki/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinkNames'
function createlinks(txt)
    return os.date('%Y%m%dT%H%M-') .. txt:lower():gsub('[%s.]+', '-')
end
cmd [[function! CreateLinkNames(txt) abort
        return v:lua.createlinks(a:txt)
      endfunction]]


-- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
g.latex_to_unicode_file_types = {'julia', 'lisp', 'pandoc'}
map 'j :!julia %<cr>'


-- Pandoc markdown
g['pandoc#spell#enabled'] = 0
g['pandoc#syntax#conceal#use'] = 1
g['pandoc#syntax#conceal#urls'] = 1
g['pandoc#folding#fdc'] = 0
cmd 'au BufNewFile,BufRead *.md set nowrap'


-- Theme: Ayu mirage
cmd 'colorscheme ayu'
cmd 'autocmd ColorScheme * hi Comment gui=italic'
g.ayucolor = 'mirage'
o.termguicolors = true


-- Lightline
g.lightline = {
    colorscheme = 'ayu_mirage',
    active = {
        right= {{'percent', 'lineinfo'},
                {'spell', 'filetype', 'fileencoding', 'fileformat'}}
    }
}


-- Spelling
map 'x b1z=e'                -- Correct previous word
map 'c 1z=1'                 -- Correct current word
map 's :lua cyclelang()<cr>' -- Change spelling language
do -- Lua version of this solution: stackoverflow.com/a/12006781
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1          -- update index
        bo.spelllang = langs[i]   -- change spelllang
        wo.spell = langs[i] ~= '' -- if empty then nospell
    end
end


-- Poor man's Zen mode
map 'z :lua togglezen()<cr>'
function togglezen()
    o.laststatus      = o.laststatus == 2 and 0 or 2
    o.ruler           = not o.ruler
    wo.number         = not wo.number
    wo.relativenumber = not wo.relativenumber
end


--- Other mappings
map 'l :luafile %<cr>'          -- Source lua file
map 't :sp\\|:te<cr>'           -- Open terminal
map 'rc :e ~/.config/nvim<cr>'  -- Open config directory
map('d "= "' .. os.date('%Y-%m-%d T %T') .. '"<cr>p') -- Print date & time
