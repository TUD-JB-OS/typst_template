# MyST + Typst Thesis Scaffold

This project keeps one shared metadata source for MyST and Typst while isolating PDF layout in a Typst template.

## Build
- PDF build: `myst build --typst`
- Site build: `myst build --site`

## Shared vs PDF-only configuration
- Shared semantics: `myst.yml`, `config/options.yml`, `config/people.yml`, and `content/parts/*.md`
- Thesis semantic fields live under `project.options.thesis_*`; people are in `project.authors` (students) and `project.contributors` (use `supervisor-*` / `committee-*` IDs).
- PDF layout knobs: `config/exports/typst_config.yml`
- Cover options are split from title-page options (`cover_background_image` vs `title_page_image`).
- Variant entry points exist in `templates/thesis-typst/src/layout/cover.typ` and `templates/thesis-typst/src/layout/titlepage.typ`.
- Typst rendering logic: `templates/thesis-typst/src/*`
- Part-file references for export are declared in `myst.yml` via `project.parts.*`.
