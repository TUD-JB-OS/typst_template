# Metadata Mapping

This template keeps semantic metadata in shared MyST config files and maps those values in `template.typ`.

## Shared keys to template arguments
- `project.title` -> `title`
- `project.subtitle` -> `subtitle`
- `project.authors` (fallback `doc.authors`) -> `authors` (students shown on cover/title author line)
- `project.contributors` (fallback `doc.contributors`) -> `contributors`
- `project.affiliations` (fallback `doc.affiliations`) -> `affiliation_catalog` (for contributor affiliation resolution)
- `project.affiliations` (fallback `doc.affiliations`) -> `affiliations`
- `project.date` (fallback `doc.date`) -> `date`
- `project.keywords` (fallback `doc.keywords`) -> `keywords`
- `project.options.thesis_degree` -> `options.thesis_degree` -> `thesis_degree`
- `project.options.thesis_program` -> `options.thesis_program` -> `thesis_program`
- `project.options.thesis_faculty` -> `options.thesis_faculty` -> `thesis_faculty`
- `project.options.thesis_institution` -> `options.thesis_institution` -> `thesis_institution`
- `project.options.thesis_defense_date` -> `options.thesis_defense_date` -> `thesis_defense_date`
- `project.contributors[*].id` matching `supervisor*` or `advisor*` -> title page supervisor row
- `project.contributors[*].id` matching `committee*` or `examiner*` -> title page committee row
- `project.contributors[*].affiliations[*]` + `project.affiliations[*]` -> contributor affiliation line under each supervisor/committee name

## Parts to template arguments
- `parts.abstract` -> `abstract`
- `parts.preface` -> `preface`
- `parts.acknowledgements` -> `acknowledgements`
- `parts.dedication` -> `dedication`
- `parts.colophon` -> `colophon`

Part files are referenced in `myst.yml` via `project.parts.*`.

## Options to template arguments
All PDF-only options are read from `config/exports/typst_config.yml` and mapped to `thesis_template` arguments in `template.typ`.

Examples of PDF-only options:
- `options.show_cover_full`
- `options.show_title_page`
- `options.show_title_page_image`
- `options.show_contributor_affiliations`
- `options.show_toc`
- `options.paper_size`
- `options.logo`
- `options.cover_page_variant`
- `options.cover_background_image`
- `options.cover_title_box_opacity_pct`
- `options.title_page_variant`
- `options.title_page_image`
- `options.title_page_image_anchor`
- `options.title_page_image_width_cm`
- `options.title_page_image_height_cm`
- `options.title_page_image_dx_cm`
- `options.title_page_image_dy_cm`
