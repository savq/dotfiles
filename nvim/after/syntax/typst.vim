if !exists('g:typst_conceal') || g:typst_conceal
  syntax match typstMathIdentifier '\<cdots\>'        conceal cchar=⋯
  syntax match typstMathIdentifier '\<emptyset\>'     conceal cchar=∅
  syntax match typstMathIdentifier '\<in\>'           conceal cchar=∈
  syntax match typstMathIdentifier '\<infinity\>'     conceal cchar=∞
  syntax match typstMathIdentifier '\<subset.eq\>'    conceal cchar=⊆
  syntax match typstMathIdentifier '\<supset.eq\>'    conceal cchar=⊇

  syntax match typstMathIdentifier '\<inter\>'        conceal cchar=∩
  syntax match typstMathIdentifier '\<inter.big\>'    conceal cchar=⋂
  syntax match typstMathIdentifier '\<union\>'        conceal cchar=∪
  syntax match typstMathIdentifier '\<union.big\>'    conceal cchar=⋃

  syntax match typstMathIdentifier '\<eq.not\>'   conceal cchar=≠
  syntax match typstMathIdentifier '\<equiv\>'    conceal cchar=≡
  syntax match typstMathIdentifier '\<gt.eq\>'    conceal cchar=≥
  syntax match typstMathIdentifier '\<lt.eq\>'    conceal cchar=≤

  syntax match typstMathIdentifier '\<arrow.l.double\>'   conceal cchar=⟸
  syntax match typstMathIdentifier '\<arrow.r.double\>'   conceal cchar=⟹
  syntax match typstMathIdentifier '\<mapsto\>'           conceal cchar=↦
  syntax match typstMathIdentifier '\<arrow.l\>'          conceal cchar=←
  syntax match typstMathIdentifier '\<arrow.r\>'          conceal cchar=→

  syntax match typstMathIdentifier '\<NN\>'       conceal cchar=ℕ
  syntax match typstMathIdentifier '\<QQ\>'       conceal cchar=ℚ
  syntax match typstMathIdentifier '\<RR\>'       conceal cchar=ℝ
  syntax match typstMathIdentifier '\<ZZ\>'       conceal cchar=ℤ
  syntax match typstMathIdentifier '\<alpha\>'    conceal cchar=α
  syntax match typstMathIdentifier '\<beta\>'     conceal cchar=β
  syntax match typstMathIdentifier '\<gamma\>'    conceal cchar=γ
  syntax match typstMathIdentifier '\<delta\>'    conceal cchar=δ
  syntax match typstMathIdentifier '\<epsilon\>'  conceal cchar=ε
  syntax match typstMathIdentifier '\<sigma\>'    conceal cchar=σ
  syntax match typstMathIdentifier '\<pi\>'       conceal cchar=π
  syntax match typstMathIdentifier '\<lambda\>'   conceal cchar=λ

  hi! link TypstMarkupDollar Italic
endif
