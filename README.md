# The Complex Number Game

The Complex Number Game. Make an interface for the complex numbers in Lean.

This is a Lean 4 port of the [Lean 3 complex number game](https://github.com/ImperialCollegeLondon/complex-number-game).

# Installation

This assumes you have [installed Lean using the instructions at the leanprover-community website](https://leanprover-community.github.io/get_started.html).

Get a copy of this project (for example with `git clone`). Then, in a terminal in the project directory, type

```
lake exe cache get
```

This will download a compiled copy of Lean's mathematics library mathlib, which this project depends on (compiling it yourself would take a very long time).

You can open the project using the terminal with

```
code .
```

(or you can use VS Code and then "Open Folder" -> `ComplexNumberGame`)

# Playing the game

The general idea: we can assume anything about the real numbers, and have to build the complex numbers from the ground up.
Once the project is installed on your computer, see the [instructions](INSTRUCTIONS.md) for how to play it.

# Thanks

* Everyone on the Zulip chat at leanprover-community, for answering my
questions. You are now too many to mention.

* Patrick Massot, and all the other people who have been involved in making
  it possible for a mathematics undergraduate to install Lean without becoming
  an expert in computer science.
  
* Kim Morrison, for explaining that I had missed an opportunity to teach `simp`
  in the natural number game. My excuse: I didn't understand it at the time!
  I hope you like this one better.
