-- Useful shorthand
function noremap(str) vim.cmd('noremap ' .. str) end
local sl = '<silent><leader>'

---- APPEARANCE ----
vim.o.termguicolors = true
vim.g.ayucolor='mirage'
vim.cmd('colorscheme ayu')
vim.cmd('hi Comment gui=italic')


---- PLUGINS ----

-- Julia
vim.g.latex_to_unicode_tab = 0 -- FIXME after nvim 0.5 + lsp
noremap(sl ..'j :!julia %<cr>')

-- Vimtex
vim.g.tex_flavor = 'latex'

-- Wiki.vim
vim.g.wiki_root = '~/Documents/notes/'
vim.g.wiki_filetypes = {'md'}
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_map_link_create = 'CreateLinkNames'
--FIXME How to write the CreateLinkNames function in Lua and pass it to vimscript?


---- MAPPINGS ----

-- Basics
vim.g.mapleader = ' '
noremap'; :'
noremap'<c-h> K' -- Why is K for help?
noremap'Y "+y'   -- Copy to system clipboard

-- Better navigation
noremap'J }'
noremap'K {'
noremap'H ^'
noremap'L $'

-- Disable arrow keys
noremap'<Up>    <Nop>'
noremap'<Down>  <Nop>'
noremap'<Left>  <Nop>'
noremap'<Right> <Nop>'

-- Miscellaneous
noremap(sl ..'t :vs\\|:te<cr>')                   -- Open terminal to the right
noremap(sl ..'rc :e ~/.config/nvim/init.vim<cr>') -- Open init.vim
noremap(sl ..'d "=strftime("%Y-%m-%d %T")<cr>p')  -- Print date & time
noremap(sl ..'f :call CocAction("format")<cr>')   -- Coc Format

-- Spelling
noremap(sl ..'z b1z=e')                -- Correct previous word
noremap(sl ..'x 1z=1')                 -- Correct current word
noremap(sl ..'s :lua CycleLang()<cr>') -- Change spelling language

-- Lua version of this solution: <stackoverflow.com/questions/12006508>
do
    local spl = {i = 1, langs = {'', 'en', 'es', 'de'}}
    function CycleLang()
        spl.i = (spl.i % #spl.langs) + 1      --update index
        vim.bo.spelllang = spl.langs[spl.i]   --change spelllang
        vim.wo.spell = spl.langs[spl.i] ~= '' --if empty then nospell
    end
end

