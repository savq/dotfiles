-- NOTE: Use i_CTRL-X_s to correct spelling of previous misspelled word
keymap.set('n', '<leader>l', function()
    ui.select({ 'en', 'es', 'de' }, {}, function(lang)
        opt.spell = lang ~= nil
        opt.spelllang = lang or ''
    end)
end)
