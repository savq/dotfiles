local g = vim.g
local map = require('savq.utils').map

--- Markdown and HTML
g.markdown_enable_conceal = 1
g.user_emmet_leader_key = '<C-e>'

--- Wiki.vim
g.wiki_root = '~/Documents/wiki'
g.wiki_filetypes = {'md'}
g.wiki_link_target_type = 'md'
g.wiki_map_link_create = 'CreateLinks' -- cannot use anonymous functions
vim.cmd [[
function! CreateLinks(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction
]]

--- Spelling
do
    vim.cmd('nnoremap <leader>c 1z=1')     -- fix current word
    map('<leader>s', 'lua cyclelang()')    -- change spelling language
    local i = 1
    local langs = {'', 'en', 'es', 'de'}
    function cyclelang()
        i = (i % #langs) + 1
        vim.bo.spelllang = langs[i]
        vim.wo.spell = (langs[i] ~= '')
    end
end
