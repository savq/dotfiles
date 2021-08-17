" TODO: Allow horizontal splits as well as vertical splits

augroup term_stuff
    autocmd TermOpen * set nospell nonumber nocursorcolumn nocursorline

    autocmd FileType lua,vim noremap <buffer><leader>sc <cmd>source %<cr>
    autocmd FileType python  noremap <buffer><leader>sc <cmd>!python3 %<cr>
    autocmd FileType julia   noremap <buffer><leader>sc <cmd>!julia %<cr>
augroup END

" Open shell or REPLs in small vertical split window
nnoremap <silent><leader>sh :12sp \| term<cr>
nnoremap <silent><leader>jl :12sp \| e term://julia -q \| wincmd k<cr>
nnoremap <silent><leader>py :12sp \| e term://python3 -q \| wincmd k<cr>
nnoremap <silent><leader>4  :12sp \| e term://gforth \| wincmd k<cr>

" Use escape key in terminal
tnoremap <silent><Esc> <C-\><C-n>

" Keymap to send things to the REPL
nnoremap <leader>e :set operatorfunc=<SID>TermOperator<cr>g@
vnoremap <leader>e :<c-u>call <SID>TermOperator(visualmode())<cr>

" Modified from: learnvimscriptthehardway.stevelosh.com/chapters/34.html
function! s:TermOperator(type)
    let saved_unnamed_register = @@

    if a:type == 'v'
        normal! `<v`>y
    elseif a:type == 'char' || a:type == 'line'
        normal! `[v`]y
    else
        return
    endif

    execute 'wincmd j | put | call feedkeys("i\<cr>\<esc>\<c-w>k")'

    let @@ = saved_unnamed_register
endfunction

