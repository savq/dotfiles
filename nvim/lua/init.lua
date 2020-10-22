-- Useful aliases
local g = vim.g
local cmd = vim.cmd
local function map(str) vim.cmd('noremap <silent><leader>' .. str) end

--- PLUGINS
cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'
paq 'tjdevries/lsp_extensions.nvim'

paq 'lervag/vimtex'
paq 'lervag/wiki.vim'
paq 'vim-pandoc/vim-pandoc'
paq 'vim-pandoc/vim-pandoc-syntax'

paq 'JuliaEditorSupport/julia-vim'

paq 'ayu-theme/ayu-vim'
paq 'itchyny/lightline.vim'
paq 'junegunn/vim-easy-align'
paq{'norcalli/nvim-colorizer.lua', opt=true} --Highlight hex and rgb colors


-- Vimtex
g.tex_flavor = 'lualatex'


-- Wiki.vim
g.wiki_root = '~/Documents/notes/'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinkNames'
function createlinks(txt)
    return os.date('%Y%m%dT%H%M-') .. txt:lower():gsub('[%s.]+', '-')
end
cmd [[function CreateLinkNames(txt) abort
        return v:lua.createlinks(a:txt)
      endfunction]]


-- Julia
g.latex_to_unicode_tab = 0
g.latex_to_unicode_auto = 1
map 'j :!julia %<cr>'


-- Pandoc markdown
g['pandoc#spell#enabled'] = 0
g['pandoc#syntax#conceal#use'] = 1
g['pandoc#syntax#conceal#urls'] = 1
cmd 'au BufNewFile,BufRead *.md set nowrap'


-- Theme: Ayu mirage
cmd 'colorscheme ayu'
cmd 'autocmd ColorScheme * hi Comment gui=italic'
g.ayucolor = 'mirage'
vim.o.termguicolors = true


-- Lightline
g.lightline = {
    colorscheme = 'ayu_mirage',
    active = {
        right= {{'percent', 'lineinfo'},
                {'spell', 'filetype', 'fileencoding', 'fileformat'}}
    }
}


--- OTHER MAPPINGS

map 'l :luafile %<cr>'          -- Source lua file
map 't :sp\\|:te<cr>'           -- Open terminal
map 'rc :e ~/.config/nvim<cr>'  -- Open config directory
map('d "= "' .. os.date('%Y-%m-%d T %T') .. '"<cr>p') -- Print date & time

-- Spelling
map 'z b1z=e'                -- Correct previous word
map 'x 1z=1'                 -- Correct current word
map 's :lua cyclelang()<cr>' -- Change spelling language

do -- Lua version of this solution: stackoverflow.com/a/12006781
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1          -- update index
        vim.bo.spelllang = langs[i]   -- change spelllang
        vim.wo.spell = langs[i] ~= '' -- if empty then nospell
    end
end

