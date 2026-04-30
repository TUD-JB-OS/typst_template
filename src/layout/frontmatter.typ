////////////////////////////////////////////////////////////////////////////////////////////////////
#import "colophon.typ": render_colophon_page

////////////////////////////////////////////////////////////////////////////////////////////////////
// Front-matter pages for the template.
//
// Edit this file when you want to change the pages between the title page and
// the main chapters: abstract, keywords, preface, acknowledgements, dedication,
// colophon, table of contents, list of figures, or list of tables.
////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////
// Shared front-matter helpers.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Renders one named section such as Abstract, Preface, or Acknowledgements.
#let render_frontmatter_section(title, content) = {
  if content != none and content != "" {
    align(center, text(15pt, weight: "bold", title))
    v(1.2em)
    content
  }
}

// Starts a new page only when the section has content.
#let render_optional_frontmatter_page(title, content) = {
  if content != none and content != "" {
    pagebreak()
    render_frontmatter_section(title, content)
  }
}

// Turns MyST keywords into one printable line, such as "myst, typst, thesis".
#let format_keywords(keywords) = {
  if keywords == none {
    ""
  } else if type(keywords) == str {
    keywords
  } else if keywords.len() == 0 {
    ""
  }
  else {
    let output = ""
    for (index, item) in keywords.enumerate() {
      if index > 0 {
        output += ", "
      }
      output += str(item)
    }
    output
  }
}

// Keeps wrapped keywords aligned under the keyword text, not under the label.
#let render_keywords_box(keyword_text) = {
  if keyword_text != "" {
    align(left, table(
      columns: (auto, 1fr),
      column-gutter: 0.9em,
      stroke: none,
      inset: 0pt,
      align: (left, left),
      table.cell(inset: 0pt)[#text(weight: "bold")[Keywords:]],
      table.cell(inset: 0pt)[#keyword_text],
    ))
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Abstract and optional front-matter sections.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Renders the abstract page, including optional keywords from MyST metadata.
#let render_abstract_page(abstract, keywords) = {
  let keyword_text = format_keywords(keywords)
  let has_abstract = abstract != none and abstract != ""
  if has_abstract or keyword_text != "" {
    pagebreak()
    if has_abstract {
      render_frontmatter_section("Abstract", abstract)
    } else {
      align(center, text(15pt, weight: "bold", "Abstract"))
    }
    if keyword_text != "" {
      v(1.5em)
      render_keywords_box(keyword_text)
    }
  }
}

// Default page order when no frontmatter_order option is set.
#let default_frontmatter_order = (
  "colophon",
  "abstract",
  "preface",
  "acknowledgements",
  "dedication",
)

// Checks whether an item is already in the normalized order list.
#let frontmatter_order_contains(items, value) = {
  let found = false
  for item in items {
    if item == value {
      found = true
    }
  }
  found
}

// Allows only known fixed front-matter page ids.
#let normalize_frontmatter_part_id(value) = {
  let item = str(value).trim()
  if item == "abstract" or item == "preface" or item == "acknowledgements" or item == "dedication" or item == "colophon" {
    item
  } else {
    panic("Invalid frontmatter_order item '" + item + "'. Use colophon, abstract, preface, acknowledgements, or dedication.")
  }
}

// Accepts a comma-separated string or list, removes duplicates, and appends omitted pages.
#let normalize_frontmatter_order(order) = {
  let raw_items = if order == none {
    default_frontmatter_order
  } else if type(order) == str {
    str(order).split(",")
  } else {
    order
  }

  let items = ()
  for item in raw_items {
    let normalized = normalize_frontmatter_part_id(item)
    if not frontmatter_order_contains(items, normalized) {
      items += (normalized,)
    }
  }

  for item in default_frontmatter_order {
    if not frontmatter_order_contains(items, item) {
      items += (item,)
    }
  }

  items
}

