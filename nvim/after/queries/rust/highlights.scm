; extends

; Display proper angle brackets
(type_arguments  ("<" @punctuation.bracket (#set! conceal "⟨")))
(type_arguments  (">" @punctuation.bracket (#set! conceal "⟩")))
(type_parameters ("<" @punctuation.bracket (#set! conceal "⟨")))
(type_parameters (">" @punctuation.bracket (#set! conceal "⟩")))

; Distinguish unary operators from binary operators
(reference_type "&" @keyword)
(unary_expression ["*" "&"] @keyword)

; Distinguish tuple parentheses from regular parentheses
(tuple_expression ["(" ")"] @constructor)
