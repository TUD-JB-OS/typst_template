#import "layout/cover.typ": cover_page
#import "layout/titlepage.typ": title_page
#import "layout/frontmatter.typ": render_frontmatter
#import "layout/bibliography.typ": render_bibliography
#import "assets/assets.typ": resolve_logo_for_layout

// Use this file as the main Typst layout entry point for the template.
// It receives normalized metadata, part files, and export options from template.typ,
// applies the global page and text styling, and then assembles the cover page,
// title page, front matter, main content, and bibliography.

////////////////////////////////////////////////////////////////////////
// This is the main template function that assembles the whole document.
////////////////////////////////////////////////////////////////////////

#let thesis_template(
  // Shared document metadata.
  title: "Untitled Report",
  subtitle: none,
  authors: (),
  isbn: none,
  contributors: (),
  affiliation_catalog: (),
  affiliations: (),
  date: none,
  doi: none,
  document_license: none,
  keywords: (),

  // Template options for layout and content control. 
  // These are all optional export settings routed from template.typ.
  // They are documented in template.yml as part of the template configuration.
  thesis_degree: none,
  thesis_program: none,
  thesis_track: none,
  thesis_faculty: none,
  thesis_institution: none,
  thesis_defense_date: none,

  // Optional front-matter part files.
  abstract: none,
  preface: none,
  acknowledgements: none,
  dedication: none,
  colophon: none,

 
  /////////////////////////////////////////////////////////
  // This section defines global defaults for the document.
  /////////////////////////////////////////////////////////

  // Page layout.
  paper_size: "a4",
  margin_top_cm: 2.5cm,
  margin_bottom_cm: 2.5cm,
  margin_left_cm: 2.5cm,
  margin_right_cm: 2.5cm,

  // Typography.
  // The template default to Typst's built-in font stack deliberately as a typographic choice.
  // Also, it ensures that fresh installs work without extra setup. 
  // Bundled recommendations live in src/assets/fonts:
  // STIX Two Text + STIX Two Math for legacy serif and math, known from TeX documents,
  // Atkinson Hyperlegible Next and Atkinson Hyperlegible Mono for accessible sans serif body and code fonts - recommended for documents that may be read by people with dyslexia and visual impairments.
  // JetBrains Mono is the recommended code font in all cases for its readability and aesthetics, and it is used as the default monospace font for all documents.
  font_body: "Libertinus Serif",
  font_mono: "DejaVu Sans Mono",
  font_math: "New Computer Modern Math",
  font_size_pt: 11pt,
  line_spacing_em: 0.7em,


  // This is an example how a shared assets (branding) can be defined in the main template and then used in multiple layout files, including the cover page and the title page.
  logo: "src/assets/brand_assets/logo.svg",

 // This section defines defaults decisions for some export toggles for the front matter design.
  show_cover_full: true,
  show_title_page: true,
  show_contributor_affiliations: true,
  frontmatter_order: ("colophon", "abstract", "preface", "acknowledgements", "dedication"),
  show_toc: true,
  show_list_of_figures: false,
  show_list_of_tables: false,
  toc_depth: 2,
  show_verso_blank_page_statement: false,
  verso_blank_page_statement: "This page is intentionally left blank.",

  // Cover page options.
  cover_page_variant: "graphical",
  show_cover_subtitle: true,
  cover_background_image: "src/assets/template_figures/defaultcover.jpg",
  cover_graphical_appearance: "white-on-dark",
  cover_graphical_alignment: "left",
  cover_title_text_color: none,
  cover_bottom_text_color: none,
  cover_title_weight: "regular",
  cover_subtitle_weight: "regular",
  cover_author_weight: "regular",
  cover_title_box_color: none,
  cover_title_box_text: none,
  cover_title_box_opacity_pct: 55,
  show_cover_bottom_ribbon: false,
  cover_bottom_ribbon_color: none,
  cover_bottom_ribbon_opacity_pct: 55,
  cover_logo_variant: none,
  cover_logo_white: "src/assets/brand_assets/international-logo_white_rgb.svg",
  cover_logo_black: "src/assets/brand_assets/international-logo_black_rgb.svg",
  cover_logo_text: none,
  cover_bottom_block_dy_cm: -1.5cm,

  // Title page.
  title_page_variant: "formal",
  title_page_basic_title_alignment: "left",
  title_page_basic_table_alignment: "left",
  title_page_logo_alignment: "center",
  title_page_formal_statement: none,

  // Colophon.
  show_colophon_publication_info: true,
  show_colophon_cover_description: false,
  colophon_cover_description: none,
  show_colophon_confidentiality_statement: false,
  colophon_confidentiality_statement: "This thesis is confidential and cannot be made public.",
  colophon_printer: none,
  colophon_publisher: none,
  colophon_copyright: none,
  colophon_custom_text: none,
  colophon_company_logo: none,
  show_colophon_watermark: true,
  body,

  // Default bibliography options.
  bibliography_file: none,
  show_bibliography: true,
  bibliography_title: "Bibliography",
  bibliography_style: "chicago-author-date",
  bibliography_numbered_heading: false,

) = {
  /////////////////////////////////////////////////////////////////////////////////
  // This helper ensures that the main matter "always" starts on a right-hand page. 
  // If the option to show a blank page statement is enabled, 
  // it adds a usual "intentionally blank" statement on the verso page
  // instead of leaving it completely blank.
  let start_mainmatter_on_recto = (
    show_blank_statement: false,
    blank_statement: "This page is intentionally left blank.",
  ) => {
    if show_blank_statement {
      context {
        if calc.rem(here().page(), 2) == 0 {
          align(center + horizon)[
            #text(
              size: 9pt,
              fill: gray,
            )[#blank_statement]
          ]
          pagebreak()
        }
      }
    } else {
      pagebreak(to: "odd", weak: true)
    }
  }   


  //////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////
  // Global page setup.
  // Keep in mind that some of these settings are overridden later for the main matter, 
  // but it is easier to set them here as a default for the whole document 
  // and then change them back for the main matter.


   // For example, the page numbering starts as roman for the front matter and then it is switched to arabic when the main matter starts.
   set page(
    paper: paper_size,
    margin: (
      top: margin_top_cm,
      bottom: margin_bottom_cm,
      left: margin_left_cm,
      right: margin_right_cm,
    ),
    numbering: "i",
  )

  set text(
    font: font_body,
    size: font_size_pt,
    fill: black,
  )

  set par(
    leading: line_spacing_em,
    spacing: 1.3*line_spacing_em,
    justify: true,
    first-line-indent: 1em,
  )

  set list(
    indent: 1em,
    body-indent: 0.5em,
    spacing: line_spacing_em,
  )

  set enum(
    indent: 1em,
    body-indent: 0.5em,
    spacing: line_spacing_em,
  )

  // Shared component styling.
  show math.equation: set text(font: font_math)
  show math.equation: set block(spacing: 1em)
  show raw: set text(font: font_mono, size: font_size_pt - 1pt)
  show link: set text(fill: blue.darken(30%))

  let setup-numbering(body) = {
    set heading(numbering: (..args) => {
      let nums = args.pos()
      let level = nums.len()
      if level == 1 {
        [#numbering("1.", ..nums)]
      } else {
        [#numbering("1.1.1", ..nums)]
      }
    })

    // Reset counters at each new chapter. (I am not sure about that one!)
    show heading.where(level: 1): it => {
      counter(figure).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      it
    }

    // Equation and figure numbering use the current chapter as a prefix. (I might want to add an option for tables too)
    set math.equation(numbering: (..args) => {
      let chapter = counter(heading).display((..nums) => nums.pos().at(0))
      [(#chapter.#numbering("1)", ..args.pos())]
    })

    set figure(numbering: (..args) => {
      let chapter = counter(heading).display((..nums) => nums.pos().at(0))
      [#chapter.#numbering("1", ..args.pos())]
    })

    body
  }

  // Helper function for headings style.
  let configure_headings(body) = {
    show heading: set text(fill: black, weight: "semibold")

    show heading.where(level: 1): set block(
      above: 4.2 * line_spacing_em,
      below: 2.1 * line_spacing_em,
    )
    // show heading.where(level: 1): set text(size: font_size_pt * 1.8)

    show heading.where(level: 2): set block(
      above: 3.3 * line_spacing_em,
      below: 1.6 * line_spacing_em,
    )
    // show heading.where(level: 2): set text(size: font_size_pt * 1.45)

    show heading.where(level: 3): set block(
      above: 2.6 * line_spacing_em,
      below: 1.25 * line_spacing_em,
    )
    // show heading.where(level: 3): set text(size: font_size_pt * 1.2)

    show heading.where(level: 4): set block(
      above: 2.0 * line_spacing_em,
      below: 0.95 * line_spacing_em,
    )
    // show heading.where(level: 4): set text(size: font_size_pt * 1.05)

    show heading.where(level: 5): set block(
      above: 1.6 * line_spacing_em,
      below: 0.8 * line_spacing_em,
    )
    // show heading.where(level: 5): set text(size: font_size_pt)

    body
  }

  // Helper function for figure styling.
  let configure_figures(body) = {
    show figure.caption: it => {
      set text(size: 9pt)
      set align(left)
      set par(justify: true)
      it
    }

    body
  }

  // Global numbering and component rules.
  show: body => setup-numbering(body)
  show: body => configure_headings(body)
  show: body => configure_figures(body)


  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  // Document assembly and rendering starts here.
  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////

  // Cover page assembly.
  if show_cover_full {
    cover_page(
      title,
      subtitle: subtitle,
      authors: authors,
      variant: cover_page_variant,
      image_path: cover_background_image,
      graphical_appearance: cover_graphical_appearance,
      title_text_color: cover_title_text_color,
      bottom_text_color: cover_bottom_text_color,
      title_box_color: cover_title_box_color,
      title_box_opacity_pct: cover_title_box_opacity_pct,
      title_weight: cover_title_weight,
      subtitle_weight: cover_subtitle_weight,
      author_weight: cover_author_weight,
      show_subtitle: show_cover_subtitle,
      page_alignment: cover_graphical_alignment,
      title_box_text: cover_title_box_text,
      logo_text: cover_logo_text,
      show_bottom_ribbon: show_cover_bottom_ribbon,
      bottom_ribbon_color: cover_bottom_ribbon_color,
      bottom_ribbon_opacity_pct: cover_bottom_ribbon_opacity_pct,
      logo_variant: cover_logo_variant,
      logo_white: cover_logo_white,
      logo_black: cover_logo_black,
      bottom_block_dy: cover_bottom_block_dy_cm,
      logo: resolve_logo_for_layout(logo),
    )

    // Reset the page background and keep roman numbering for the title page
    // and the remaining front matter after the full cover.
    set page(
      paper: paper_size,
      margin: (
        top: margin_top_cm,
        bottom: margin_bottom_cm,
        left: margin_left_cm,
        right: margin_right_cm,
      ),
      numbering: "i",
      background: none,
    )
  }

  // Title page assembly.
  if show_title_page {
    title_page(
      title,
      subtitle: subtitle,
      authors: authors,
      isbn: isbn,
      doi: doi,
      affiliations: affiliations,
      degree: thesis_degree,
      program: thesis_program,
      track: thesis_track,
      faculty: thesis_faculty,
      institution: thesis_institution,
      defense_date: thesis_defense_date,
      contributors: contributors,
      affiliation_catalog: affiliation_catalog,
      show_contributor_affiliations: show_contributor_affiliations,
      logo: resolve_logo_for_layout(logo),
      variant: title_page_variant,
      basic_title_alignment: title_page_basic_title_alignment,
      basic_table_alignment: title_page_basic_table_alignment,
      logo_alignment: title_page_logo_alignment,
      start_on_new_page: show_cover_full,
      formal_statement: title_page_formal_statement,
    )
  }

  // Front matter between the title page and the main chapters assembly.
  render_frontmatter(
    abstract: abstract,
    keywords: keywords,
    preface: preface,
    acknowledgements: acknowledgements,
    dedication: dedication,
    colophon: colophon,
    publication_date: date,
    doi: doi,
    isbn: isbn,
    document_license: document_license,
    colophon_cover_description: colophon_cover_description,
    colophon_printer: colophon_printer,
    colophon_publisher: colophon_publisher,
    colophon_copyright: colophon_copyright,
    colophon_custom_text: colophon_custom_text,
    colophon_tu_logo: resolve_logo_for_layout(logo),
    colophon_company_logo: resolve_logo_for_layout(colophon_company_logo),
    show_colophon_publication_info: show_colophon_publication_info,
    show_colophon_cover_description: show_colophon_cover_description,
    show_colophon_confidentiality_statement: show_colophon_confidentiality_statement,
    colophon_confidentiality_statement: colophon_confidentiality_statement,
    show_colophon_watermark: show_colophon_watermark,
    frontmatter_order: frontmatter_order,
    show_toc: show_toc,
    show_list_of_figures: show_list_of_figures,
    show_list_of_tables: show_list_of_tables,
    toc_depth: toc_depth,
  )

  // Ensures the main matter starts on an odd page.
  start_mainmatter_on_recto(
    show_blank_statement: show_verso_blank_page_statement,
    blank_statement: verso_blank_page_statement,
  )

  ///////////////////////////////////////////////////////////////////////////////////
  // Main matter uses arabic page numbers, 
  // so the page numbering is reset here with the new format.
  set page(
    paper: paper_size,
    margin: (
      top: margin_top_cm,
      bottom: margin_bottom_cm,
      left: margin_left_cm,
      right: margin_right_cm,
    ),
    numbering: "1",
  )
  // Restart page numbering when the main matter begins.
  counter(page).update(1)

  ///////////////////////////////////////////////////////////
  // MyST adds the ordered chapter and appendix content here.
  // Currently, appendices are considered a part of the main matter and they follow the same layout rules, but I want to add an option later to customize them separately.

  [#body]

  // (Optional) bibliography assembly after the document content.
  render_bibliography(
    bibliography_file: bibliography_file,
    show_bibliography: show_bibliography,
    bibliography_title: bibliography_title,
    bibliography_style: bibliography_style,
    bibliography_numbered_heading: bibliography_numbered_heading,
  )
}
