#let render_bibliography(path: none) = {
  if path != none and path != "" {
    pagebreak()
    bibliography("/" + path, title: [References])
  }
}