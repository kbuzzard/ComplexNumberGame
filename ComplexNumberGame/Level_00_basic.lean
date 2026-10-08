/-
Copyright (c) 2020 The Xena project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kevin Buzzard
-/
-- Thanks: Imperial College London, leanprover-community

-- We will assume that the real numbers are a field.
import Mathlib.Basic.Real.Basic
-- We will also want to use some tactics. (We don't `import Mathlib.Tactic` because that
-- would also import mathlib's own complex numbers, which would clash with ours.)
import Mathlib.Tactic.Common
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# The complex numbers

We define the complex numbers, and prove that they are a ring.

We also "extract some basic API" (e.g. we prove that
two complex numbers are equal iff they have the same
real and imaginary parts)

This file has no `sorry`s in. All of the other levels:

`Level_01_of_real.lean`
`Level_02_I.lean`
`Level_03_conj.lean`
`Level_04_norm_sq.lean`
`Level_05_field.lean`
`Level_06_alg_closed.lean`

have sorrys, indicating puzzles to be solved.

# Main Definitions

`zero` : the complex number 0
`one` : the complex number 1
`add` -- addition of two complex numbers
`neg` -- negation of a complex number
`mul` -- multiplication of two complex numbers

# Main Theorem

`commRing` : The complex numbers are a commutative ring.

-/

/-- A complex number is defined to be a structure consisting of two real
  numbers, the real part and the imaginary part of the complex number. -/
structure Complex : Type where
  re : ℝ
  im : ℝ

-- Let's use the usual notation for the complex numbers
notation "ℂ" => Complex

-- You make the complex number with real part 3 and imaginary part 4 like this:
example : ℂ :=
  { re := 3,
    im := 4 }

-- Or like this:
example : ℂ := Complex.mk 3 4

-- or like this:
example : ℂ := ⟨3, 4⟩

-- They all give the same complex number.

example : Complex.mk 3 4 = ⟨3, 4⟩ := by rfl  -- "true by definition"

-- All of our definitions, like `zero` and `one`, will all
-- live in the `Complex` namespace.

namespace Complex

-- If you have a complex number, then you can get its real and
-- imaginary parts with the `re` and `im` functions.
-- (Note that in Lean we write `re z`, with a space, for the function `re`
-- applied to `z`; mathematicians would write `re(z)`, but Lean does not accept
-- `re(z)`. You can write `re (z)` if you like brackets.)

example : ℝ := re (mk 3 4) -- this term is (3 : ℝ)

example : re (mk 3 4) = 3 := by rfl

-- Computer scientists prefer the style `z.re` to `re z` for some reason.

example : (mk 3 4).re = 3 := by rfl

example (z : ℂ) : re z = z.re := by rfl

-- Before we start making the basic
-- We now prove the basic theorems and make the basic definitions for
-- complex numbers. For example, we will define addition and multiplication on
-- the complex numbers, and prove that it is a commutative ring.
-- TODO fix

/-! # Defining the ring structure on ℂ -/

-- Our main goal is to prove that the complexes are a ring. Let's
-- define the structure first; the zero, one, addition and multiplication
-- on the complexes.

/-! ## zero (0) -/

/-- The complex number with real part 0 and imaginary part 0 -/
def zero : ℂ := ⟨0, 0⟩

-- Now we set up notation so that `0 : ℂ` will mean `zero`.

/-- notation `0` for `zero` -/
instance : Zero ℂ := ⟨zero⟩

-- Let's prove the two basic properties, both of which are true by definition,
-- and then tag them with the appropriate attributes.
@[simp] lemma zero_re : re (0 : ℂ) = 0 := by rfl
@[simp] lemma zero_im : im (0 : ℂ) = 0 := by rfl

/-! ## one (1) -/

-- Now let's do the same thing for 1.

/-- The complex number with real part 1 and imaginary part 0 -/
def one : ℂ := ⟨1, 0⟩

/-- Notation `1` for `one` -/
instance : One ℂ := ⟨one⟩

-- name the basic properties and tag them with `simp`
@[simp] lemma one_re : re (1 : ℂ) = 1 := by rfl
@[simp] lemma one_im : im (1 : ℂ) = 0 := by rfl




/-! ## add (+) -/

-- Now let's define addition

/-- addition `z+w` of complex numbers -/
def add (z w : ℂ) : ℂ := ⟨z.re + w.re, z.im + w.im⟩

/-- Notation `+` for addition -/
instance : Add ℂ := ⟨add⟩

-- basic properties
@[simp] lemma add_re (z w : ℂ) : re (z + w) = re z + re w := by rfl
@[simp] lemma add_im (z w : ℂ) : im (z + w) = im z + im w := by rfl

/-! ## neg (-) -/

-- negation

/-- The negation `-z` of a complex number `z` -/
def neg (z : ℂ) : ℂ := ⟨-re z, -im z⟩

/-- Notation `-` for negation -/
instance : Neg ℂ := ⟨neg⟩

-- how neg interacts with re and im
@[simp] lemma neg_re (z : ℂ) : re (-z) = -re z := by rfl
@[simp] lemma neg_im (z : ℂ) : im (-z) = -im z := by rfl

/-! ## mul (*) -/

-- multiplication

/-- Multiplication `z*w` of two complex numbers -/
def mul (z w : ℂ) : ℂ :=
  ⟨re z * re w - im z * im w, re z * im w + im z * re w⟩

/-- Notation `*` for multiplication -/
instance : Mul ℂ := ⟨mul⟩

-- how `mul` reacts with `re` and `im`
@[simp] lemma mul_re (z w : ℂ) : re (z * w) = re z * re w - im z * im w := by
  rfl

@[simp] lemma mul_im (z w : ℂ) : im (z * w) = re z * im w + im z * re w :=
  rfl

/-! ## Example of what `simp` can now do

example (a b c : ℂ) :
    re (a * (b + c)) = re a * (re b + re c) - im a * (im b + im c) := by
  simp

-/


/-! # `ext` : A mathematical triviality -/

/-
Two complex numbers with the same real and imaginary parts are equal. This is an
"extensionality lemma", i.e. a lemma of the form "if two things are made from
the same pieces, they are equal". This is not hard to prove, but we want to
give the result a name so we can tag it with the `ext` attribute, meaning that
the `ext` tactic will know it. To add to the confusion, let's call the
theorem `ext` :-)

