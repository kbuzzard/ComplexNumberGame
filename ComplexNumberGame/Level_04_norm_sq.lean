/-
Copyright (c) 2020 The Xena project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kevin Buzzard
-/
-- Thanks: Imperial College London, leanprover-community

-- Import levels 1 to 3
import ComplexNumberGame.Level_03_conj

/-!

# Level 4: Norms

Define `normSq : ℂ → ℝ` by defining `normSq z` to be
`re z * re z + im z * im z` and see what you can prove about it.

-/

namespace Complex

/-- The real number which is the squared norm of z -/
def normSq (z : ℂ) : ℝ := sorry

/-! ## Behaviour with respect to 0, 1 and I -/

@[simp] lemma normSq_zero : normSq 0 = 0 := sorry
@[simp] lemma normSq_one : normSq 1 = 1 := sorry
@[simp] lemma normSq_I : normSq I = 1 := sorry

/-! ## Behaviour with respect to *, + and - -/

@[simp] lemma normSq_mul (z w : ℂ) : normSq (z * w) = normSq z * normSq w :=
  sorry

lemma normSq_add (z w : ℂ) : normSq (z + w) =
    normSq z + normSq w + 2 * (z * conj w).re :=
  sorry

@[simp] lemma normSq_neg (z : ℂ) : normSq (-z) = normSq z :=
  sorry

/-! ## Behaviour with respect to `conj` -/

@[simp] lemma normSq_conj (z : ℂ) : normSq (conj z) = normSq z :=
  sorry

/-! ## Behaviour with respect to real numbers -/

@[simp] lemma normSq_ofReal (r : ℝ) : normSq r = r * r :=
  sorry

theorem mul_conj (z : ℂ) : z * conj z = normSq z :=
  sorry

/-! ## Behaviour with respect to real 0, ≤, < and so on -/

-- Warning: you will have to know something about Lean's API for
-- real numbers to solve these ones. If you turn the statements about
-- complex numbers into statements about real numbers, you'll find
-- they're of the form "prove $$x^2+y^2\geq0$$" with `x` and `y` real.

lemma normSq_nonneg (z : ℂ) : 0 ≤ normSq z := sorry

@[simp] lemma normSq_eq_zero {z : ℂ} : normSq z = 0 ↔ z = 0 :=
  sorry

@[simp] lemma normSq_pos {z : ℂ} : 0 < normSq z ↔ z ≠ 0 :=
  sorry

lemma re_sq_le_normSq (z : ℂ) : z.re * z.re ≤ normSq z :=
  sorry

lemma im_sq_le_normSq (z : ℂ) : z.im * z.im ≤ normSq z :=
  sorry

end Complex
