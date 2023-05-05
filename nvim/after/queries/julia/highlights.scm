; extends

(function_expression "->" @keyword.function)
(short_function_definition "=" @keyword.function)

(tuple_expression ["(" ")"] @constructor)

[
  "."
  "..."
  "::"
] @operator
