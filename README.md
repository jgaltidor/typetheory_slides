# Type Theory Tutorial Slides

LaTeX (Beamer) source for a slide presentation by John Altidor, first given as a logic seminar lecture in 2013. It introduces type theory as it is used to specify programming languages, through *MiniLang*, a small language of numbers and strings: its syntax, static and dynamic semantics, and proofs of type safety.

**Read the PDF:** [typetheory_slides.pdf](https://jgaltidor.github.io/typetheory_slides/typetheory_slides.pdf) (latest release; [download](https://github.com/jgaltidor/typetheory_slides/releases/latest/download/typetheory_slides.pdf) it instead, or find earlier versions on the [Releases](https://github.com/jgaltidor/typetheory_slides/releases) page).

The slides accompany two other repositories:

- [jgaltidor/typetheory_paper](https://github.com/jgaltidor/typetheory_paper): the tutorial paper that covers the same material in more detail
- [jgaltidor/twelf_tutorial](https://github.com/jgaltidor/twelf_tutorial): the Twelf encoding of MiniLang

[jgaltidor/twelf_slides](https://github.com/jgaltidor/twelf_slides) holds the companion slides on Twelf.

**Status:** these slides date from 2013 and were corrected in October 2026 to match the paper. Where they differ, the paper is authoritative.

## Building

You need a LaTeX distribution that provides `pdflatex` and Beamer, such as TeX Live or MacTeX.

```sh
make            # builds typetheory_slides.pdf
make clean      # removes auxiliary build files
make distclean  # also removes typetheory_slides.pdf
```

For a reproducible build, use the pinned toolchain in `Dockerfile` (a TeX Live 2026 snapshot, pinned by digest; the same image as typetheory_paper, twelf_slides, and the dissertation). The slides build with it with no LaTeX warnings:

```sh
docker build -t typetheory-slides-tex .
docker run --rm -v "$PWD":/workdir typetheory-slides-tex          # runs make
docker run --rm -v "$PWD":/workdir typetheory-slides-tex make clean
```

`.devcontainer/` opens the same image in VS Code, with LaTeX Workshop set to build with `make`. It also installs Claude Code (the VS Code extension and the `claude` CLI), whose login and settings persist in a Docker volume.

Spell checking uses `cspell.json` with the project word list `project-words.txt`; add legitimate new terms there rather than ignoring warnings. Check from the command line with `npx cspell "**/*.tex"`, or in Docker:

```sh
docker run --rm -v "$PWD":/w -w /w node:22-slim npx -y cspell@8 "**/*.tex"
```

It should report 0 issues. In the devcontainer, Code Spell Checker reports spelling and LTeX+ checks grammar; LTeX+'s own spelling rule is disabled so there is a single source of spelling warnings.

GitHub Actions (`.github/workflows/build.yml`) builds the PDF in the pinned image on every push and pull request, and fails if the build reports any LaTeX warning, an overfull or underfull box, or a spelling issue. The built PDF is attached to each run as an artifact.

## Releasing

The PDF is published as a GitHub Release asset, not committed (build outputs are gitignored). Pushing a version tag publishes it: GitHub Actions builds the tag in the pinned image, runs the same checks as every push, and creates the release with the PDF attached. It then publishes that PDF to GitHub Pages at [`https://jgaltidor.github.io/typetheory_slides/typetheory_slides.pdf`](https://jgaltidor.github.io/typetheory_slides/typetheory_slides.pdf), because GitHub serves release assets as downloads, which some browsers (such as Safari on iPhone) save without displaying; to republish it without a new release, run the workflow by hand (`gh workflow run build.yml`). The tag must be annotated; its first line becomes the release title and any further lines become the release notes:

```sh
git tag -a v1.2 -F - <<'EOF'
Type theory tutorial slides v1.2

- What changed in this release.
EOF
git push origin v1.2
```

If a check fails, no release is created. Fix the problem on `master`, then move the tag to the fixed commit and push it again (`git tag -d v1.2`, `git push origin :refs/tags/v1.2`, and tag again).

Keep the asset named `typetheory_slides.pdf`: the README above, the [typetheory_paper](https://github.com/jgaltidor/typetheory_paper) and [twelf_tutorial](https://github.com/jgaltidor/twelf_tutorial) READMEs, and [jgaltidor.github.io](https://jgaltidor.github.io) link to the GitHub Pages copy, which the `pages` job downloads from `releases/latest/download/typetheory_slides.pdf`; both always serve the newest release. The [typetheory_paper](https://github.com/jgaltidor/typetheory_paper) bibliography cites a specific release instead (`typetheory-slides` in `refs.bib`); update it when a release is worth citing.

## License

The slides (their text and LaTeX source) are copyright John Altidor and licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0); see [`LICENSE`](LICENSE). You may share and adapt them, including commercially, as long as you give appropriate credit.
