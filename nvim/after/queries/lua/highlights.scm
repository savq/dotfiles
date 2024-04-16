; extends

((identifier) @variable
  (#eq? @variable "coroutine")) ; TODO: Open issue?

; Conceal `end` (and preserve highlight)
("end" @keyword (#set! conceal "¶"))
(function_definition ("end" @keyword.function (#set! conceal "¶")))
(function_declaration ("end" @keyword.function (#set! conceal "¶")))
