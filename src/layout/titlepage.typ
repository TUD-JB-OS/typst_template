////////////////////////////////////////////////////////////////////////////////////////////////////
// Title page layouts for the template.
//
// Edit this file when you want to change the basic, formal, or custom title
// page. Title-page-specific settings and contributor handling live here, close
// to the layout code they affect.
/////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////
// Shared title-page helpers.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Turns one item or many items into one printable line.
#let render_comma_list(items) = {
  if items == none {
    ""
  } else if type(items) == str {
    items
  } else if items.len() == 0 {
    ""
  } else {
    let output = ""
    for (index, item) in items.enumerate() {
      if index > 0 {
        output += ", "
      }
      output += str(item)
    }
    output
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Contributor and affiliation helpers.
//
// Edit this section when you want to change how supervisors, committee members,
// or affiliations are read from MyST metadata.
///////////////////////////////////////////////////////////////////////////////////////////////////


// Decides whether a contributor belongs to the supervisor or committee group.
#let contributor_group_matches(contributor_id, group) = {
  let normalized = if contributor_id == none { "" } else { str(contributor_id) }
  // Accepts ids such as supervisor, supervisor-1, advisor-2, committee-1, or examiner.
       if group == "supervisor" {normalized == "supervisor" or normalized.starts-with("supervisor") or normalized == "advisor" or normalized.starts-with("advisor") }
  else if group == "committee" { normalized == "committee" or normalized.starts-with("committee") or normalized == "examiner" or normalized.starts-with("examiner") }
  else { false }
}

// Looks up the full affiliation name from an affiliation id.
#let resolve_affiliation_name(affiliation_id, affiliation_catalog) = {
  let requested_id = if affiliation_id == none { "" } else { str(affiliation_id) }
  if requested_id == "" or affiliation_catalog == none or type(affiliation_catalog) == str {
    none
  } else {
    let result = none
    for item in affiliation_catalog {
      if type(item) != str {
        let item_id = if item.id == none { "" } else { str(item.id) }
        if item_id == requested_id {
          result = if item.name == none { none } else { str(item.name) }
        }
      }
    }
    result
  }
}

// Turns one or more affiliation ids into a printable line.
#let resolve_affiliation_line(affiliation_ids, affiliation_catalog) = {
  if affiliation_ids == none {
    none
  } else if type(affiliation_ids) == str {
    let direct = str(affiliation_ids)
    if direct == "" {
      none
    } else {
      // If the id is not in the catalog, show the original value instead of hiding it.
      let resolved = resolve_affiliation_name(direct, affiliation_catalog)
      if resolved == none { direct } else { resolved }
    }
  } else {
    let names = ()
    for aff_id in affiliation_ids {
      let aff_name = resolve_affiliation_name(aff_id, affiliation_catalog)
      if aff_name != none and aff_name != "" {
        names += (aff_name,)
      } else if aff_id != none and str(aff_id) != "" {
        // Unknown affiliation ids are still useful to show during drafting.
        names += (str(aff_id),)
      }
    }
    let rendered = render_comma_list(names)
    if rendered == "" { none } else { rendered }
  }
}

// Collects contributors for one group and prepares them for display.
#let contributors_by_group(contributors, group, affiliation_catalog) = {
  if contributors == none or type(contributors) == str {
    ()
  } else {
    let output = ()
    for contributor in contributors {
      if type(contributor) != str {
        let contributor_id = if contributor.id == none { "" } else { str(contributor.id) }
        let name = if contributor.name == none { "" } else { str(contributor.name) }
        if name != "" and contributor_group_matches(contributor_id, group) {
          let affiliation = resolve_affiliation_line(contributor.affiliations, affiliation_catalog)
          output += ((
            name: name,
            affiliation: affiliation,
          ),)
        }
      }
    }
    output
  }
}

// Turns one line or many lines into one newline-separated text block.
#let render_lines(items, fallback: none) = {
  if items == none {
    if fallback == none { "" } else { str(fallback) }
  } else if type(items) == str {
    items
  } else if items.len() == 0 {
    if fallback == none { "" } else { str(fallback) }
  } else {
    let output = ""
    for (index, item) in items.enumerate() {
      if index > 0 {
        output += "\n"
      }
      output += str(item)
    }
    output
  }
}

// Counts items for singular/plural labels.
#let count_items(items) = {
  if items == none {
    0
  } else if type(items) == str {
    if items == "" { 0 } else { 1 }
  } else {
    items.len()
  }
}

// Checks whether a value is non-empty and can be rendered on the title page.
#let has_renderable_content(value) = {
  if value == none {
    false
  } else if type(value) == str {
    str(value) != ""
  } else if type(value) == content {
    true
  } else if value == () {
    false
  } else {
    true
  }
}

