-- Make printing in nvim's prompt easier
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- Wait for lua keymaps: neovim/neovim#13823
local function map(lhs, rhs, mode, expr)
    mode = mode or 'n'
    if mode == 'n' then rhs = '<cmd>' .. rhs .. '<cr>' end
    vim.api.nvim_set_keymap(
        mode,
        lhs,
        rhs,
        {noremap=true, silent=true, expr=expr}
    )
end

return {map = map}