(The `(iff := false)` stops Lean from automatically generating the "if and only
if" version `ext_iff` of the lemma, because we will prove it ourselves later on
in this file.)
-/

/-- If two complex numbers z and w have equal real and imaginary parts,
    they are equal -/
@[ext (iff := false)] theorem ext {z w : ℂ}
    (hre : re z = re w) (him : im z = im w) : z = w := by
  obtain ⟨zr, zi⟩ := z
  obtain ⟨ww, wi⟩ := w
  simp_all

/-! # Theorem:  The complex numbers are a commutative ring

Proof: we've defined all the structure, and every axiom can be checked by
reducing it to checking real and imaginary parts with `ext`, expanding
everything out with `simp`, and then using the fact that the real numbers are
a commutative ring (which we already know)

-/

/-- The complex numbers are a commutative ring -/
instance commRing : CommRing ℂ := by
  -- first the data
  refine { zero := (0 : ℂ), add := (· + ·), neg := Neg.neg, one := 1, mul := (· * ·),
           -- (Lean's mathlib also wants to be told how to multiply a complex number
           -- by a natural number or an integer, and how to raise it to a natural
           -- number power; we tell it to use the obvious recursive definitions.)
           nsmul := nsmulRec, zsmul := zsmulRec, npow := npowRec,
           -- now the axioms
           -- of which there seem to be 13
           add_assoc := ?_, zero_add := ?_, add_zero := ?_, add_comm := ?_,
           mul_assoc := ?_, one_mul := ?_, mul_one := ?_, zero_mul := ?_, mul_zero := ?_,
           left_distrib := ?_, right_distrib := ?_, neg_add_cancel := ?_, mul_comm := ?_ } <;>
  -- The `?_`s mean "I'll prove this later", so we now have 13 goals.
  -- Note the `<;>`s, which mean "apply the next tactic to all the goals
  -- produced by the previous one".
  --
  -- First introduce the variables
  intros <;>
  -- we now have to prove an equality between two complex numbers.
  -- It suffices to check on real and imaginary parts
  ext <;>
  -- the simplifier can simplify stuff like re (a + 0)
  simp <;>
  -- all the goals now are identities between *real* numbers,
  -- and the reals are already known to be a ring
  ring


/-

That is the end of the proof that the complexes form a ring. We built
a basic API which was honed towards the general idea that to prove
certain statements about the complex numbers, for example distributivity,
we could just check on real and imaginary parts. We trained the
simplifier to expand out things like re(z*w) in terms
of re(z), im(z), re(w), im(w).

