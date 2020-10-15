" NOTE: Trivial mappings and options are in vimrc
"       Plugins and non-trivial mappings are in lua/config
runtime vimrc
runtime lsp.vim
lua require('config')

"" LIGHTLINE
let g:lightline = {
\   'colorscheme': 'ayu_mirage',
\   'active':{'left':  [['mode', 'paste'],
\                       ['gitbranch', 'readonly', 'filename', 'modified']],
\             'right': [['percent', 'lineinfo'],
\                       ['spell', 'filetype', 'fileencoding', 'fileformat']]}}

" wiki.vim function
function CreateLinkNames(text) abort
  return strftime("%Y%m%dT%H%M-") . substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

