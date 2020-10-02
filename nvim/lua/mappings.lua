---- MAPPINGS ----

vim.g.mapleader = ' '
noremap '; :'
noremap '<C-]> K' -- Help
noremap 'Y "+y'   -- Copy to system clipboard

-- Better navigation
noremap 'J }'
noremap 'K {'
noremap 'H ^'
noremap 'L $'

noremap '<C-h> <C-w>h'
noremap '<C-j> <C-w>j'
noremap '<C-k> <C-w>k'
noremap '<C-l> <C-w>l'

-- Disable arrow keys
noremap '<Up>    <Nop>'
noremap '<Down>  <Nop>'
noremap '<Left>  <Nop>'
noremap '<Right> <Nop>'

-- Miscellaneous
noremap(SL .. 't :sp\\|:te<cr>')          -- Open terminal
noremap(SL .. 'rc :e ~/.config/nvim<cr>') -- Open config directory
-- Print date & time
noremap(SL .. 'd "= "' ..
    vim.fn.strftime('%Y-%m-%d %T') ..
    '"<cr>p')

-- Spelling
noremap(SL .. 'z b1z=e')                -- Correct previous word
noremap(SL .. 'x 1z=1')                 -- Correct current word
noremap(SL .. 's :lua CycleLang()<cr>') -- Change spelling language

do -- Lua version of this solution: stackoverflow.com/a/12006781
    local spl = {i = 1, langs = {'', 'en', 'es', 'de'}}
    function CycleLang()
        spl.i = (spl.i % #spl.langs) + 1      --update index
        vim.bo.spelllang = spl.langs[spl.i]   --change spelllang
        vim.wo.spell = spl.langs[spl.i] ~= '' --if empty then nospell
    end
end

