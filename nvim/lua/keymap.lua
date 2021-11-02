local defaults = {
    mode = "n",
    -- buffer = nil,
    opts = {
        -- expr = nil,
        noremap = true,
        silent = true,
    }
}

local _fns = {}
local function fn_to_cmd(fn)
    table.insert(_fns, fn)
    return ("<cmd>lua require'keymap'._fns[%d]()<cr>"):format(#_fns)
end

local function keymap(tbl, cfg, keys)
    for k,v in pairs(tbl) do
        local lhs = (keys or "") .. k
        local rhs = type(v) == "function" and fn_to_cmd(v) or v
        for mode in cfg.mode:gmatch "." do
            if cfg.buffer then
                vim.api.nvim_buf_set_keymap(cfg.buffer, mode, lhs, rhs, cfg.opts)
            else
                vim.api.nvim_set_keymap(mode, lhs, rhs, cfg.opts)
            end
        end
    end
end

return {
    _fns = _fns,
    keymap = function(t1, t2)
        if not t2 then
            keymap(t1, defaults)
        else
            keymap(t2, vim.tbl_deep_extend("force", defaults, t1))
        end
    end,
}

-- Based on https://github.com/LionC/nest.nvim
