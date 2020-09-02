import OhMyREPL: Passes.SyntaxHighlighter

#= Revise (slow) =#
try
    using Revise
catch e
    @warn(e.msg)
end

#= Color scheme for OhMyREPL =#
function create_savq_colorscheme()
    Crayon = SyntaxHighlighter.Crayon
    SyntaxHighlighter.ColorScheme(
        Crayon(foreground = :light_blue),   # symbol
        Crayon(foreground = :dark_gray),    # comment
        Crayon(foreground = :green),        # string
        Crayon(foreground = :default),      # call
        Crayon(foreground = :light_blue),   # op
        Crayon(foreground = :light_yellow), # keyword (orange)
        Crayon(foreground = :default),      # text
        Crayon(foreground = :default),      # function_def
        Crayon(foreground = :red),          # error
        Crayon(foreground = :light_blue),   # argdef
        Crayon(foreground = :yellow),       # _macro
        Crayon(foreground = :light_magenta) # number
    )
end

#= OhMyREPL =#
atreplinit() do repl
    # There should be a try-catch here but initialization is already rather slow
    OhMyREPL.input_prompt!("> ")
    OhMyREPL.enable_pass!("RainbowBrackets", false)
    SyntaxHighlighter.add!("savq", create_savq_colorscheme())
    OhMyREPL.colorscheme!("savq")
end