// Renders one fixed front-matter page by id.
#let render_frontmatter_part(
  part_id,
  abstract: none,
  keywords: (),
  preface: none,
  acknowledgements: none,
  dedication: none,
  colophon: none,
  publication_date: none,
  doi: none,
  isbn: none,
  document_license: none,
  colophon_cover_description: none,
  colophon_printer: none,
  colophon_publisher: none,
  colophon_copyright: none,
  colophon_custom_text: none,
  colophon_tu_logo: none,
  colophon_company_logo: none,
  show_colophon_publication_info: true,
  show_colophon_cover_description: false,
  show_colophon_confidentiality_statement: false,
  colophon_confidentiality_statement: "This thesis is confidential and cannot be made public.",
  show_colophon_watermark: true,
) = {
  if part_id == "abstract" {
    render_abstract_page(abstract, keywords)
  } else if part_id == "preface" {
    render_optional_frontmatter_page("Preface", preface)
  } else if part_id == "acknowledgements" {
    render_optional_frontmatter_page("Acknowledgements", acknowledgements)
  } else if part_id == "dedication" {
    render_optional_frontmatter_page("Dedication", dedication)
  } else if part_id == "colophon" {
    render_colophon_page(
      content: colophon,
      publication_date: publication_date,
      cover_description: colophon_cover_description,
      doi: doi,
      isbn: isbn,
      printer: colophon_printer,
      publisher: colophon_publisher,
      document_license: document_license,
      copyright: colophon_copyright,
      custom_text: colophon_custom_text,
      tu_logo: colophon_tu_logo,
      company_logo: colophon_company_logo,
      show_publication_info: show_colophon_publication_info,
      show_cover_description: show_colophon_cover_description,
      show_confidentiality_statement: show_colophon_confidentiality_statement,
      confidentiality_statement: colophon_confidentiality_statement,
      show_watermark: show_colophon_watermark,
    )
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Navigation pages.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Table of contents.
#let render_table_of_contents(depth: 1) = {
  pagebreak()
  outline(
    title: strong("Contents"),
    depth: depth,
    indent: auto,
  )
}

// List of figures.
#let render_list_of_figures() = {
  pagebreak()
  outline(
    title: strong("List of Figures"),
    // MyST labels image figures with kind "figure".
    target: figure.where(kind: "figure"),
    indent: auto,
  )
}

// List of tables.
#let render_list_of_tables() = {
  pagebreak()
  outline(
    title: strong("List of Tables"),
    target: figure.where(kind: table),
    indent: auto,
  )
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Front-matter function used by main.typ.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let render_frontmatter(
  abstract: none,
  keywords: (),
  preface: none,
  acknowledgements: none,
  dedication: none,
  colophon: none,
  publication_date: none,
  doi: none,
  isbn: none,
  document_license: none,
  colophon_cover_description: none,
  colophon_printer: none,
  colophon_publisher: none,
  colophon_copyright: none,
  colophon_custom_text: none,
  colophon_tu_logo: none,
  colophon_company_logo: none,
  show_colophon_publication_info: true,
  show_colophon_cover_description: false,
  show_colophon_confidentiality_statement: false,
  colophon_confidentiality_statement: "This thesis is confidential and cannot be made public.",
  show_colophon_watermark: true,
  frontmatter_order: default_frontmatter_order,
  show_toc: true,
  show_list_of_figures: false,
  show_list_of_tables: false,
  toc_depth: 2,
) = {
  for part_id in normalize_frontmatter_order(frontmatter_order) {
    render_frontmatter_part(
      part_id,
      abstract: abstract,
      keywords: keywords,
      preface: preface,
      acknowledgements: acknowledgements,
      dedication: dedication,
      colophon: colophon,
      publication_date: publication_date,
      doi: doi,
      isbn: isbn,
      document_license: document_license,
      colophon_cover_description: colophon_cover_description,
      colophon_printer: colophon_printer,
      colophon_publisher: colophon_publisher,
      colophon_copyright: colophon_copyright,
      colophon_custom_text: colophon_custom_text,
      colophon_tu_logo: colophon_tu_logo,
      colophon_company_logo: colophon_company_logo,
      show_colophon_publication_info: show_colophon_publication_info,
      show_colophon_cover_description: show_colophon_cover_description,
      show_colophon_confidentiality_statement: show_colophon_confidentiality_statement,
      colophon_confidentiality_statement: colophon_confidentiality_statement,
      show_colophon_watermark: show_colophon_watermark,
    )
  }
  
  // Example for a custom section you may want to add later:
  // render_optional_frontmatter_page("Abbreviations", abbreviations)

  if show_toc { render_table_of_contents(depth: toc_depth) }
  if show_list_of_figures { render_list_of_figures() }
  if show_list_of_tables { render_list_of_tables() }

  // End the roman-numbered front matter before the main chapters begin.
  pagebreak()
}
