# Type Theory Tutorial Slides

LaTeX (Beamer) source for a slide presentation by John Altidor, first given as a logic seminar lecture in 2013. It introduces type theory as it is used to specify programming languages, through *MiniLang*, a small language of numbers and strings: its syntax, static and dynamic semantics, and proofs of type safety.

The slides accompany two other repositories:

- [jgaltidor/typetheory_paper](https://github.com/jgaltidor/typetheory_paper): the tutorial paper that covers the same material in more detail
- [jgaltidor/twelf_tutorial](https://github.com/jgaltidor/twelf_tutorial): the Twelf encoding of MiniLang

[jgaltidor/twelf_slides](https://github.com/jgaltidor/twelf_slides) holds the companion slides on Twelf.

**Status:** these slides date from 2013 and predate later corrections to the paper. Where they differ, the paper is authoritative.

## Building

You need a LaTeX distribution that provides `pdflatex` and Beamer, such as TeX Live or MacTeX.

```sh
make            # builds typetheory_slides.pdf
make clean      # removes auxiliary build files
make distclean  # also removes typetheory_slides.pdf
```

## License

The slides (their text and LaTeX source) are copyright John Altidor and licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0); see [`LICENSE`](LICENSE). You may share and adapt them, including commercially, as long as you give appropriate credit.
