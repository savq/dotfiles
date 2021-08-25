-- Based on https://github.com/LionC/nest.nvim

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
        local t = type(v)
        local lhs = (keys or "") .. k
        if t == "table" then
            keymap(v, cfg, lhs)
        else
            local rhs = t == "function" and fn_to_cmd(v) or v
            if cfg.buffer then
                vim.api.nvim_buf_set_keymap(cfg.buffer, cfg.mode, lhs, rhs, cfg.opts)
            else
                vim.api.nvim_set_keymap(cfg.mode, lhs, rhs, cfg.opts)
            end
            -- for mode in cfg.mode:gmatch "." do end
        end
    end
end

return {
    _fns = _fns,
    keymap = function(tbl, cfg)
        keymap(tbl, cfg and vim.tbl_deep_extend("force", defaults, cfg) or defaults)
    end,
}

