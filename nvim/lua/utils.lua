-- utils.lua
-- Define Neovim commands, autocommands and keymaps in Lua.
--
-- TODO:
-- write a class/metatable for commands with __call and __tostring metamethods:
-- docstrings!

local _fns = {}
local function fn_to_cmd(fn, iskeymap) -- FIXME
    if type(fn) == 'function' then
        table.insert(_fns, fn)
        return (iskeymap and '<cmd>' or ':') ..
            ('lua require\'utils\'._fns[%d]()'):format(#_fns) ..
            ((iskeymap and '<cr>' or ''))
    else
        return fn
    end
end

-- TODO: better handling of attributes
-- nargs, complete, range, count, addr
-- bang bar register buffer
local function command(name, rhs, attributes)
    local attrs = {}
    if attributes then
        for k, v in pairs(attributes) do
            table.insert(attrs, ('-%s=%s'):format(k, v))
        end
    end
    vim.cmd(table.concat(vim.tbl_flatten{'silent command!', attrs, name, fn_to_cmd(rhs)}, ' '))
end

local function autocmd(events, patterns, cmd)
    vim.cmd(table.concat({'autocmd', events, patterns, fn_to_cmd(cmd)}, ' '))
end

local function augroup(name, ...)
    vim.cmd('augroup ' .. name)
    vim.cmd('au!')
    for _, v in ipairs(...) do
        autocmd(unpack(v))
    end
    vim.cmd 'augroup END'
end

local keymap_defaults = {
    mode = 'n',
    -- buffer = nil,
    opts = {
        -- expr = nil,
        noremap = true,
        silent = true,
    },
}

local function keymap(tbl, cfg, keys)
    for k, v in pairs(tbl) do
        local lhs = (keys or '') .. k
        local rhs = fn_to_cmd(v, true)
        for mode in cfg.mode:gmatch '.' do
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
    command = command,
    autocmd = autocmd,
    augroup = augroup,
    keymap = function(t1, t2)
        if not t2 then
            keymap(t1, keymap_defaults)
        else
            keymap(t2, vim.tbl_deep_extend('force', keymap_defaults, t1))
        end
    end,
}
