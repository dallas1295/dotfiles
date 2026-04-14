---
id: Intro
aliases:
  - C Course
tags:
  - coding
  - learning
  - c
---

# C as a language

C was written in the early 70's as a method without ANSI standards.
Before C most people wrote Assembly or Fortran, mostly math focused langugages.

Most languages prior to C were specific DSL-like languages.

C's initial purpose was to have a "Unified" language that could be used for software development.

It's an important language because it was the historical "beginning" of software as we know it.
It's flippin hard and will be slow. And chances of finding a C job are slim, nonetheless it's important to learn.

## Challenges and Futures

- It lacks string types and they aren't safe.
- no dynamic memory allocations in the core types/libraries
- currently C++ is thought of as more powerful and more flexible for systems work.
- Java/JS/C#/Python types are objects and abstracted away -- not suitable for systems work
- Rust is most likely the future of systems dev do to it's safety and zero-cost abstractions

# Python vs C

| Python                    | C                                |
| ------------------------- | -------------------------------- |
| Whitespace is important   | Whitespace isn't important       |
| OOP Focus                 | Not very OOP Focused             |
| Covenient Data structures | Fast & Efficient but not builtin |
| Garbage Collected         | Manual Memory management         |
| Developed in the 80's     | Developed in the 70's            |

Python is supposed to be quick and easy for interation, while C isn't as quick but makes up for it in speed.
Both products of their times and were built to solve different purposes but Python is built on top of C.

## Types and Differences

### Similarities

Python and C both have these types:

- int
- float
- char
- byte

### Differences

However C **DOES NOT** have str, list, or dict; And Python **DOES NOT** have structs or doubles.

\*_A double is is precision floating-point number that can have 15-17 decimals. it's like a f64 from Rust._

- Ternary operators in python are words: and, not, or. in C: &&, !, ||.
- In C, there is no determinant for loop. No pre-defined True or False.
- None and NULL are **NOT** the same thing:
  - None is an _empty_ value. **NULL is 0**.
- Strings and char arrays are similar but also **very** different.
