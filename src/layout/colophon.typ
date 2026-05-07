////////////////////////////////////////////////////////////////////////////////////////////////////
// Colophon page layout for the template.
//
// Edit this file when you want to change the automated colophon block. The top
// of the page is reserved for the optional MyST colophon part; publication
// metadata, logos, custom text, and the template watermark sit near the bottom.
////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////
// Shared colophon helpers.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Checks whether a value is non-empty and can be rendered.
#let colophon_has_renderable_content(value) = {
  if value == none {
    false
  } else if type(value) == str {
    str(value).trim() != ""
  } else if type(value) == content {
    true
  } else if value == () {
    false
  } else {
    true
  }
}

// Formats a date as Month day, year when the input looks like day-month-year.
#let format_colophon_date(value) = {
  if value == none or str(value) == "" {
    none
  } else {
    let raw = str(value)
    let parts = raw.split("-")
    if parts.len() == 3 {
      let day = if parts.at(0).len() > 1 and parts.at(0).starts-with("0") {
        parts.at(0).slice(1)
      } else {
        parts.at(0)
      }
      let month = if parts.at(1).len() > 1 and parts.at(1).starts-with("0") {
        parts.at(1).slice(1)
      } else {
        parts.at(1)
      }
      let year = parts.at(2)
      let month_name = if month == "1" {
        "January"
      } else if month == "2" {
        "February"
      } else if month == "3" {
        "March"
      } else if month == "4" {
        "April"
      } else if month == "5" {
        "May"
      } else if month == "6" {
        "June"
      } else if month == "7" {
        "July"
      } else if month == "8" {
        "August"
      } else if month == "9" {
        "September"
      } else if month == "10" {
        "October"
      } else if month == "11" {
        "November"
      } else if month == "12" {
        "December"
      } else {
        none
      }
      if month_name == none {
        raw
      } else {
        month_name + " " + day + ", " + year
      }
    } else {
      raw
    }
  }
}

// Preserves line breaks in optional colophon text fields.
#let render_colophon_multiline_text(value) = {
  if value == none or str(value) == "" {
    []
  } else {
    let lines = str(value).split("\n")
    let output = []
    for (index, line) in lines.enumerate() {
      if index > 0 {
        output += [#linebreak()]
      }
      output += [#line]
    }
    output
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Publication metadata block.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let render_colophon_label_cell(label) = {
  text(weight: "semibold", fill: rgb("#555555"), label + ":")
}

#let colophon_info_row(label, value) = {
  if colophon_has_renderable_content(value) {
    (render_colophon_label_cell(label), value,)
  } else {
    ()
  }
}

#let render_colophon_info_table(info_cells) = {
  if info_cells != () {
    table(
      columns: (9.2em, 1fr),
      align: (left + top, left + top),
      inset: 0pt,
      stroke: none,
      column-gutter: 1.2em,
      row-gutter: 0.55em,
      ..info_cells,
    )
  }
}

#let colophon_publication_rows(
  publication_date: none,
  cover_description: none,
  doi: none,
  isbn: none,
  printer: none,
  publisher: none,
  document_license: none,
  copyright: none,
) = {
  (
    colophon_info_row("Publication date", format_colophon_date(publication_date)) +
    colophon_info_row("Cover", cover_description) +
    colophon_info_row("DOI", doi) +
    colophon_info_row("ISBN", isbn) +
    colophon_info_row("Printer", printer) +
    colophon_info_row("Publisher", publisher) +
    colophon_info_row("License", document_license) +
    colophon_info_row("Copyright", copyright)
  )
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Logo row and watermark.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let render_colophon_logo_row(
  tu_logo: none,
  company_logo: none,
) = {
  let show_tu_logo = colophon_has_renderable_content(tu_logo)
  let show_company_logo = colophon_has_renderable_content(company_logo)

  if show_tu_logo or show_company_logo {
    table(
      columns: (1fr, 1fr),
      align: (left + horizon, right + horizon),
      inset: 0pt,
      stroke: none,
      table.cell(inset: 0pt)[
        #if show_tu_logo [
          #image(tu_logo, width: 3.0cm, height: 1.35cm, fit: "contain")
        ]
      ],
      table.cell(inset: 0pt)[
        #if show_company_logo [
          #image(company_logo, width: 3.0cm, height: 1.35cm, fit: "contain")
        ]
      ],
    )
  }
}

#let render_colophon_watermark() = {
  block(width: 100%)[
    #line(length: 100%, stroke: 0.35pt + rgb("#d0d0d0"))
    #v(0.45em)
    #set par(justify: false, first-line-indent: 0pt)
    #text(size: 8.5pt, fill: rgb("#666666"))[
      Made with #link("https://mystmd.org")[MyST] and #link("https://typst.app")[Typst] using the #link("https://jboss.tudelft.nl")[JBOSS Typst template].
    ]
  ]
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Colophon function used by frontmatter.typ.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let render_colophon_page(
  content: none,
  publication_date: none,
  cover_description: none,
  doi: none,
  isbn: none,
  printer: none,
  publisher: none,
  document_license: none,
  copyright: none,
  custom_text: none,
  tu_logo: none,
  company_logo: none,
  show_publication_info: true,
  show_cover_description: false,
  show_confidentiality_statement: false,
  confidentiality_statement: "This thesis is confidential and cannot be made public.",
  show_watermark: true,
) = {
  let top_content = colophon_has_renderable_content(content)
  let resolved_cover_description = if show_cover_description {
    cover_description
  } else {
    none
  }
  let publication_rows = if show_publication_info {
    colophon_publication_rows(
      publication_date: publication_date,
      cover_description: resolved_cover_description,
      doi: doi,
      isbn: isbn,
      printer: printer,
      publisher: publisher,
      document_license: document_license,
      copyright: copyright,
    )
  } else {
    ()
  }
  let has_confidentiality = show_confidentiality_statement and colophon_has_renderable_content(confidentiality_statement)
  let has_publication_table = publication_rows != ()
  let has_logos = has_publication_table and (
    colophon_has_renderable_content(tu_logo) or colophon_has_renderable_content(company_logo)
  )
  let has_custom_text = colophon_has_renderable_content(custom_text)
  let has_bottom_content = has_confidentiality or has_logos or has_publication_table or has_custom_text or show_watermark

  if top_content or has_bottom_content {
    pagebreak()

    if top_content {
      content
    }

    if has_bottom_content {
      v(1fr)
      set par(first-line-indent: 0pt)

      if has_confidentiality {
        text(size: 10pt, weight: "semibold", smallcaps(str(confidentiality_statement)))
        v(1.4em)
      }

      if has_logos {
        render_colophon_logo_row(
          tu_logo: tu_logo,
          company_logo: company_logo,
        )
        if has_publication_table {
          v(0.9em)
        }
      }

      if has_publication_table {
        render_colophon_info_table(publication_rows)
      }

      if has_custom_text {
        v(1.0em)
        text(size: 9.5pt, fill: rgb("#555555"), render_colophon_multiline_text(custom_text))
      }

      if show_watermark {
        v(1.2em)
        render_colophon_watermark()
      }
    }
  }
}
