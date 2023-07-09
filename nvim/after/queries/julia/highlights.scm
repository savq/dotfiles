; extends

; Distinguish tuple parentheses from regular parentheses
(tuple_expression ["(" ")"] @constructor)

; Distinguish unary operators from binary operators
(unary_expression (operator) @number (_)
  (#any-of? @number "+" "-" "~"))

; Distinguish syntactic operators
[
  "."
  "..."
  "::"
] @keyword

((operator) @keyword
  (#any-of? @keyword
    "&&" "||"
    ".&&" ".||"))

(function_expression "->" @keyword.function)
(short_function_definition "=" @keyword.function)

; Conceal `end` (and preserve highlight)
("end" @keyword (#set! conceal "¶"))
(function_definition ("end" @keyword.function (#set! conceal "¶")))
(do_clause ("end" @keyword.function (#set! conceal "¶")))
