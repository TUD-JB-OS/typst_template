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

#let count_items(items) = {
  if items == none {
    0
  } else if type(items) == str {
    if items == "" { 0 } else { 1 }
  } else {
    items.len()
  }
}

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

#let resolve_title_page_variant(variant) = {
  // Supported variants: "1"/"simple", "2"/"formal", and "3"/"custom".
  let normalized = str(variant)
  if normalized == "1" or normalized == "simple" {
    "simple"
  } else if normalized == "2" or normalized == "formal" {
    "formal"
  } else if normalized == "3" or normalized == "custom" {
    "custom"
  } else {
    panic("Invalid title_page_variant '" + normalized + "'. Use '1'/'simple', '2'/'formal', or '3'/'custom'.")
  }
}

#let resolve_title_page_image_anchor(anchor) = {
  if anchor == none {
    top + right
  } else {
    let normalized = str(anchor)
    if normalized == "" or normalized == "none" {
      top + right
    } else if normalized == "top-right" {
      top + right
    } else if normalized == "top" {
      top + center
    } else if normalized == "top-left" {
      top + left
    } else if normalized == "center" {
      center
    } else if normalized == "bottom" {
      bottom + center
    } else if normalized == "bottom-right" {
      bottom + right
    } else if normalized == "bottom-left" {
      bottom + left
    } else {
      panic("Invalid title_page_image_anchor '" + normalized + "'. Use top-right, top, top-left, center, bottom, bottom-right, or bottom-left.")
    }
  }
}

#let render_title_page_image(
  image_path: none,
  anchor: none,
  width: none,
  height: none,
  dx: none,
  dy: none,
) = {
  if image_path != none {
    let resolved_width = if width == none { 5cm } else { width }
    let resolved_dx = if dx == none { 0cm } else { dx }
    let resolved_dy = if dy == none { 0cm } else { dy }
    let placement = resolve_title_page_image_anchor(anchor)
    if height == none {
      place(placement, dx: resolved_dx, dy: resolved_dy, image(
        image_path,
        width: resolved_width,
        fit: "contain",
      ))
    } else {
      place(placement, dx: resolved_dx, dy: resolved_dy, image(
        image_path,
        width: resolved_width,
        height: height,
        fit: "contain",
      ))
    }
  } else {
    none
  }
}

#let title_page_simple_variant(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  page_image: none,
  page_image_anchor: none,
  page_image_width: none,
  page_image_height: none,
  page_image_dx: none,
  page_image_dy: none,
) = {
  let author_line = render_comma_list(authors)
  let affiliation_lines = render_lines(affiliations)

  render_title_page_image(
    image_path: page_image,
    anchor: page_image_anchor,
    width: page_image_width,
    height: page_image_height,
    dx: page_image_dx,
    dy: page_image_dy,
  )

  align(center, text(24pt, weight: "bold", title))

  if subtitle != none and subtitle != "" {
    v(0.6em)
    align(center, text(13pt, subtitle))
  }

  if authors != none and authors.len() > 0 {
    v(1.0em)
    align(center, author_line)
  }

  if affiliations != none and affiliations.len() > 0 {
    v(0.7em)
    align(center, affiliation_lines)
  }

  if date != none and date != "" {
    v(1.0em)
    align(center, date)
  }
}

