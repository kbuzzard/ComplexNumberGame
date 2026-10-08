/-
Copyright (c) 2020 The Xena project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kevin Buzzard
-/
-- Thanks: Imperial College London, leanprover-community

-- import the definition and basic properties of ℂ
import ComplexNumberGame.Level_00_basic

/-! # Level 1 : the map from ℝ to ℂ

This file sets up the coercion from the reals to the complexes,
sending `r` to `⟨r, 0⟩`. Mathematically it is straightforward.

All the proofs below are sorried. You can try them in tactic mode
by replacing `sorry` with `by sorry` and then starting to write
tactics in the `by` block.

-/

namespace Complex

-- fill in the definition of the map below,
-- sending the real number r to the complex number ⟨r, 0⟩

/-- The canonical map from ℝ to ℂ. -/
@[coe] def ofReal (r : ℝ) : ℂ := sorry

/-
We make this map into a *coercion*, which means that if `(r : ℝ)` is a real
number, then `(r : ℂ)` or `(↑r : ℂ)` will indicate the corresponding
complex number with no imaginary part. This is the notation we shall
use in our `simp` lemmas. (The `@[coe]` attribute on `ofReal` tells Lean
to display `ofReal r` as `↑r`, and also tells the `norm_cast` tactic about `ofReal`.)
-/

/-- The coercion from ℝ to ℂ sending `r` to the complex number `⟨r, 0⟩` -/
instance : Coe ℝ ℂ := ⟨ofReal⟩

/-
As usual, we need to train the `simp` tactic. But we also need to train
the `norm_cast` tactic. The `norm_cast` tactic enables Lean to prove
results like r^2=2*s for reals `r` and `s`, if it knows that
`(r : ℂ)^2 = 2*(s : ℂ)`. Such results are intuitive for mathematicians
but involve "invisible maps" in Lean
-/

@[simp, norm_cast] lemma ofReal_re (r : ℝ) : (r : ℂ).re = r := sorry
@[simp, norm_cast] lemma ofReal_im (r : ℝ) : (r : ℂ).im = 0 := sorry

-- The map from the reals to the complexes is injective, something we
-- write in iff form so `simp` can use it; `simp` also works on `iff` goals.

@[simp, norm_cast] theorem ofReal_inj {r s : ℝ} : (r : ℂ) = s ↔ r = s := sorry

-- what does norm_cast do?? Here are two examples of usage:

/-

example (r s : ℝ) (h : (r : ℂ) = s) : r = s := by
  norm_cast at h
  -- `h` is now `r = s`, and `norm_cast` notices that this
  -- is exactly the goal, so it closes the goal.

example (r s : ℝ) (h : r = s) : (r : ℂ) = (s : ℂ) := by
  norm_cast
  -- the goal became `r = s`, and `norm_cast` closed it using `h`.

-/

/-
We now go through all the basic constants and constructions we've defined so
far, namely 0, 1, +, -, *, and tell the simplifier how they behave with respect
to this new function.
-/

/-! ## zero -/

@[simp, norm_cast] lemma ofReal_zero : ((0 : ℝ) : ℂ) = 0 := sorry

@[simp] theorem ofReal_eq_zero {r : ℝ} : (r : ℂ) = 0 ↔ r = 0 := sorry

theorem ofReal_ne_zero {r : ℝ} : (r : ℂ) ≠ 0 ↔ r ≠ 0 := sorry

/-! ## one -/

@[simp, norm_cast] lemma ofReal_one : ((1 : ℝ) : ℂ) = 1 := sorry

/-! ## add -/

@[simp, norm_cast] lemma ofReal_add (r s : ℝ) : ((r + s : ℝ) : ℂ) = r + s := by
  sorry

/-! ## neg -/

@[simp, norm_cast] lemma ofReal_neg (r : ℝ) : ((-r : ℝ) : ℂ) = -r := by
  sorry

/-! ## mul -/

@[simp, norm_cast] lemma ofReal_mul (r s : ℝ) : ((r * s : ℝ) : ℂ) = r * s := by
  sorry

/-- The canonical ring homomorphism from ℝ to ℂ -/
def ofRealHom : ℝ →+* ℂ where
  toFun := (↑) -- use the coercion from ℝ to ℂ
  map_zero' := ofReal_zero
  map_one' := ofReal_one
  map_add' := ofReal_add
  map_mul' := ofReal_mul

/-! ## numerals.

This is quite a computer-sciency bit.

These last two lemmas are to do with the canonical map from numerals
into the complexes, e.g. `(23 : ℂ)`. In Lean 4, the numeral `(23 : ℂ)` is
notation for `OfNat.ofNat 23`, and for numerals `n ≥ 2` this is defined to be
`((n : ℕ) : ℂ)`, the image of the natural number `n` under the canonical map
`ℕ → ℂ` (which exists in any ring, and sends `n` to `1 + 1 + ⋯ + 1`).
See for example

set_option pp.explicit true in
#check (37 : ℂ)
-- @OfNat.ofNat Complex (nat_lit 37) (@instOfNatAtLeastTwo Complex (nat_lit 37) ...) : Complex

The numerals `0` and `1` are different: they are `Zero.zero` and `One.one`,
which we already dealt with in `ofReal_zero` and `ofReal_one`. This is why
the second lemma below assumes `[n.AtLeastTwo]`. In that lemma, `ofNat(n)` is
notation for the numeral `n` (i.e. for `OfNat.ofNat n`).

We need these results so that `norm_cast` can prove results such
as `((37 : ℝ) : ℂ) = (37 : ℂ)` (i.e. coercion commutes with numerals)

-/

@[simp, norm_cast] lemma ofReal_natCast (n : ℕ) : ((n : ℝ) : ℂ) = n :=
  sorry
@[simp, norm_cast] lemma ofReal_ofNat (n : ℕ) [n.AtLeastTwo] :
    ((ofNat(n) : ℝ) : ℂ) = ofNat(n) :=
  sorry

end Complex

/-! ## norm_cast examples

The idea is that the "invisible map" from the reals to the complexes should not
create any trouble to mathematicians who just want things to work as normal

https://xenaproject.wordpress.com/2020/04/30/the-invisible-map/



example (a b c : ℝ) : ((a * b : ℝ) : ℂ) * c = (a : ℂ) * b * c := by
  norm_cast

example (a b c : ℝ) : ((a : ℂ) + b) * c = ((a + b) * c : ℝ) := by
  norm_cast

example : (37 : ℂ) = (37 : ℝ) := by
  norm_cast

-/
