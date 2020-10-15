" NOTE: Trivial mappings and options are in vimrc
"       Plugins, non-trivial mappings and anything that uses Lua is in lua/config
source $HOME/.config/nvim/vimrc

lua << EOF
    require('config')
EOF

runtime lsp.vim

"" LIGHTLINE
let g:lightline = {
\   'colorscheme': 'ayu_mirage',
\   'active':{'left':  [['mode', 'paste'],
\                       ['gitbranch', 'readonly', 'filename', 'modified'],
\                       ['cocstatus', 'cocCurrentFun']],
\             'right': [['percent', 'lineinfo'],
\                       ['spell', 'filetype', 'fileencoding', 'fileformat']]},
\   'component_function': {'cocstatus': 'coc#status',
\                          'cocCurFun': 'CocCurrentFunction'}}

" wiki.vim function
function CreateLinkNames(text) abort
  return strftime("%Y%m%dT%H%M-") . substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

