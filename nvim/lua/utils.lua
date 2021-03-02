-- Make printing in nvim's prompt easier
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- Wait for lua keymaps (nvim PR #13823)
-- TODO: make this function less weird
local function map(lhs, rhs, mode)
    vim.api.nvim_set_keymap(
        mode or 'n',
        lhs,
        '<cmd>' .. rhs .. '<cr>',
        {noremap=true, silent=true}
    )
end

return {map = map}
