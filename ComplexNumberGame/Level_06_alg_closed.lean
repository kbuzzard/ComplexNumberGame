/-
Copyright (c) 2020 The Xena project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kevin Buzzard
-/
-- Thanks: Imperial College London, leanprover-community

-- Import levels 1 to 5
import ComplexNumberGame.Level_05_field

-- Import the theory of polynomials in one variable over rings
-- (their degrees, and evaluating them)
import Mathlib.Algebra.Polynomial.Degree.Defs
import Mathlib.Algebra.Polynomial.Eval.Defs
/-!

# Level 6: The complex numbers are algebraically closed

-/

namespace Complex

open Polynomial

lemma exists_root {f : Polynomial ℂ} (hf : 0 < degree f) :
    ∃ z : ℂ, IsRoot f z := by
  sorry

end Complex

/-
Chris Hughes, an undergraduate mathematician at Imperial College London, proved
this result in Lean and PR'ed it to Lean's maths library.

Here is the link to the docs (the result is now called `Complex.exists_root` in
Lean 4's mathlib, where it is now proved using Liouville's theorem)
https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Complex/Polynomial/Basic.html#Complex.exists_root

and here is the code
https://github.com/leanprover-community/mathlib4/blob/d13f23b723b8a846827a245b89c10fc7d3f11612/Mathlib/Analysis/Complex/Polynomial/Basic.lean#L37

and here is Chris' original (Lean 3) code
https://github.com/leanprover-community/mathlib3/blob/8b422458ee63a25929f28695e9057a7ae707d7de/src/analysis/complex/polynomial.lean#L34
-/
