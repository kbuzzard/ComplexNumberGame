/-
Copyright (c) 2020 The Xena project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kevin Buzzard
-/
-- Thanks: Imperial College London, leanprover-community

-- Import levels 1 to 4
import ComplexNumberGame.Level_04_norm_sq

/-! # Level 5 : the complex numbers are a field -/

/-
If you know what "the reals don't have decidable
equality" means then you know why the next line
is there, and if you don't then you probably don't care.
-/

noncomputable section

namespace Complex

/-

Before we start, it's worth pointing out that a field,
for Lean, is a non-zero commutative ring K equipped
with an inverse map `inv: K → K`, with notation z⁻¹,
satisfying 0⁻¹=0 and if z is non-zero then z*z⁻¹=1.
It's easy to check that this is equivalent to the
usual definition, where 0⁻¹ is simply not defined at all.

-/
/-- The inverse of a complex number -/
def inv (z : ℂ) : ℂ := sorry

-- notation for inverse
instance : Inv ℂ := ⟨inv⟩

/-- The complex numbers are a field -/
instance : Field ℂ where
  inv := Inv.inv
  inv_zero := by sorry
  exists_pair_ne := by sorry
  mul_inv_cancel := by sorry
  -- (Lean's mathlib also wants to know how to multiply an element of a field by
  -- a rational number; the `_`s tell Lean to use the obvious definitions.)
  nnqsmul := _
  qsmul := _
  -- and the rest of the structure is the commutative ring structure from level 0
  __ := commRing

end Complex

end -- noncomputable section
