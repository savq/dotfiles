local utils = {}

function utils.map(lhs, rhs, mode, expr)    -- wait for lua keymaps: neovim/neovim#13823
    mode = mode or "n"
    if mode == "n" then rhs = "<cmd>" .. rhs .. "<cr>" end
    vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
end

function utils.bufmap(lhs, rhs, mode, expr)
    mode = mode or "n"
    if mode == "n" then rhs = "<cmd>" .. rhs .. "<cr>" end
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
end

function utils.au(s)
    vim.cmd("au!" .. s)
end

function utils.dump(...)
    print(unpack(tbl_map(inspect, {...})))
end

_G.dump = utils.dump

return utils
