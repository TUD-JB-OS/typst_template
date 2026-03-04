#let frontmatter_section(title, content) = {
  if content != none and content != "" {
    pagebreak()
    align(center, text(15pt, weight: "bold", title))
    v(1.2em)
    content
  }
}
