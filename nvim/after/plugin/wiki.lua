vim.g.wiki_root = '~/Documents/wiki'
vim.g.wiki_link_creation = {
    md = {
        url_transform = function(txt) return txt:lower():gsub('%s+', '-') end,
    },
}

--- TODO: Refactor
vim.api.nvim_create_user_command(
    'WikiPick',
    function() MiniPick.builtin.grep_live(nil, { source = { cwd = g.wiki_root } }) end,
    {}
)
