# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

LaTeX Beamer source for a 2013 "Type Theory Tutorial" slide deck (logic seminar lecture by John Altidor). It presents *MiniLang*, a small language of numbers and strings: syntax, static semantics (typing rules), dynamic semantics (small-step evaluation), and the type safety proof (preservation + progress, including the substitution lemma). There is no code to test; the only artifact is the PDF.

Related repos: `jgaltidor/typetheory_paper` (the companion paper, which is authoritative where it differs from these slides, since it has later corrections), `jgaltidor/twelf_tutorial` (Twelf encoding of MiniLang), and `jgaltidor/twelf_slides`.

## Build

Requires `pdflatex` with Beamer (TeX Live / MacTeX).

```sh
make            # runs pdflatex twice -> typetheory_slides.pdf
make clean      # remove auxiliary files
make distclean  # also remove the PDF
```

pdflatex runs twice so the frame counter (`\inserttotalframenumber` in the footer) and the navigation/TOC data are correct. Build outputs, including the PDF, are gitignored.

## Structure

- `typetheory_slides.tex`: the whole deck. Each `\section` wraps one or more `frame`s, and `\pause` builds content up step by step.
- `mymacros.tex`: shared macros pulled in with `\input`. Read it before you edit any slide content, because the slides depend on its custom definitions:
  - `\infer` (from the `proof` package) is **redefined** so that its optional rule-name argument is set in `\scriptsize\texttt`. Related wrappers are `\myinfer`, `\cinfer`, `\ttinfer`, `\spcinfer`, and `\judge`.
  - `\code{...}` sets small typewriter text, and `\cemph` highlights in red.
  - Grammar and semantics notation: `\bnfdef`, `\bnfalt`, `\subst{e'}{x}{e}`, `\stepto`, `\stepsto`, `\trans`, `\transs`, `\subtype`.
- `typetheory_slides.tex` also redefines `\emph` as bold italic.
