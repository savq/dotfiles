local utils = {}

local function make_mapper(fn)
    return function (lhs, rhs, mode, expr)    -- wait for lua keymaps: neovim/neovim#13823
        mode = mode or "n"
        if mode == "n" then rhs = "<cmd>" .. rhs .. "<cr>" end
        fn(mode, lhs, rhs, {noremap=true, silent=true, expr=expr})
    end
end

utils.map = make_mapper(vim.api.nvim_set_keymap)
utils.bufmap = make_mapper(vim.api.nvim_buf_set_keymap)

-- Safe require. Sometimes. Just in case.
function utils.import(path)
    -- local err, mod = pcall(require, path)
    -- return err and mod.setup or function() end
    return require(path).setup
end

function utils.dump(...)
    print(unpack(tbl_map(inspect, {...})))
end

_G.dump = utils.dump

return utils
