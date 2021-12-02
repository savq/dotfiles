" TODO: Allow horizontal splits as well as vertical splits

augroup Scripting
    au!
    " run scripts with <cr>
    au FileType julia   noremap <silent><buffer><cr> <cmd>!julia %<cr>
    au FileType lua,vim noremap <silent><buffer><cr> <cmd>source %<cr>
    au FileType python  noremap <silent><buffer><cr> <cmd>!python3 %<cr>
    au FileType rust    noremap <silent><buffer><cr> <cmd>Cargo run<cr>

    " compile with <bs>
    au FileType c,lua   noremap <silent><uffer><bs> <cmd>make<cr>
    au FileType rust    noremap <silent><buffer><bs> <cmd>Cargo build<cr>
augroup END

augroup Term
    au!
    au TermOpen * set nospell nonumber nocursorcolumn nocursorline
    au TermClose * quit
augroup END

" Open shell or REPLs in small vertical split window
nnoremap <silent><leader>sh <cmd>12sp \| term<cr>
nnoremap <silent><leader>jl <cmd>12sp \| e term://julia -q   \| wincmd k<cr>
nnoremap <silent><leader>py <cmd>12sp \| e term://python3 -q \| wincmd k<cr>
nnoremap <silent><leader>4  <cmd>12sp \| e term://gforth     \| wincmd k<cr>

" Use escape key in terminal
tnoremap <silent><Esc> <C-\><C-n>

" Keymap to send things to the REPL
nnoremap <silent><leader>e :set operatorfunc=<SID>TermOperator<cr>g@
vnoremap <silent><leader>e :<c-u>call <SID>TermOperator(visualmode())<cr>

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
