runtime vimrc " Options and trivial mappings. Also used with vim8 and vscode

if !exists('g:vscode')
    lua require('config') -- Plugin configurations and more verbose mappings
    runtime lsp.vim " (WIP) LSP configuration
endif
