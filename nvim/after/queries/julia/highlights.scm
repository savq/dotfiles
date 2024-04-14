; extends

; Distinguish tuple parentheses from regular parentheses
(tuple_expression ["(" ")"] @constructor)

; Distinguish unary operators from binary operators
(unary_expression (operator) @number (_)
  (#any-of? @number "+" "-" "~"))

; Distinguish syntactic operators
[
  "$"
  "."
  "..."
  "::"
] @keyword

((operator) @keyword
  (#any-of? @keyword
    "&&" "||"
    ".&&" ".||"))

; Distinguish syntactic operators for function definitions
(function_expression "->" @keyword.function)
(assignment . (call_expression) (operator) @keyword.function (_))

; Conceal `end` (and preserve highlight)
("end" @keyword (#set! conceal "¶"))
(function_definition ("end" @keyword.function (#set! conceal "¶")))
(do_clause ("end" @keyword.function (#set! conceal "¶")))
(module_definition ("end" @include (#set! conceal "¶")))