-/

/-!

# Optional (for mathematicians) : more basic infrastructure, and term mode

-/

/-!
## `ext` revisited

Recall extensionality:

theorem ext {z w : ℂ}
    (hre : re z = re w) (him : im z = im w) : z = w := ...

Here is another tactic mode proof of extensionality. Note that we have moved
the hypotheses to the other side of the colon; this does not
change the theorem. This proof shows the power
of the `rintro` tactic.
-/

theorem ext' : ∀ z w : ℂ, z.re = w.re → z.im = w.im → z = w := by
  rintro ⟨zr, zi⟩ ⟨_, _⟩ ⟨rfl⟩ ⟨rfl⟩
  rfl


/-!

Explanation: `rintro` does `cases` as many times as you like using this cool
`⟨ ⟩` syntax for the case splits. Note that if you say that a proof of `a = b`
is `rfl` then Lean will define a to be b, or b to be a, and not even introduce
new notation for it.

-/

-- Here is the same proof in term mode.

theorem ext'' : ∀ {z w : ℂ}, z.re = w.re → z.im = w.im → z = w
  | ⟨_, _⟩, ⟨_, _⟩, rfl, rfl => rfl

/-!
## `eta`
-/

/-
We prove the mathematically obvious statement that the
complex number whose real part is re(z) and whose imaginary
part is im(z) is of course equal to z.
-/

/-- ⟨z.re, z.im⟩ is equal to z -/
@[simp] theorem eta : ∀ z : ℂ, Complex.mk z.re z.im = z := by
  intro z
  obtain ⟨x, y⟩ := z
  /-
    goal now looks complicated, and contains terms which look
    like {re := a, im := b}.re which obviously simplify to a.
    The `dsimp` tactic will do some tidying up for us, although
    it is not logically necessary. `dsimp` does definitional simplification.
  -/
  dsimp
  -- `dsimp` tidied the goal up to `{ re := x, im := y } = { re := x, im := y }`,
  -- and then noticed that this can be solved by reflexivity, so it closed the goal.

/-
The proof was "unfold everything, and it's true by definition".
This proof does not teach a mathematician anything, so we may as well write
it in term mode. Many tactics have term mode equivalent.
The equation compiler does the `intro` and `cases` steps,
and `dsimp` was unnecessary -- the two sides of the equation
were definitionally equal.
-/

theorem eta' : ∀ z : ℂ, Complex.mk z.re z.im = z
  | ⟨_, _⟩ => rfl

/-!
## ext_iff
-/

/-
Note that `ext` is an implication -- if re(z)=re(w) and im(z)=im(w) then z=w.
The below variant `ext_iff` is the two-way implication: two complex
numbers are equal if and only if they have the same real and imaginary part.
Let's first see a tactic mode proof. See how the `ext` tactic is used?
After it is applied, we have two goals, both of which are hypotheses.
The `<;>` means "apply the next tactic to all the goals
produced by this one"
-/

theorem ext_iff {z w : ℂ} : z = w ↔ z.re = w.re ∧ z.im = w.im := by
  constructor
  · intro H
    simp [H]
  · rintro ⟨hre, him⟩
    ext <;> assumption

-- Again this is easy to write in term mode, and no mathematician
-- wants to read the proof anyway.

theorem ext_iff' {z w : ℂ} : z = w ↔ z.re = w.re ∧ z.im = w.im :=
  ⟨fun H => by simp [H], And.rec ext⟩

end Complex

/-!

# some last comments on the `simp` tactic

Some equalities, even if obvious, had to be given names, because we want `simp`
to be able to use them. In short, the `simp` tactic tries to solve
goals of the form A = B, when `rfl` doesn't work (i.e. the goals are
not definitionally equal) but when any mathematician would be able
to simplify A and B via "obvious" steps such as `0 + x = x` or
`⟨z.re, z.im⟩ = z`. These things are sometimes not true by definition,
but they should be tagged as being well-known ways to simplify an equality.
When building our API for the complex numbers, if we prove a theorem of the
form `A = B` where `B` is a bit simpler than `A`, we should probably
tag it with the `@[simp]` attribute, so `simp` can use it.

Note: `simp` does *not* prove "all simple things". It proves *equalities*.
It proves `A = B` when, and only when, it can do it by applying
its "simplification rules", where a simplification rule is simply a proof
of a theorem of the form `A = B` and `B` is simpler than `A`.
-/