#let title_page_formal_variant(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  degree: none,
  program: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  show_contributor_affiliations: true,
  page_image: none,
  page_image_anchor: none,
  page_image_width: none,
  page_image_height: none,
  page_image_dx: none,
  page_image_dy: none,
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
  let resolved_defense_date = if defense_date != none and defense_date != "" { defense_date } else { none }
  let resolved_date = if date != none and date != "" { date } else { none }
  let author_label = if count_items(authors) > 1 { "Authors" } else { "Author" }
  let supervisor_label = if count_items(supervisors) > 1 { "Supervisors" } else { "Supervisor" }
  let committee_label = if count_items(committee) > 1 { "Committee Members" } else { "Committee Member" }
  let info_cells = (
    author_label, author_line,
  ) + (
    if supervisor_cell != none {
      (supervisor_label, supervisor_cell,)
    } else {
      ()
    }
  ) + (
    if committee_cell != none {
      (committee_label, committee_cell,)
    } else {
      ()
    }
  ) + (
    if resolved_defense_date != none {
      ("Defense date", resolved_defense_date,)
    } else {
      ()
    }
  ) + (
    if resolved_date != none {
      ("Date", resolved_date,)
    } else {
      ()
    }
  )

  render_title_page_image(
    image_path: page_image,
    anchor: page_image_anchor,
    width: page_image_width,
    height: page_image_height,
    dx: page_image_dx,
    dy: page_image_dy,
  )

  align(center, text(22pt, weight: "bold", title))

  if subtitle != none and subtitle != "" {
    v(0.5em)
    align(center, text(12pt, subtitle))
  }

  v(1.2em)
  align(center, "Master Thesis")

  if degree != none and degree != "" {
    v(0.4em)
    align(center, degree)
  }

  if program != none and program != "" {
    align(center, program)
  }

  if institution != none and institution != "" {
    align(center, institution)
  }

  if faculty != none and faculty != "" {
    align(center, faculty)
  }

  v(1.5em)

  table(
    columns: (auto, 1fr),
    align: (left, left),
    stroke: none,
    ..info_cells,
  )
}

#let title_page_custom(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  degree: none,
  program: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  show_contributor_affiliations: true,
  page_image: none,
  page_image_anchor: none,
  page_image_width: none,
  page_image_height: none,
  page_image_dx: none,
  page_image_dy: none,
) = {
  // Custom entry point: replace this with your own title-page implementation.
  title_page_formal_variant(
    title,
    subtitle: subtitle,
    authors: authors,
    affiliations: affiliations,
    date: date,
    degree: degree,
    program: program,
    faculty: faculty,
    institution: institution,
    defense_date: defense_date,
    supervisors: supervisors,
    committee: committee,
    show_contributor_affiliations: show_contributor_affiliations,
    page_image: page_image,
    page_image_anchor: page_image_anchor,
    page_image_width: page_image_width,
    page_image_height: page_image_height,
    page_image_dx: page_image_dx,
    page_image_dy: page_image_dy,
  )
}

#let title_page(
  title,
  subtitle: none,
  authors: (),
  affiliations: (),
  date: none,
  degree: none,
  program: none,
  faculty: none,
  institution: none,
  defense_date: none,
  supervisors: (),
  committee: (),
  show_contributor_affiliations: true,
  logo: none,
  variant: "1",
  start_on_new_page: false,
  page_image: none,
  page_image_anchor: none,
  page_image_width: none,
  page_image_height: none,
  page_image_dx: none,
  page_image_dy: none,
) = {
  let mode = resolve_title_page_variant(variant)

  if start_on_new_page {
    pagebreak()
  }

  if logo != none {
    align(right, image(logo, width: 2.5cm))
    v(1.2em)
  }

  if mode == "simple" {
    title_page_simple_variant(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  } else if mode == "formal" {
    title_page_formal_variant(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      degree: degree,
      program: program,
      faculty: faculty,
      institution: institution,
      defense_date: defense_date,
      supervisors: supervisors,
      committee: committee,
      show_contributor_affiliations: show_contributor_affiliations,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  } else {
    title_page_custom(
      title,
      subtitle: subtitle,
      authors: authors,
      affiliations: affiliations,
      date: date,
      degree: degree,
      program: program,
      faculty: faculty,
      institution: institution,
      defense_date: defense_date,
      supervisors: supervisors,
      committee: committee,
      show_contributor_affiliations: show_contributor_affiliations,
      page_image: page_image,
      page_image_anchor: page_image_anchor,
      page_image_width: page_image_width,
      page_image_height: page_image_height,
      page_image_dx: page_image_dx,
      page_image_dy: page_image_dy,
    )
  }

}