// Renders contributor names, with optional affiliation lines below them.
#let render_contributor_entries(entries, show_affiliations: true) = {
  if entries == none {
    none
  } else if type(entries) == str {
    if entries == "" {
      none
    } else {
      [#entries]
    }
  } else if entries.len() == 0 {
    none
  } else {
    let rows = ()
    for entry in entries {
      let name = if type(entry) == str {
        str(entry)
      } else if entry.name == none {
        ""
      } else {
        str(entry.name)
      }
      let affiliation = if type(entry) == str {
        none
      } else {
        entry.affiliation
      }
      if name != "" {
        if show_affiliations and affiliation != none and str(affiliation) != "" {
          rows += ([
            #name
            #linebreak()
            #v(-1pt)
            #text(size: 9pt, style: "italic", fill: rgb("#555555"), str(affiliation))
          ],)
        } else {
          rows += ([#name],)
        }
      }
    }
    if rows.len() == 0 {
      none
    } else {
      stack(dir: ttb, spacing: 0.6em, ..rows)
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// General title-page settings.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Accepts friendly variant names from the export config.
#let resolve_title_page_variant(variant) = {
  let normalized = str(variant)
  if normalized == "1" or normalized == "basic" or normalized == "simple" {
    "basic"
  } else if normalized == "2" or normalized == "formal" {
    "formal"
  } else if normalized == "3" or normalized == "custom" {
    "custom"
  } else {
    panic("Invalid title_page_variant '" + normalized + "'. Use '1'/'basic', '2'/'formal', or '3'/'custom'.")
  }
}

// Uses a readable fallback when MyST does not provide a title.
#let resolve_title_page_title(title) = {
  if title == none or title == "" { "Untitled Report" } else { title }
}

#let resolve_title_page_alignment(value, option_name) = {
  let normalized = str(value)
  if normalized == "left" or normalized == "center" {
    normalized
  } else {
    panic("Invalid " + option_name + " '" + normalized + "'. Use 'left' or 'center'.")
  }
}

#let render_title_page_label_cell(label) = {
  text(weight: "semibold", fill: rgb("#555555"), label + ":")
}

#let title_page_info_row(label, value) = {
  if has_renderable_content(value) {
    (render_title_page_label_cell(label), value,)
  } else {
    ()
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Reusable title-page building blocks.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let render_title_page_heading_line(
  content,
  heading_alignment: "center",
) = {
  let alignment = if str(heading_alignment) == "left" {
    left
  } else {
    center
  }
  set par(justify: false)
  set text(hyphenate: false)
  if str(heading_alignment) == "left" {
    align(left, block(width: 100%, content))
  } else {
    align(alignment, content)
  }
}

#let render_title_page_info_table(
  info_cells,
  table_alignment: "left",
) = {
  let resolved_label_alignment = if str(table_alignment) == "center" {
    right
  } else {
    left
  }
  // The fixed content width keeps centered tables visually stable.
  let content_width = 8.8em + 1.3em + 24em
  let table_content = table(
    columns: (8.8em, 24em),
    align: (resolved_label_alignment + top, left + top),
    inset: 0pt,
    stroke: none,
    column-gutter: 1.3em,
    row-gutter: 0.6em,
    ..info_cells,
  )

  if str(table_alignment) == "center" {
    align(center, box(width: content_width, table_content))
  } else {
    align(left, block(width: 100%, table_content))
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Basic title page.
//
// Edit this section for the structured title page with left or centered tables.
// The page is built from top to bottom: title, optional subtitle, metadata
// tables, and academic people/date information. Publication metadata now lives
// in the colophon.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let title_page_basic_variant(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  isbn: none,
  doi: none,
  degree: none,
  program: none,
  track: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  show_contributor_affiliations: true,
  title_alignment: "center",
  table_alignment: "left",
) = {
  let author_line = render_comma_list(authors)
  let author_affiliation_line = render_lines(affiliations)
  let author_cell = render_contributor_entries(
    if author_line == "" {
      ()
    } else {
      ((name: author_line, affiliation: author_affiliation_line),)
    },
    show_affiliations: false,
  )
  let supervisor_cell = render_contributor_entries(
    supervisors,
    show_affiliations: show_contributor_affiliations,
  )
  let committee_cell = render_contributor_entries(
    committee,
    show_affiliations: show_contributor_affiliations,
  )
  let author_label = if count_items(authors) > 1 { "Authors" } else { "Author" }
  let supervisor_label = if count_items(supervisors) > 1 { "Supervisors" } else { "Supervisor" }
  let committee_label = "Committee"
  let author_rows = title_page_info_row(author_label, author_cell)
  let academic_rows = (
    title_page_info_row("Degree", degree) +
    title_page_info_row("Program", program) +
    title_page_info_row("Track", track) +
    title_page_info_row("Faculty", faculty) +
    title_page_info_row("Institution", institution)
  )
  let people_rows = (
    title_page_info_row(supervisor_label, supervisor_cell) +
    title_page_info_row(committee_label, committee_cell)
  )
  let date_rows = title_page_info_row("Defense date", defense_date)

  render_title_page_heading_line(
    text(22pt, weight: "bold", title),
    heading_alignment: title_alignment,
  )

  if subtitle != none and subtitle != "" {
    v(0.5em)
    render_title_page_heading_line(
      text(12pt, subtitle),
      heading_alignment: title_alignment,
    )
  }

  v(3.5cm)

  if author_rows != () {
    render_title_page_info_table(
      author_rows,
      table_alignment: table_alignment,
    )
  }

  if academic_rows != () {
    if author_rows != () {
      v(1.1em)
    }
    render_title_page_info_table(
      academic_rows,
      table_alignment: table_alignment,
    )
  }

  if people_rows != () {
    if author_rows != () or academic_rows != () {
      v(1.1em)
    }
    render_title_page_info_table(
      people_rows,
      table_alignment: table_alignment,
    )
  }

  if date_rows != () {
    if author_rows != () or academic_rows != () or people_rows != () {
      v(1.1em)
    }
    render_title_page_info_table(
      date_rows,
      table_alignment: table_alignment,
    )
  }

  v(1fr)
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Formal title page.
//
// Edit this section for the centered title page with an optional formal
// statement and compact supervisor/committee table.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Keeps substituted statement values on one visual line where possible.
#let no_break_string(value) = {
  if value == none {
    ""
  } else {
    str(value).replace(" ", "\u{00a0}")
  }
}

// Prepares a metadata value for use inside the formal statement.
#let title_page_statement_value(value) = {
  if value == none or str(value) == "" {
    ""
  } else {
    no_break_string(value)
  }
}

// Fields that can be inserted into the formal statement.
#let title_page_formal_statement_fields(
  isbn: none,
  doi: none,
  degree: none,
  program: none,
  track: none,
  faculty: none,
  institution: none,
  defense_date: none,
) = {
  let isbn_text = title_page_statement_value(isbn)
  let doi_text = title_page_statement_value(doi)
  let degree_text = title_page_statement_value(degree)
  let program_text = title_page_statement_value(program)
  let track_text = title_page_statement_value(track)
  let faculty_text = title_page_statement_value(faculty)
  let institution_text = title_page_statement_value(institution)
  let defense_date_text = title_page_statement_value(defense_date)

  (
    (name: "thesis_defense_date", value: defense_date_text),
    (name: "thesis_institution", value: institution_text),
    (name: "thesis_faculty", value: faculty_text),
    (name: "thesis_program", value: program_text),
    (name: "thesis_track", value: track_text),
    (name: "thesis_degree", value: degree_text),
    (name: "isbn", value: isbn_text),
    (name: "doi", value: doi_text),
  )
}

