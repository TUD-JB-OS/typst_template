#import "src/main.typ": thesis_template

// Use this file as the mapping layer between MyST data and the Typst layout.
// It should stay as thin as possible:
// - read metadata, part files, and PDF export options from MyST
// - map them to the argument names expected by src/main.typ
// - leave layout defaults in src/main.typ whenever possible
//
// Navigation notes:
// - `project.*` values are preferred and `doc.*` values are used as fallbacks
// - some MyST values are mapped twice in different shapes for the title page
// - if an argument is omitted here, src/main.typ supplies the default

#show: thesis_template.with(
  // Shared document metadata
  // These values are reused across the cover, title page, and front matter.
[# if project.title #]
  title: "[-project.title-]",
[# elif doc.title #]
  title: "[-doc.title-]",
[# endif #]

[# if project.subtitle #]
  subtitle: "[-project.subtitle-]",
[# elif doc.subtitle #]
  subtitle: "[-doc.subtitle-]",
[# endif #]

[# if project.authors or doc.authors #]
  authors: (
[# if project.authors #]
[# for author in project.authors #]
    "[# if author.name #][-author.name-][# else #][-author-][# endif #]",
[# endfor #]
[# elif doc.authors #]
[# for author in doc.authors #]
    "[# if author.name #][-author.name-][# else #][-author-][# endif #]",
[# endfor #]
[# endif #]
  ),
[# endif #]

[# if options.isbn is defined and options.isbn != none and options.isbn != "" #]
  isbn: "[-options.isbn | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]

[# if project.doi #]
  doi: "[-project.doi | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif doc.doi #]
  doi: "[-doc.doi | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]

[# if project.license is string #]
  document_license: "[-project.license | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif project.license.content is defined and project.license.content.id #]
  document_license: "[-project.license.content.id | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif project.license.content is defined and project.license.content.name #]
  document_license: "[-project.license.content.name | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif doc.license is string #]
  document_license: "[-doc.license | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif doc.license.content is defined and doc.license.content.id #]
  document_license: "[-doc.license.content.id | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif doc.license.content is defined and doc.license.content.name #]
  document_license: "[-doc.license.content.name | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]

  // Keep contributor ids so the title page can group entries such as
  // supervisor-1 and committee-1.
[# if project.contributors or doc.contributors #]
  contributors: (
[# if project.contributors #]
[# for contributor in project.contributors #]
    (
      id: "[# if contributor.id #][-contributor.id-][# else #][# endif #]",
      name: "[# if contributor.name #][-contributor.name-][# else #][-contributor-][# endif #]",
      affiliations: (
[# if contributor.affiliations #]
[# for affiliation_id in contributor.affiliations #]
        "[-affiliation_id-]",
[# endfor #]
[# endif #]
      ),
    ),
[# endfor #]
[# elif doc.contributors #]
[# for contributor in doc.contributors #]
    (
      id: "[# if contributor.id #][-contributor.id-][# else #][# endif #]",
      name: "[# if contributor.name #][-contributor.name-][# else #][-contributor-][# endif #]",
      affiliations: (
[# if contributor.affiliations #]
[# for affiliation_id in contributor.affiliations #]
        "[-affiliation_id-]",
[# endfor #]
[# endif #]
      ),
    ),
[# endfor #]
[# endif #]
  ),
[# endif #]

  // The same affiliation source is mapped in two forms:
  // - `affiliation_catalog` keeps ids for contributor lookup
  // - `affiliations` keeps printable names for simpler title-page rendering
[# if project.affiliations or doc.affiliations #]
  affiliation_catalog: (
[# if project.affiliations #]
[# for aff in project.affiliations #]
    (
      id: "[# if aff.id #][-aff.id-][# else #][# endif #]",
      name: "[# if aff.institution #][-aff.institution-][# elif aff.name #][-aff.name-][# else #][-aff-][# endif #]",
    ),
[# endfor #]
[# elif doc.affiliations #]
[# for aff in doc.affiliations #]
    (
      id: "[# if aff.id #][-aff.id-][# else #][# endif #]",
      name: "[# if aff.institution #][-aff.institution-][# elif aff.name #][-aff.name-][# else #][-aff-][# endif #]",
    ),
[# endfor #]
[# endif #]
  ),
[# endif #]

[# if project.affiliations or doc.affiliations #]
  affiliations: (
[# if project.affiliations #]
[# for aff in project.affiliations #]
    "[# if aff.institution #][-aff.institution-][# elif aff.name #][-aff.name-][# else #][-aff-][# endif #]",
[# endfor #]
[# elif doc.affiliations #]
[# for aff in doc.affiliations #]
    "[# if aff.institution #][-aff.institution-][# elif aff.name #][-aff.name-][# else #][-aff-][# endif #]",
[# endfor #]
[# endif #]
  ),
[# endif #]

  // MyST dates are structured values, so this mapping flattens them into a simple string.
[# if project.date #]
  date: "[-project.date.day-]-[-project.date.month-]-[-project.date.year-]",
[# elif doc.date #]
  date: "[-doc.date.day-]-[-doc.date.month-]-[-doc.date.year-]",
[# endif #]

[# if project.keywords or doc.keywords #]
  keywords: (
[# if project.keywords #]
[# for keyword in project.keywords #]
    "[-keyword-]",
[# endfor #]
[# elif doc.keywords #]
[# for keyword in doc.keywords #]
    "[-keyword-]",
[# endfor #]
[# endif #]
  ),
[# endif #]

  // Thesis-specific metadata
  // Use these fields for the academic labels shown on the detailed title-page layouts.
[# if options.thesis_degree #]
  thesis_degree: "[-options.thesis_degree-]",
[# endif #]
[# if options.thesis_program #]
  thesis_program: "[-options.thesis_program-]",
[# endif #]
[# if options.thesis_track #]
  thesis_track: "[-options.thesis_track-]",
[# endif #]
[# if options.thesis_faculty #]
  thesis_faculty: "[-options.thesis_faculty-]",
[# endif #]
[# if options.thesis_institution #]
  thesis_institution: "[-options.thesis_institution-]",
[# endif #]
[# if options.thesis_defense_date #]
  thesis_defense_date: "[-options.thesis_defense_date-]",
[# endif #]

  // Optional front-matter part files
  // These come from separate MyST part files and are rendered before the main chapters.
[# if parts.abstract #]
  abstract: [
[-parts.abstract-]
  ],
[# endif #]
[# if parts.preface #]
  preface: [
[-parts.preface-]
  ],
[# endif #]
[# if parts.acknowledgements #]
  acknowledgements: [
[-parts.acknowledgements-]
  ],
[# endif #]
[# if parts.dedication #]
  dedication: [
[-parts.dedication-]
  ],
[# endif #]
[# if parts.colophon #]
  colophon: [
[-parts.colophon-]
  ],
[# endif #]

  // Document structure and front matter
[# if options.show_cover_full is defined #]
  show_cover_full: [-options.show_cover_full-],
[# endif #]
[# if options.show_title_page is defined #]
  show_title_page: [-options.show_title_page-],
[# endif #]
[# if options.show_contributor_affiliations is defined #]
  show_contributor_affiliations: [-options.show_contributor_affiliations-],
[# endif #]
[# if options.frontmatter_order is defined and options.frontmatter_order != none and options.frontmatter_order != "" #]
[# if options.frontmatter_order is string #]
  frontmatter_order: "[-options.frontmatter_order-]",
[# else #]
  frontmatter_order: (
[# for item in options.frontmatter_order #]
    "[-item-]",
[# endfor #]
  ),
[# endif #]
[# endif #]
[# if options.show_toc is defined #]
  show_toc: [-options.show_toc-],
[# endif #]
[# if options.show_list_of_figures is defined #]
  show_list_of_figures: [-options.show_list_of_figures-],
[# endif #]
[# if options.show_list_of_tables is defined #]
  show_list_of_tables: [-options.show_list_of_tables-],
[# endif #]
[# if options.toc_depth is defined and options.toc_depth != none #]
  toc_depth: [-options.toc_depth-],
[# endif #]
[# if options.show_verso_blank_page_statement is defined #]
  show_verso_blank_page_statement: [-options.show_verso_blank_page_statement-],
[# endif #]
[# if options.verso_blank_page_statement is defined and options.verso_blank_page_statement != none and options.verso_blank_page_statement != "" #]
  verso_blank_page_statement: "[-options.verso_blank_page_statement-]",
[# endif #]

  // Page layout
[# if options.paper_size is defined and options.paper_size != none and options.paper_size != "" #]
  paper_size: "[-options.paper_size-]",
[# endif #]
[# if options.margin_top_cm is defined and options.margin_top_cm != none #]
  margin_top_cm: [-options.margin_top_cm-]cm,
[# endif #]
[# if options.margin_bottom_cm is defined and options.margin_bottom_cm != none #]
  margin_bottom_cm: [-options.margin_bottom_cm-]cm,
[# endif #]
[# if options.margin_left_cm is defined and options.margin_left_cm != none #]
  margin_left_cm: [-options.margin_left_cm-]cm,
[# endif #]
[# if options.margin_right_cm is defined and options.margin_right_cm != none #]
  margin_right_cm: [-options.margin_right_cm-]cm,
[# endif #]

  // Typography
  // Font family options are only passed when they are set explicitly.
  // Otherwise src/main.typ keeps the template's built-in fallback families.
[# if options.font_body #]
  font_body: "[-options.font_body-]",
[# endif #]
[# if options.font_mono #]
  font_mono: "[-options.font_mono-]",
[# endif #]
[# if options.font_math #]
  font_math: "[-options.font_math-]",
[# endif #]
[# if options.font_size_pt is defined and options.font_size_pt != none #]
  font_size_pt: [-options.font_size_pt-]pt,
[# endif #]
[# if options.line_spacing_em is defined and options.line_spacing_em != none #]
  line_spacing_em: [-options.line_spacing_em-]em,
[# endif #]

  // Bibliography
  // The bibliography file comes from MyST itself, while the remaining settings
  // come from the PDF export options.
[# if doc.bibtex #]
  bibliography_file: "[-doc.bibtex-]",
[# endif #]
[# if options.show_bibliography is defined #]
  show_bibliography: [-options.show_bibliography-],
[# endif #]
[# if options.bibliography_title #]
  bibliography_title: "[-options.bibliography_title-]",
[# endif #]
[# if options.bibliography_style #]
  bibliography_style: "[-options.bibliography_style-]",
[# endif #]
[# if options.bibliography_numbered_heading is defined #]
  bibliography_numbered_heading: [-options.bibliography_numbered_heading-],
[# endif #]

  // Shared assets and branding
  // If no custom files are provided, src/main.typ falls back to the bundled template assets.
[# if options.logo #]
  logo: "[-options.logo-]",
[# endif #]

  // Cover-page options
[# if options.cover_page_variant #]
  cover_page_variant: "[-options.cover_page_variant-]",
[# endif #]
[# if options.show_cover_subtitle is defined #]
  show_cover_subtitle: [-options.show_cover_subtitle-],
[# endif #]
[# if options.cover_background_image #]
  cover_background_image: "[-options.cover_background_image-]",
[# elif options.cover_image #]
  cover_background_image: "[-options.cover_image-]",
[# endif #]
[# if options.cover_graphical_appearance #]
  cover_graphical_appearance: "[-options.cover_graphical_appearance-]",
[# endif #]
[# if options.cover_graphical_alignment is defined and options.cover_graphical_alignment != none and options.cover_graphical_alignment != "" #]
  cover_graphical_alignment: "[-options.cover_graphical_alignment-]",
[# endif #]
[# if options.cover_title_text_color is defined and options.cover_title_text_color != none and options.cover_title_text_color != "" #]
  cover_title_text_color: "[-options.cover_title_text_color-]",
[# endif #]
[# if options.cover_title_weight is defined and options.cover_title_weight != none and options.cover_title_weight != "" #]
  cover_title_weight: "[-options.cover_title_weight-]",
[# endif #]
[# if options.cover_subtitle_weight is defined and options.cover_subtitle_weight != none and options.cover_subtitle_weight != "" #]
  cover_subtitle_weight: "[-options.cover_subtitle_weight-]",
[# endif #]
[# if options.cover_author_weight is defined and options.cover_author_weight != none and options.cover_author_weight != "" #]
  cover_author_weight: "[-options.cover_author_weight-]",
[# endif #]
[# if options.cover_bottom_text_color is defined and options.cover_bottom_text_color != none and options.cover_bottom_text_color != "" #]
  cover_bottom_text_color: "[-options.cover_bottom_text_color-]",
[# endif #]
[# if options.cover_title_box_color is defined and options.cover_title_box_color != none and options.cover_title_box_color != "" #]
  cover_title_box_color: "[-options.cover_title_box_color-]",
[# endif #]
[# if options.cover_title_box_text is defined and options.cover_title_box_text != none and options.cover_title_box_text != "" #]
  cover_title_box_text: "[-options.cover_title_box_text-]",
[# endif #]
[# if options.cover_title_box_opacity_pct is defined #]
  cover_title_box_opacity_pct: [-options.cover_title_box_opacity_pct-],
[# endif #]
[# if options.show_cover_bottom_ribbon is defined #]
  show_cover_bottom_ribbon: [-options.show_cover_bottom_ribbon-],
[# endif #]
[# if options.cover_bottom_ribbon_color is defined and options.cover_bottom_ribbon_color != none and options.cover_bottom_ribbon_color != "" #]
  cover_bottom_ribbon_color: "[-options.cover_bottom_ribbon_color-]",
[# endif #]
[# if options.cover_bottom_ribbon_opacity_pct is defined #]
  cover_bottom_ribbon_opacity_pct: [-options.cover_bottom_ribbon_opacity_pct-],
[# endif #]
[# if options.cover_logo_variant is defined and options.cover_logo_variant != none and options.cover_logo_variant != "" #]
  cover_logo_variant: "[-options.cover_logo_variant-]",
[# endif #]
[# if options.cover_logo_white #]
  cover_logo_white: "[-options.cover_logo_white-]",
[# endif #]
[# if options.cover_logo_black #]
  cover_logo_black: "[-options.cover_logo_black-]",
[# endif #]
[# if options.cover_logo_text is defined and options.cover_logo_text != none and options.cover_logo_text != "" #]
  cover_logo_text: "[-options.cover_logo_text-]",
[# endif #]
[# if options.cover_bottom_block_dy_cm is defined and options.cover_bottom_block_dy_cm != none #]
  cover_bottom_block_dy_cm: [-options.cover_bottom_block_dy_cm-]cm,
[# endif #]

  // Title-page options
[# if options.title_page_variant #]
  title_page_variant: "[-options.title_page_variant-]",
[# endif #]
[# if options.title_page_basic_title_alignment is defined and options.title_page_basic_title_alignment != none and options.title_page_basic_title_alignment != "" #]
  title_page_basic_title_alignment: "[-options.title_page_basic_title_alignment-]",
[# endif #]
[# if options.title_page_basic_table_alignment is defined and options.title_page_basic_table_alignment != none and options.title_page_basic_table_alignment != "" #]
  title_page_basic_table_alignment: "[-options.title_page_basic_table_alignment-]",
[# endif #]
[# if options.title_page_logo_alignment is defined and options.title_page_logo_alignment != none and options.title_page_logo_alignment != "" #]
  title_page_logo_alignment: "[-options.title_page_logo_alignment-]",
[# endif #]
[# if options.title_page_formal_statement is defined and options.title_page_formal_statement != none and options.title_page_formal_statement != "" #]
  title_page_formal_statement: "[-options.title_page_formal_statement | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]

  // Colophon options
[# if options.show_colophon_publication_info is defined #]
  show_colophon_publication_info: [-options.show_colophon_publication_info-],
[# endif #]
[# if options.show_colophon_cover_description is defined #]
  show_colophon_cover_description: [-options.show_colophon_cover_description-],
[# elif options.show_title_page_cover_description is defined #]
  show_colophon_cover_description: [-options.show_title_page_cover_description-],
[# endif #]
[# if options.colophon_cover_description is defined and options.colophon_cover_description != none and options.colophon_cover_description != "" #]
  colophon_cover_description: "[-options.colophon_cover_description | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif options.title_page_cover_description #]
  colophon_cover_description: "[-options.title_page_cover_description | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.show_colophon_confidentiality_statement is defined #]
  show_colophon_confidentiality_statement: [-options.show_colophon_confidentiality_statement-],
[# elif options.show_title_page_confidentiality_statement is defined #]
  show_colophon_confidentiality_statement: [-options.show_title_page_confidentiality_statement-],
[# endif #]
[# if options.colophon_confidentiality_statement is defined and options.colophon_confidentiality_statement != none and options.colophon_confidentiality_statement != "" #]
  colophon_confidentiality_statement: "[-options.colophon_confidentiality_statement | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# elif options.title_page_confidentiality_statement #]
  colophon_confidentiality_statement: "[-options.title_page_confidentiality_statement | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.colophon_printer is defined and options.colophon_printer != none and options.colophon_printer != "" #]
  colophon_printer: "[-options.colophon_printer | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.colophon_publisher is defined and options.colophon_publisher != none and options.colophon_publisher != "" #]
  colophon_publisher: "[-options.colophon_publisher | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.colophon_copyright is defined and options.colophon_copyright != none and options.colophon_copyright != "" #]
  colophon_copyright: "[-options.colophon_copyright | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.colophon_custom_text is defined and options.colophon_custom_text != none and options.colophon_custom_text != "" #]
  colophon_custom_text: "[-options.colophon_custom_text | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.colophon_company_logo #]
  colophon_company_logo: "[-options.colophon_company_logo | replace("\\", "\\\\") | replace("\"", "\\\"") | replace("\n", "\\n")-]",
[# endif #]
[# if options.show_colophon_watermark is defined #]
  show_colophon_watermark: [-options.show_colophon_watermark-],
[# endif #]
)

// MyST adds helper imports here.
[-IMPORTS-]

// MyST adds the ordered document content here.
[-CONTENT-]
