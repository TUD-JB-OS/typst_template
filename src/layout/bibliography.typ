// This file controls how the bibliography chapter is rendered.
// The bibliography entries themselves come from MyST, while the options here
// control whether the chapter is shown and how it is styled.

#let resolve_bibliography_path(path) = {
  if path == none {
    none
  } else if type(path) != str {
    path
  } else {
    let normalized = str(path).replace("\\", "/")
    if normalized.starts-with("/") or normalized.starts-with("./") or normalized.starts-with("../") or normalized.contains(":/") {
      normalized
    } else {
      "../../" + normalized
    }
  }
}

#let render_bibliography(
  bibliography_file: none,
  show_bibliography: true,
  bibliography_title: "Bibliography",
  bibliography_style: "chicago-author-date",
  bibliography_numbered_heading: false,
) = {
  if show_bibliography and bibliography_file != none and bibliography_file != "" {
    let resolved_bibliography_file = resolve_bibliography_path(bibliography_file)
    pagebreak()
    show bibliography: set heading(
      numbering: if bibliography_numbered_heading { "1." } else { none },
    )
    bibliography(
      resolved_bibliography_file,
      title: [#bibliography_title],
      style: bibliography_style,
    )
  }
}
