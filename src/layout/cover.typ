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

#let resolve_cover_page_variant(variant) = {
  let normalized = str(variant)
  if normalized == "1" or normalized == "simple" {
    "simple"
  } else if normalized == "2" or normalized == "graphical" {
    "graphical"
  } else if normalized == "3" or normalized == "custom" {
    "custom"
  } else {
    panic("Invalid cover_page_variant '" + normalized + "'. Use '1'/'simple', '2'/'graphical', or '3'/'custom'.")
  }
}

#let cover_page_simple(title, authors: ()) = {
  set page(numbering: none)
  let author_line = render_comma_list(authors)
  v(12%)
  align(left, [
    #text(size: 40pt, weight: "bold", title)
    #v(0.7em)
    #line(length: 55%, stroke: 1.2pt + rgb("#666666"))
    #if author_line != "" [
      #v(1.0em)
      #text(size: 16pt, weight: "medium", author_line)
    ]
  ])
}

#let cover_page_graphical(
  title,
  subtitle: none,
  authors: (),
  image_path: none,
  box_opacity_pct: 55,
  institution_line: none,
  logo: none,
) = context {
  if image_path == none {
    cover_page_simple(title, authors: authors)
  } else {
    let pw = page.width
    let ph = page.height
    let opacity_pct = if box_opacity_pct < 0 {
      0
    } else if box_opacity_pct > 100 {
      100
    } else {
      box_opacity_pct
    }
    let author_line = render_comma_list(authors)

    set image(width: pw, height: ph, fit: "cover")
    set page(background: image(image_path), margin: 0pt)
    set par(first-line-indent: 0pt, justify: false)

    if institution_line != none and institution_line != "" {
      place(left + horizon, dx: 12pt, rotate(-90deg, origin: center, reflow: true)[
        #text(fill: white, institution_line)
      ])
    }

    place(dy: 2cm, rect(
      width: 100%,
      inset: 24pt,
      fill: color.hsv(0deg, 0%, 0%, opacity_pct * 1%),
    )[
      #text(fill: white, size: 36pt, weight: "bold", title)

      #if subtitle != none and subtitle != "" [
        #v(0.5em)
        #text(fill: white, size: 18pt, subtitle)
      ]

      #if author_line != "" [
        #v(1.0em)
        #text(fill: white, size: 18pt, author_line)
      ]
    ])

    if logo != none {
      place(bottom + left, dx: 1.2cm, dy: -1.2cm, image(
        logo,
        width: 4.8cm,
        height: auto,
        fit: "contain",
      ))
    }
  }
}

#let cover_page_custom(
  title,
  subtitle: none,
  authors: (),
  image_path: none,
  box_opacity_pct: 55,
  institution_line: none,
  logo: none,
) = {
  // Custom entry point: replace this with your own cover implementation.
  cover_page_simple(title, authors: authors)
}

#let cover_page(
  title,
  subtitle: none,
  authors: (),
  variant: "simple",
  image_path: none,
  box_opacity_pct: 55,
  institution_line: none,
  logo: none,
) = {
  let mode = resolve_cover_page_variant(variant)
  if mode == "simple" {
    cover_page_simple(title, authors: authors)
  } else if mode == "graphical" {
    cover_page_graphical(
      title,
      subtitle: subtitle,
      authors: authors,
      image_path: image_path,
      box_opacity_pct: box_opacity_pct,
      institution_line: institution_line,
      logo: logo,
    )
  } else {
    cover_page_custom(
      title,
      subtitle: subtitle,
      authors: authors,
      image_path: image_path,
      box_opacity_pct: box_opacity_pct,
      institution_line: institution_line,
      logo: logo,
    )
  }
}
