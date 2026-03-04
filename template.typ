#import "src/main.typ": thesis_template
#import "src/components/bibliography.typ": render_bibliography

#show: thesis_template.with(
[# if project.title #]
  title: "[-project.title-]",
[# elif doc.title #]
  title: "[-doc.title-]",
[# else #]
  title: "Untitled Thesis",
[# endif #]

[# if project.subtitle #]
  subtitle: "[-project.subtitle-]",
[# elif doc.subtitle #]
  subtitle: "[-doc.subtitle-]",
[# else #]
  subtitle: none,
[# endif #]

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

[# if project.date #]
  date: "[-project.date.day-]-[-project.date.month-]-[-project.date.year-]",
[# elif doc.date #]
  date: "[-doc.date.day-]-[-doc.date.month-]-[-doc.date.year-]",
[# else #]
  date: none,
[# endif #]

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

  thesis_degree: [# if options.thesis_degree #]"[-options.thesis_degree-]"[# else #]none[# endif #],
  thesis_program: [# if options.thesis_program #]"[-options.thesis_program-]"[# else #]none[# endif #],
  thesis_faculty: [# if options.thesis_faculty #]"[-options.thesis_faculty-]"[# else #]none[# endif #],
  thesis_institution: [# if options.thesis_institution #]"[-options.thesis_institution-]"[# else #]none[# endif #],
  thesis_defense_date: [# if options.thesis_defense_date #]"[-options.thesis_defense_date-]"[# else #]none[# endif #],

  abstract: [# if parts.abstract #]"[-parts.abstract-]"[# else #]none[# endif #],
  preface: [# if parts.preface #]"[-parts.preface-]"[# else #]none[# endif #],
  acknowledgements: [# if parts.acknowledgements #]"[-parts.acknowledgements-]"[# else #]none[# endif #],
  dedication: [# if parts.dedication #]"[-parts.dedication-]"[# else #]none[# endif #],
  colophon: [# if parts.colophon #]"[-parts.colophon-]"[# else #]none[# endif #],

  show_cover_full: [# if options.show_cover_full is defined #][-options.show_cover_full-][# else #]true[# endif #],
  show_title_page: [# if options.show_title_page is defined #][-options.show_title_page-][# else #]true[# endif #],
  show_contributor_affiliations: [# if options.show_contributor_affiliations is defined #][-options.show_contributor_affiliations-][# else #]true[# endif #],
  show_toc: [# if options.show_toc is defined #][-options.show_toc-][# else #]true[# endif #],
  show_list_of_figures: [# if options.show_list_of_figures is defined #][-options.show_list_of_figures-][# else #]false[# endif #],
  show_list_of_tables: [# if options.show_list_of_tables is defined #][-options.show_list_of_tables-][# else #]false[# endif #],

  frontmatter_numbering: "[# if options.frontmatter_numbering #][-options.frontmatter_numbering-][# else #]roman[# endif #]",
  mainmatter_numbering: "[# if options.mainmatter_numbering #][-options.mainmatter_numbering-][# else #]arabic[# endif #]",

  paper_size: "[# if options.paper_size #][-options.paper_size-][# else #]a4[# endif #]",
  margin_top_cm: [# if options.margin_top_cm #][-options.margin_top_cm-]cm[# else #]2.5cm[# endif #],
  margin_bottom_cm: [# if options.margin_bottom_cm #][-options.margin_bottom_cm-]cm[# else #]2.5cm[# endif #],
  margin_left_cm: [# if options.margin_left_cm #][-options.margin_left_cm-]cm[# else #]3.0cm[# endif #],
  margin_right_cm: [# if options.margin_right_cm #][-options.margin_right_cm-]cm[# else #]2.0cm[# endif #],

  font_body: "[# if options.font_body #][-options.font_body-][# else #]Libertinus Serif[# endif #]",
  font_mono: "[# if options.font_mono #][-options.font_mono-][# else #]Consolas[# endif #]",
  font_size_pt: [# if options.font_size_pt #][-options.font_size_pt-]pt[# else #]11pt[# endif #],
  line_spacing_em: [# if options.line_spacing_em #][-options.line_spacing_em-]em[# else #]1.35em[# endif #],

  toc_depth: [# if options.toc_depth #][-options.toc_depth-][# else #]3[# endif #],
  logo: [# if options.logo #]"[-options.logo-]"[# else #]none[# endif #],
  cover_page_variant: "[# if options.cover_page_variant #][-options.cover_page_variant-][# else #]simple[# endif #]",
  cover_background_image: [# if options.cover_background_image #]"[-options.cover_background_image-]"[# elif options.cover_image #]"[-options.cover_image-]"[# else #]none[# endif #],
  cover_title_box_opacity_pct: [# if options.cover_title_box_opacity_pct is defined #][-options.cover_title_box_opacity_pct-][# else #]55[# endif #],
  title_page_variant: "[# if options.title_page_variant #][-options.title_page_variant-][# else #]1[# endif #]",
  show_title_page_image: [# if options.show_title_page_image is defined #][-options.show_title_page_image-][# else #]true[# endif #],
  title_page_image: [# if options.title_page_image #]"[-options.title_page_image-]"[# else #]none[# endif #],
  title_page_image_anchor: [# if options.title_page_image_anchor is defined and options.title_page_image_anchor != none and options.title_page_image_anchor != "" #]"[-options.title_page_image_anchor-]"[# else #]none[# endif #],
  title_page_image_width_cm: [# if options.title_page_image_width_cm is defined and options.title_page_image_width_cm != none #][-options.title_page_image_width_cm-]cm[# else #]none[# endif #],
  title_page_image_height_cm: [# if options.title_page_image_height_cm is defined and options.title_page_image_height_cm != none #][-options.title_page_image_height_cm-]cm[# else #]none[# endif #],
  title_page_image_dx_cm: [# if options.title_page_image_dx_cm is defined and options.title_page_image_dx_cm != none #][-options.title_page_image_dx_cm-]cm[# else #]none[# endif #],
  title_page_image_dy_cm: [# if options.title_page_image_dy_cm is defined and options.title_page_image_dy_cm != none #][-options.title_page_image_dy_cm-]cm[# else #]none[# endif #]
)


[-IMPORTS-]

[-CONTENT-]

[# if doc.bibtex #]
#render_bibliography(path: "[-doc.bibtex-]")
[# endif #]