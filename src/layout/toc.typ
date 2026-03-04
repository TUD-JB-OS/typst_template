#let render_table_of_contents(depth: 3) = {
  pagebreak()
  outline(
    title: strong("Contents"),
    depth: depth,
    indent: auto,
  )
}

#let render_list_of_figures() = {
  pagebreak()
  outline(
    title: strong("List of Figures"),
    target: figure.where(kind: image),
    indent: auto,
  )
}

#let render_list_of_tables() = {
  pagebreak()
  outline(
    title: strong("List of Tables"),
    target: figure.where(kind: table),
    indent: auto,
  )
}
