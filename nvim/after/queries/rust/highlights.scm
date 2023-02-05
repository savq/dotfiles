; extends

; Display proper angle brackets
(type_arguments  ("<" @punctuation.bracket (#set! conceal "⟨")))
(type_arguments  (">" @punctuation.bracket (#set! conceal "⟩")))
(type_parameters ("<" @punctuation.bracket (#set! conceal "⟨")))
(type_parameters (">" @punctuation.bracket (#set! conceal "⟩")))

; Display proper arrow
(function_item ("->" @function (#set! conceal "→")))
(function_signature_item ("->" @function (#set! conceal "→")))

; Distinguish unary operators from binary operators
(reference_type "&" @keyword)
(unary_expression ["*" "&"] @keyword)

; Distinguish tuple parentheses from regular parentheses
(tuple_expression ["(" ")"] @constructor)
