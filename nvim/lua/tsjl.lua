require("nvim-treesitter.parsers").get_parser_configs().julia = {
    install_info = {
        url = "~/.projects/tree-sitter-julia/",
        files = { "src/parser.c", "src/scanner.c" },
    }
}
