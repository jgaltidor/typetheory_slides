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

Pinned toolchain: `docker build -t typetheory-slides-tex .` then `docker run --rm -v "$PWD":/workdir typetheory-slides-tex` (runs `make`). The `Dockerfile` pins the same TeX Live 2026 image, by digest, as the other repos; `.devcontainer/` uses it too, and its LTeX+ settings list the deck's prose macros. Release PDFs are built with this image. The deck builds with no LaTeX or font warnings and no overfull boxes, so any such message in `typetheory_slides.log` is new.

pdflatex runs twice so the frame counter (`\inserttotalframenumber` in the footer) and the navigation/TOC data are correct. Build outputs, including the PDF, are gitignored. The PDF is published as a GitHub Release asset named `typetheory_slides.pdf` (the twelf_tutorial README links to `releases/latest/download/typetheory_slides.pdf`); pushing an annotated `v*` tag makes the `release` job in `.github/workflows/build.yml` build the tag, run the checks, and create the release (title from the tag's first line, notes from the rest); see the README's "Releasing" section.

Spell check, configured as in typetheory_paper: `docker run --rm -v "$PWD":/w -w /w node:22-slim npx -y cspell@8 "**/*.tex"` must report 0 issues. Add legitimate new terms to `project-words.txt`.

CI: `.github/workflows/build.yml` runs the Docker build, then fails if `typetheory_slides.log` has a warning or an overfull or underfull box, or if cspell reports an issue. Keep the build clean, or the push turns red; if a new message is genuinely expected, change the check in the workflow and the note here together. Dependabot (`.github/dependabot.yml`) opens monthly pull requests to bump the SHA-pinned GitHub Actions.

## Structure

- `typetheory_slides.tex`: the whole deck. Each `\section` wraps one or more `frame`s, and `\pause` builds content up step by step.
- `mymacros.tex`: shared macros pulled in with `\input`. Read it before you edit any slide content, because the slides depend on its custom definitions:
  - `\infer` (from the `proof` package) is **redefined** so that its optional rule-name argument is set in `\scriptsize\texttt`. Related wrappers are `\cinfer` (conclusion in `\code`) and `\ttinfer` (conclusion in `\texttt`).
  - `\code{...}` sets small typewriter text, and `\cemph` highlights in red. `\code` and the `\infer` rule labels wrap their text in `\text{...}` so they work inside math; keep size changes inside `\text` rather than using `\begin{small}` in math.
  - Grammar and semantics notation: `\bnfdef`, `\bnfalt`, `\stepto`.
- `typetheory_slides.tex` also redefines `\emph` as bold italic.
