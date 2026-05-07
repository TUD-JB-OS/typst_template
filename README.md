# MyST + Typst Thesis Template

This project keeps one shared metadata source for MyST and Typst while isolating PDF layout in a Typst template.

## Build
- PDF build: `myst build --typst`

## Template Design
The layout and style of the book are defined in file style.typ, where the cover page is specified, followed by the preface and table of contents pages. Next, the layout for the book contents is set, using a left margin of 20%.

File template.typ "reads" the content from the myst.yml file and makes it available for style.typ. File aside_style.typ helps to convert MyST aside to Typst notes.

## Note
Several fallback options (logo & background image) have been built in which only work when the template is downloaded.

## Shared vs PDF-only configuration
- Shared semantics: `myst.yml`, `config/options.yml`, `config/people.yml`, and `content/parts/*.md`
- Thesis semantic fields live under `project.options.thesis_*`; people are in `project.authors` (students) and `project.contributors` (use `supervisor-*` / `committee-*` IDs).
- PDF layout knobs: `config/exports/typst_config.yml`
- Cover, title-page, and colophon options are kept separate in the Typst export config.
- Variant entry points exist in `templates/thesis-typst/src/layout/cover.typ` and `templates/thesis-typst/src/layout/titlepage.typ`; the automated publication colophon lives in `templates/thesis-typst/src/layout/colophon.typ`.
- Typst rendering logic: `templates/thesis-typst/src/*`
- Part-file references for export are declared in `myst.yml` via `project.parts.*`.
