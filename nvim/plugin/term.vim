" TODO: Port to Lua.
" `operatorfunc` doesn't support Lua functions.
" See https://github.com/neovim/neovim/issues/14157

" Modified from: https://learnvimscriptthehardway.stevelosh.com/chapters/34.html
function! s:TermOperator(type)
    let reg = getreg()

    if a:type == 'v'
        normal! `<v`>y
    elseif a:type == 'char' || a:type == 'line'
        normal! `[v`]y
    else
        return
    endif

    execute 'wincmd j | put | call feedkeys("i\<cr>\<esc>\<c-w>k")'
    call setreg('', reg)
endfunction

" Send text to REPL
nnoremap <silent><leader>e :set operatorfunc=<SID>TermOperator<cr>g@
vnoremap <silent><leader>e :<c-u>call <SID>TermOperator(visualmode())<cr>
