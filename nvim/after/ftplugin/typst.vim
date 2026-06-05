if !exists('g:typst_abbrev') || g:typst_abbrev
  "iabbrev <buffer> cdots ⋯
  "iabbrev <buffer> emptyset ∅
  "iabbrev <buffer> in ∈
  iabbrev <buffer> infty infinity
  iabbrev <buffer> subseteq subset.eq
  iabbrev <buffer> supseteq supset.eq

  iabbrev <buffer> cap inter
  iabbrev <buffer> bigcap inter.big
  iabbrev <buffer> cup union
  iabbrev <buffer> bigcup union.big

  iabbrev <buffer> neq eq.not
  "iabbrev <buffer> equiv ≡
  iabbrev <buffer> geq gt.eq
  iabbrev <buffer> leq lt.eq

  "iabbrev <buffer> implied ⟸
  "iabbrev <buffer> implies ⟹
  "iabbrev <buffer> mapsto ↦
  iabbrev <buffer> tol arrow.l
  iabbrev <buffer> tor arrow.r

  "iabbrev <buffer> NN ℕ
  "iabbrev <buffer> QQ ℚ
  "iabbrev <buffer> RR ℝ
  "iabbrev <buffer> ZZ ℤ
  iabbrev <buffer> alfa alpha
  "iabbrev <buffer> beta β
  iabbrev <buffer> gama gamma
  "iabbrev <buffer> delta δ
  iabbrev <buffer> eps epsilon
  "iabbrev <buffer> sigma σ
  "iabbrev <buffer> pi π
  iabbrev <buffer> lamda lambda
end

setlocal iskeyword-=_
