Open the project in VS Code. All the levels are in the `ComplexNumberGame` directory.

# The tutorial level

Level 0: The tutorial level, is at `ComplexNumberGame/Level_00_basic.lean`. All solutions are given. Read through this code first, and refer back to it if necessary.

In the tutorial level we define `0`, `1`, `+`, `-` and `*`, and prove that the complex numbers are a ring.

# The main levels

Anyone who has played Majora's Mask knows that all good games have 4 levels.

People who know some basic Lean tactics should be able to have a go at these. Open the relevant project files in VS Code and fill in all the `sorry`s.

* Level 1: the natural map from the reals to the complexes, is at `ComplexNumberGame/Level_01_of_real.lean`

* Level 2: sqrt(-1), is at `ComplexNumberGame/Level_02_I.lean`

* Level 3: Complex conjugation, is at `ComplexNumberGame/Level_03_conj.lean`

* Level 4: the complex norm (squared), is at `ComplexNumberGame/Level_04_norm_sq.lean`

# Challenges

These are harder, and I give fewer hints.

* Level 5: the complex numbers are a field, is at `ComplexNumberGame/Level_05_field.lean` . Note that this is not too bad really, and the answers (for the Lean 3 version of the game) are up on the Xena youtube channel.

* Level 6: the complex numbers are an algebraically closed field, is at `ComplexNumberGame/Level_06_alg_closed.lean`

This is hard. Chris Hughes did it, and [put it in mathlib](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Complex/Polynomial/Basic.html#Complex.exists_root).