// Replaces placeholders such as $thesis_degree in the formal statement.
#let title_page_replace_statement_placeholders(template, fields) = {
  let output = str(template)
  for field in fields {
    // Accepts common placeholder styles: ${field}, $field, and {field}.
    output = output.replace("${" + field.name + "}", field.value)
    output = output.replace("$" + field.name, field.value)
    output = output.replace("{" + field.name + "}", field.value)
  }
  output
}

// Normalizes user-entered statement text before it is rendered.
#let title_page_normalize_statement_text(value) = {
  let output = str(value).replace("\r\n", "\n").replace("\r", "\n").trim()
  // Keeps intentional line breaks, but removes accidental spaces around them.
  while output.contains(" \n") {
    output = output.replace(" \n", "\n")
  }
  while output.contains("\n ") {
    output = output.replace("\n ", "\n")
  }
  output
}

// Preserves line breaks in the formal statement.
#let render_title_page_multiline_text(value) = {
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

#let render_title_page_formal_statement(
  isbn: none,
  doi: none,
  degree: none,
  program: none,
  track: none,
  faculty: none,
  institution: none,
  defense_date: none,
  statement: none,
) = {
  let fields = title_page_formal_statement_fields(
    isbn: isbn,
    doi: doi,
    degree: degree,
    program: program,
    track: track,
    faculty: faculty,
    institution: institution,
    defense_date: defense_date,
  )
  let sentence = if statement != none and str(statement) != "" {
    title_page_replace_statement_placeholders(statement, fields)
  } else {
    ""
  }
  sentence = title_page_normalize_statement_text(sentence)

  if sentence == "" {
    none
  } else {
    align(center, block(width: 72%, [
      #set par(justify: false)
      #set text(hyphenate: false)
      #text(size: 10.5pt, fill: rgb("#555555"), render_title_page_multiline_text(sentence))
    ]))
  }
}

