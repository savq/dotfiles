-- Various Lua utilities

-- Make printing in nvim's prompt easier
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

