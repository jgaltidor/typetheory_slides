# Frozen LaTeX toolchain for rebuilding the slides.
#
# Pinned to a TeX Live 2026 weekly snapshot (scheme-full) from the Island of
# TeX images, by digest, so the toolchain can never change underneath the
# slides. This is the same image as the typetheory_paper, twelf_slides, and
# dissertation repositories. The slides build with it with no LaTeX warnings
# and no overfull boxes.
#
# Build the PDF:
#   docker build -t typetheory-slides-tex .
#   docker run --rm -v "$PWD":/workdir typetheory-slides-tex
FROM registry.gitlab.com/islandoftex/images/texlive:TL2026-2026-09-20-full@sha256:7334b00bf8e7a0996f7ddd65482363aaf7711d372e569f3ea78509619e3083ff

WORKDIR /workdir
CMD ["make"]
