" TODO: Port to lua (operatorfunc doesn't work)
lua require 'term'

" Modified from: learnvimscriptthehardway.stevelosh.com/chapters/34.html
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

" Keymap to send things to the REPL
nnoremap <silent><leader>e :set operatorfunc=<SID>TermOperator<cr>g@
vnoremap <silent><leader>e :<c-u>call <SID>TermOperator(visualmode())<cr>

command Vterm vs<bar>term
