# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a PhD dissertation LaTeX project titled "Probabilistic Deep Learning for Uncertainty Quantification and Decision-Making" using the UC San Diego dissertation class (`ucsddissertation.cls`). The dissertation is organized into multiple parts with each chapter representing a separate research paper.

## Building the Document

### Compile the dissertation
```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

The main output is `main.pdf`. Auxiliary files (.aux, .log, .toc, .lof, .lot, .out) are generated during compilation.

### Clean build artifacts
```bash
rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
```

## Architecture

### Document Structure

The dissertation follows a modular chapter-based structure:

- `main.tex` - Root document that orchestrates the entire dissertation structure
- `math_commands.tex` - Shared mathematical notation, theorem environments, and LaTeX macros used across all chapters
- `references.bib` - Centralized BibTeX bibliography for all chapters
- `ucsddissertation.cls` - UC San Diego dissertation LaTeX class file (formatting requirements)

### Chapter Organization

Each chapter is in its own directory and represents a separate research paper:

- `introduction/` - Dissertation introduction with background, significance, and problem statement
- `equivariance/` - Chapter on probabilistic equivariance for dynamics modeling
- `copula/` - Chapter on copula conformal prediction for multi-step time series
- `changepoints/` - Chapter on conformal prediction for time series with change points
- `anomaly/` - Chapter on online adaptive anomaly thresholding with confidence sequences

Each chapter directory contains:
- `main.tex` - Chapter's main content (sections are included from here)
- `sec/` or `secs/` subdirectory with individual section files (intro.tex, methods.tex, exp.tex, app.tex, etc.)

The `permission/` directory contains permission/copyright acknowledgments for published work.

### Mathematical Notation System

The `math_commands.tex` file defines a comprehensive notation system:

- Vectors: `\vx`, `\vy`, `\vz` (bold lowercase)
- Matrices: `\mA`, `\mB`, `\mC` (bold uppercase)
- Random variables: `\rx`, `\ry`, `\rz` (textnormal)
- Random vectors: `\rvx`, `\rvy`, `\rvz` (bold)
- Sets: `\sA`, `\sB`, `\sC` (mathbb)
- Calligraphic: `\gA`, `\gB`, `\gC` (mathcal for graphs/spaces)
- Tensors: `\tA`, `\tB`, `\tC` (special sans-serif bold italic)
- Theorem environments: theorem, lemma, proposition, corollary, definition, assumption, remark
- Reference macros: `\figref{}`, `\secref{}`, `\eqref{}`, `\chapref{}`, `\algref{}`
- Common symbols: `\E` (expectation), `\Prob` (probability), `\Var` (variance), `\Cov` (covariance)
- Dataset notation: `\Dcal`, `\Dtrain`, `\Dtest`, `\Dcalone`, `\Dcaltwo`

### Git Context

This is an Overleaf-synced repository (remote: git.overleaf.com). The main branch is `master`.

## Working with Chapters

### Adding content to an existing chapter

1. Navigate to the appropriate chapter directory (e.g., `equivariance/`, `copula/`)
2. Edit section files in the `sec/` or `secs/` subdirectory
3. Each chapter's `main.tex` uses `\input{}` to include sections
4. Recompile from the root directory using `pdflatex main.tex`

### Chapter structure pattern

Most chapters follow this structure:
- `intro.tex` - Introduction and motivation
- `background.tex` or `problem.tex` - Problem formulation and background
- `methods.tex` - Proposed methods
- `exp.tex` - Experiments
- `related.tex` - Related work
- `app.tex` - Appendix

### Using math commands

Always use the predefined macros from `math_commands.tex` for consistency:
- For vectors, use `\vx`, `\vy`, not `\mathbf{x}`
- For matrices, use `\mA`, `\mB`, not `\mathbf{A}`
- For references, use `\figref{label}`, `\secref{label}`, not `Figure~\ref{label}`
- For theorems, use the predefined environments: `\begin{theorem}...\end{theorem}`

### Bibliography

- Add new references to `references.bib` (shared across all chapters)
- Use BibTeX entries with consistent formatting
- The bibliography style is `plain` (defined in `main.tex`)
