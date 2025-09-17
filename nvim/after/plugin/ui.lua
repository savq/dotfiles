local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('BufferDecor', {})

--- Status line
vim.opt.statusline = '%2{mode()} | %f %m %r %= %{&spelllang} %y #%{bufnr()} %8(%l,%c%) %8p%%'


--- Mode indicators

autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = group,
})

-- Insert
autocmd('InsertEnter', { command = 'set conceallevel=0 nocursorcolumn cursorline list', group = group })

autocmd('InsertLeave', { command = 'set conceallevel=1 nocursorcolumn nocursorline nolist', group = group })

-- Visual
autocmd(
    'ModeChanged',
    { pattern = '*:[vV\x16]*', command = 'set conceallevel=0 cursorcolumn nocursorline list', group = group }
)

autocmd(
    'ModeChanged',
    { pattern = '[vV\x16]*:*', command = 'set conceallevel=1 nocursorcolumn nocursorline nolist', group = group }
)

--- Track which windows have visible gutters
local window_gutters = {}

local function toggle_gutter()
    local win = vim.api.nvim_get_current_win()
    local is_enabled = window_gutters[win] == true
    vim.opt.number = is_enabled
    vim.opt.foldcolumn = is_enabled and '1' or '0'
    vim.opt.colorcolumn = is_enabled and '100' or '' -- not in the gutter...
    window_gutters[win] = not is_enabled
end

vim.keymap.set('n', '<leader>z', toggle_gutter)
