local autocmd = vim.api.nvim_create_autocmd
local group = api.nvim_create_augroup('BufferDecor', {})

autocmd('TextYankPost', { callback = function() highlight.on_yank() end, group = group })

-- Insert
autocmd('InsertEnter', { command = 'set conceallevel=0 nocursorcolumn cursorline list', group = group })

autocmd('InsertLeave', { command = 'set conceallevel=2 nocursorcolumn nocursorline nolist', group = group })

-- Visual
autocmd(
    'ModeChanged',
    { pattern = '*:[vV\x16]*', command = 'set conceallevel=0 cursorcolumn nocursorline list', group = group }
)

autocmd(
    'ModeChanged',
    { pattern = '[vV\x16]*:*', command = 'set conceallevel=2 nocursorcolumn nocursorline nolist', group = group }
)

-- Track which windows have visible gutters
local window_gutters = {}

local function toggle_gutter()
    local win = api.nvim_get_current_win()
    local is_enabled = window_gutters[win] == true
    opt.number = is_enabled
    opt.foldcolumn = is_enabled and '1' or '0'
    opt.colorcolumn = is_enabled and '100' or '' -- not in the gutter...
    window_gutters[win] = not is_enabled
end

keymap.set('n', '<leader>z', toggle_gutter)
