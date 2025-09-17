-- NOTE: Use i_CTRL-X_s to correct spelling of previous misspelled word
vim.keymap.set('n', '<leader>l', function()
    vim.ui.select({ 'en', 'es', 'de' }, {}, function(lang)
        vim.opt.spell = lang ~= nil
        vim.opt.spelllang = lang or ''
    end)
end)
