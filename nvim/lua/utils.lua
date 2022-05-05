return {
    command = vim.api.nvim_create_user_command,

    keymap = function(lhs, rhs, mode)
        vim.keymap.set(mode or 'n', lhs, rhs)
    end,

    augroup = function(name, autocmds)
        local group = vim.api.nvim_create_augroup(name, {})
        for event, cmd in pairs(autocmds) do
            cmd.group = group
            vim.api.nvim_create_autocmd(event, cmd)
        end
    end,
}