#let title_page_formal_variant(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  isbn: none,
  doi: none,
  degree: none,
  program: none,
  track: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  show_contributor_affiliations: true,
  formal_statement: none,
) = {
  let author_line = render_comma_list(authors)
  let supervisor_cell = render_contributor_entries(
    supervisors,
    show_affiliations: show_contributor_affiliations,
  )
  let committee_cell = render_contributor_entries(
    committee,
    show_affiliations: show_contributor_affiliations,
  )
  let supervisor_label = if count_items(supervisors) > 1 { "Supervisors" } else { "Supervisor" }
  let people_rows = (
    title_page_info_row(supervisor_label, supervisor_cell) +
    title_page_info_row("Committee", committee_cell)
  )
  let formal_statement_block = render_title_page_formal_statement(
    isbn: isbn,
    doi: doi,
    degree: degree,
    program: program,
    track: track,
    faculty: faculty,
    institution: institution,
    defense_date: defense_date,
    statement: formal_statement,
  )

  render_title_page_heading_line(
    text(30pt, weight: "bold", title),
    heading_alignment: "center",
  )

  if subtitle != none and subtitle != "" {
    v(0.75em)
    render_title_page_heading_line(
      text(16pt, subtitle),
      heading_alignment: "center",
    )
  }

  if author_line != "" {
    v(1.35em)
    align(center, text(10.5pt, fill: rgb("#666666"), "by"))
    v(0.3em)
    render_title_page_heading_line(
      text(16pt, weight: "medium", author_line),
      heading_alignment: "center",
    )
  }

  if formal_statement_block != none {
    v(1.4em)
    formal_statement_block
  }

  if people_rows != () {
    v(2.1em)
    render_title_page_info_table(
      people_rows,
      table_alignment: "center",
    )
  }

  v(1fr)
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Custom title page.
//
// This is a starting point for a custom design. Replace the body when you want
// a title page that does not fit the basic or formal layout.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let title_page_custom(
  title,
  subtitle: none,
  authors: (),
) = {
  // Stub only: replace this body with your own title-page implementation.
  title_page_basic_variant(title, subtitle: subtitle, authors: authors)
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// Title page function used by main.typ.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let title_page(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  isbn: none,
  doi: none,
  degree: none,
  program: none,
  track: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  contributors: (),
  affiliation_catalog: (),
  show_contributor_affiliations: true,
  logo: none,
  variant: "basic",
  start_on_new_page: false,
  formal_statement: none,
  basic_title_alignment: "center",
  basic_table_alignment: "left",
  logo_alignment: "center",
) = {
  let mode = resolve_title_page_variant(variant)
  let resolved_title = resolve_title_page_title(title)

  if start_on_new_page {
    pagebreak()
  }

  if mode == "custom" {
    title_page_custom(resolved_title, subtitle: subtitle, authors: authors)
  } else {
    let resolved_supervisors = if supervisors != () {
      supervisors
    } else {
      contributors_by_group(contributors, "supervisor", affiliation_catalog)
    }
    let resolved_committee = if committee != () {
      committee
    } else {
      contributors_by_group(contributors, "committee", affiliation_catalog)
    }
    let resolved_basic_title_alignment = resolve_title_page_alignment(basic_title_alignment, "title_page_basic_title_alignment")
    let resolved_basic_table_alignment = resolve_title_page_alignment(basic_table_alignment, "title_page_basic_table_alignment")
    let resolved_logo_alignment = resolve_title_page_alignment(logo_alignment, "title_page_logo_alignment")
    let logo_bottom_offset = 0.9cm

    if logo != none {
      let logo_anchor = if mode == "basic" and resolved_logo_alignment == "left" {
        bottom + left
      } else {
        bottom + center
      }
      place(logo_anchor, dy: -logo_bottom_offset, image(logo, width: 1.9cm))
    }

    if mode == "basic" {
      title_page_basic_variant(
        resolved_title,
        subtitle: subtitle,
        authors: authors,
        affiliations: affiliations,
        isbn: isbn,
        doi: doi,
        degree: degree,
        program: program,
        track: track,
        faculty: faculty,
        institution: institution,
        defense_date: defense_date,
        supervisors: resolved_supervisors,
        committee: resolved_committee,
        show_contributor_affiliations: show_contributor_affiliations,
        title_alignment: resolved_basic_title_alignment,
        table_alignment: resolved_basic_table_alignment,
      )
    } else if mode == "formal" {
      title_page_formal_variant(
        resolved_title,
        subtitle: subtitle,
        authors: authors,
        affiliations: affiliations,
        isbn: isbn,
        doi: doi,
        degree: degree,
        program: program,
        track: track,
        faculty: faculty,
        institution: institution,
        defense_date: defense_date,
        supervisors: resolved_supervisors,
        committee: resolved_committee,
        show_contributor_affiliations: show_contributor_affiliations,
        formal_statement: formal_statement,
      )
    }
  }

}
