#import "../assets/assets.typ": resolve_asset_path

////////////////////////////////////////////////////////////////////////////////////////////////////
// Cover page layouts for the template.
//
// Edit this file when you want to change the simple, graphical, or custom
// cover design. Cover-specific settings are interpreted here.
/////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////
// Shared utility functions for the cover design variants.
////////////////////////////////////////////////////////////////////////////////////////////////////

// Turns one author or many authors into one printable line.
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

// Accepts friendly variant names from the export config.
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

// Uses a readable fallback when MyST does not provide a title.
#let resolve_cover_title(title) = {
  if title == none or title == "" { "Untitled Report" } else { title }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Simple cover.
//
// Edit this section for the plain text-only cover. The page is built from top
// to bottom: title, optional subtitle, and an author line near the bottom.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let cover_page_simple(
  title,
  subtitle: none,
  authors: (),
  show_subtitle: true,
) = {
  set page(numbering: none)
  set par(first-line-indent: 0pt, justify: false)

  let author_line = render_comma_list(authors)

  v(5%)
  align(left, [
    #text(size: 40pt, weight: "bold", title)

    #if show_subtitle and subtitle != none and subtitle != "" [
      #v(0.35em)
      #text(size: 18pt, weight: "medium", subtitle)
    ]

    // #v(0.7em)
    // #line(length: 55%, stroke: 1.2pt + rgb("#666666"))
  ])

  if author_line != "" {
    v(1fr)
    align(left, text(size: 22pt, weight: "regular", author_line))
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Graphical cover.
//
// Edit this section for the image-based cover. It handles the background image,
// title box, text colors, logo choice, and optional bottom ribbon.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let resolve_cover_appearance(appearance) = {
  let normalized = str(appearance)
  if normalized == "white-on-dark" or normalized == "black-on-light" {
    normalized
  } else {
    panic("Invalid cover_graphical_appearance '" + normalized + "'. Use 'white-on-dark' or 'black-on-light'.")
  }
}

#let resolve_cover_black_white_choice(value, option_name) = {
  if value == none or value == "" {
    panic("Option '" + option_name + "' must be 'white' or 'black'.")
  } else {
    let normalized = str(value)
    if normalized == "white" or normalized == "black" {
      normalized
    } else {
      panic("Invalid " + option_name + " '" + normalized + "'. Use 'white' or 'black'.")
    }
  }
}

#let resolve_cover_color_choice(value, option_name) = {
  if value == none or value == "" {
    panic("Option '" + option_name + "' must be 'white', 'black', or a hex color like '#f5f5f5'.")
  } else {
    let normalized = str(value)
    if normalized == "white" or normalized == "black" {
      normalized
    } else if normalized.starts-with("#") and (normalized.len() == 4 or normalized.len() == 7) {
      normalized
    } else if normalized.len() == 3 or normalized.len() == 6 {
      "#" + normalized
    } else {
      panic("Invalid " + option_name + " '" + normalized + "'. Use 'white', 'black', or a hex color like '#f5f5f5'.")
    }
  }
}

#let resolve_cover_color_fill(value, option_name) = {
  let normalized = resolve_cover_color_choice(value, option_name)
  if normalized == "white" {
    white
  } else if normalized == "black" {
    black
  } else {
    rgb(normalized)
  }
}

#let resolve_cover_alignment(value) = {
  let normalized = str(value)
  if normalized == "left" or normalized == "center" {
    normalized
  } else {
    panic("Invalid cover_graphical_alignment '" + normalized + "'. Use 'left' or 'center'.")
  }
}

#let resolve_cover_opacity_pct(value) = {
  if value < 0 {
    0
  } else if value > 100 {
    100
  } else {
    value
  }
}

#let resolve_cover_layout_options(
  graphical_appearance: "white-on-dark",
  title_text_color: none,
  bottom_text_color: none,
  title_box_color: none,
  title_box_opacity_pct: 55,
  bottom_ribbon_color: none,
  bottom_ribbon_opacity_pct: 55,
  page_alignment: "left",
  logo_variant: none,
  logo: none,
  logo_white: none,
  logo_black: none,
) = {
  let appearance = resolve_cover_appearance(graphical_appearance)

  let title_color = if title_text_color != none and title_text_color != "" {
    resolve_cover_color_choice(title_text_color, "cover_title_text_color")
  } else if appearance == "black-on-light" {
    "black"
  } else {
    "white"
  }

  let title_box_color_value = if title_box_color != none and title_box_color != "" {
    resolve_cover_color_choice(title_box_color, "cover_title_box_color")
  } else if appearance == "black-on-light" {
    "white"
  } else {
    "black"
  }

  let bottom_ribbon_color_value = if bottom_ribbon_color != none and bottom_ribbon_color != "" {
    resolve_cover_color_choice(bottom_ribbon_color, "cover_bottom_ribbon_color")
  } else {
    title_box_color_value
  }

  let bottom_color = if bottom_text_color != none and bottom_text_color != "" {
    resolve_cover_color_choice(bottom_text_color, "cover_bottom_text_color")
  } else {
    title_color
  }

  let logo_tone = if logo_variant != none and logo_variant != "" {
    resolve_cover_black_white_choice(logo_variant, "cover_logo_variant")
  } else if appearance == "black-on-light" {
    "black"
  } else {
    "white"
  }

  let resolved_logo = if logo_tone == "black" {
    if logo_black != none { logo_black } else { logo }
  } else {
    if logo_white != none { logo_white } else { logo }
  }

  (
    title_box_fill: resolve_cover_color_fill(title_box_color_value, "cover_title_box_color").transparentize((100 - resolve_cover_opacity_pct(title_box_opacity_pct)) * 1%),
    bottom_ribbon_fill: resolve_cover_color_fill(bottom_ribbon_color_value, "cover_bottom_ribbon_color").transparentize((100 - resolve_cover_opacity_pct(bottom_ribbon_opacity_pct)) * 1%),
    title_text_fill: resolve_cover_color_fill(title_color, "cover_title_text_color"),
    bottom_text_fill: resolve_cover_color_fill(bottom_color, "cover_bottom_text_color"),
    page_alignment: resolve_cover_alignment(page_alignment),
    logo: resolved_logo,
  )
}

// Preserves line breaks in optional cover text fields.
#let render_multiline_cover_text(value) = {
  if value == none or value == "" {
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

#let cover_page_graphical(
  title,
  subtitle: none,
  authors: (),
  image_path: none,
  title_box_opacity_pct: 55,
  box_fill: auto,
  title_text_fill: auto,
  bottom_text_fill: auto,
  title_weight: "regular",
  subtitle_weight: "regular",
  author_weight: "regular",
  show_subtitle: true,
  page_alignment: "left",
  title_box_text: none,
  logo_text: none,
  show_bottom_ribbon: false,
  bottom_ribbon_fill: auto,
  bottom_block_dy: -1.2cm,
  logo: none,
) = context {
  if image_path == none {
    cover_page_simple(title, subtitle: subtitle, authors: authors, show_subtitle: show_subtitle)
  } else {
    let pw = page.width
    let ph = page.height
    let author_line = render_comma_list(authors)
    let resolved_box_fill = if box_fill == auto {
      color.hsv(0deg, 0%, 0%, resolve_cover_opacity_pct(title_box_opacity_pct) * 1%)
    } else {
      box_fill
    }
    let resolved_bottom_ribbon_fill = if bottom_ribbon_fill == auto {
      color.hsv(0deg, 0%, 0%, 55%)
    } else {
      bottom_ribbon_fill
    }
    let resolved_title_text_fill = if title_text_fill == auto { white } else { title_text_fill }
    let resolved_bottom_text_fill = if bottom_text_fill == auto { resolved_title_text_fill } else { bottom_text_fill }
    let resolved_content_alignment = if str(page_alignment) == "center" { center } else { left }
    let render_logo_text = logo_text != none and logo_text != ""

    // Background image.
    set image(width: pw, height: ph, fit: "cover")
    set page(background: image(image_path), margin: 0pt)
    set par(first-line-indent: 0pt, justify: false)

    // Title box: title, subtitle, authors, and optional extra text.
    place(dy: 2cm, rect(
      width: 100%,
      inset: 30pt,
      fill: resolved_box_fill,
    )[
      #align(resolved_content_alignment, [
        #text(fill: resolved_title_text_fill, size: 40pt, weight: title_weight, title)

        #if show_subtitle and subtitle != none and subtitle != "" [
          #v(0.5em)
          #text(fill: resolved_title_text_fill, size: 20pt, weight: subtitle_weight, subtitle)
        ]

        #if author_line != "" [
          #v(3.5em)
          #text(fill: resolved_title_text_fill, size: 30pt, weight: author_weight, author_line)
        ]

        #if title_box_text != none and title_box_text != "" [
          #v(0.8em)
          #text(fill: resolved_title_text_fill, size: 12pt, weight: "regular", render_multiline_cover_text(title_box_text))
        ]

      ])
    ])

    // Bottom block: logo and optional small text.
    if logo != none or render_logo_text {
      let bottom_block = [
        #align(resolved_content_alignment, [
          #if logo != none [
            #image(
              logo,
              width: 7cm,
              height: auto,
              fit: "contain",
            )
          ]

          #if render_logo_text [
            #v(0.1em)
            #text(fill: resolved_bottom_text_fill, size: 10pt, weight: "regular", render_multiline_cover_text(logo_text))
          ]
        ])
      ]
      let bottom_block_box = box(width: pw, inset: (left: 30pt, right: 30pt))[
        #bottom_block
      ]
      if show_bottom_ribbon {
        place(bottom + left, dy: bottom_block_dy, rect(width: 100%, inset: (left: 30pt, right: 30pt, top: 5pt, bottom: 20pt), fill: resolved_bottom_ribbon_fill)[
          #bottom_block
        ])
      } else {
        place(bottom + left, dy: bottom_block_dy, bottom_block_box)
      }
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Custom cover.
//
// This is intentionally tiny. Replace the body when you want a custom design.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let cover_page_custom(
  title,
  subtitle: none,
  authors: (),
  show_subtitle: true,
) = {
  // Stub only: replace this body with your own cover implementation.
  cover_page_simple(title, subtitle: subtitle, authors: authors, show_subtitle: show_subtitle)
}


////////////////////////////////////////////////////////////////////////////////////////////////////
// Cover function used by main.typ.
////////////////////////////////////////////////////////////////////////////////////////////////////

#let cover_page(
  title,
  subtitle: none,
  authors: (),
  variant: "simple",
  image_path: none,
  graphical_appearance: "white-on-dark",
  box_fill: auto,
  title_text_fill: auto,
  bottom_text_fill: auto,
  title_text_color: none,
  bottom_text_color: none,
  title_box_color: none,
  title_box_opacity_pct: 55,
  show_bottom_ribbon: false,
  bottom_ribbon_color: none,
  bottom_ribbon_opacity_pct: 55,
  title_weight: "regular",
  subtitle_weight: "regular",
  author_weight: "regular",
  show_subtitle: true,
  page_alignment: "left",
  title_box_text: none,
  logo_text: none,
  logo_variant: none,
  logo_white: none,
  logo_black: none,
  bottom_block_dy: -1.2cm,
  logo: none,
) = {
  let mode = resolve_cover_page_variant(variant)
  let resolved_title = resolve_cover_title(title)

  if mode == "simple" {
    cover_page_simple(resolved_title, subtitle: subtitle, authors: authors, show_subtitle: show_subtitle)
  } else if mode == "graphical" {
    let resolved_image_path = resolve_asset_path(image_path, levels_up: 2)
    let resolved_logo = resolve_asset_path(logo, levels_up: 2)
    let resolved_logo_white = resolve_asset_path(logo_white, levels_up: 2)
    let resolved_logo_black = resolve_asset_path(logo_black, levels_up: 2)
    let resolved = resolve_cover_layout_options(
      graphical_appearance: graphical_appearance,
      title_text_color: title_text_color,
      bottom_text_color: bottom_text_color,
      title_box_color: title_box_color,
      title_box_opacity_pct: title_box_opacity_pct,
      bottom_ribbon_color: bottom_ribbon_color,
      bottom_ribbon_opacity_pct: bottom_ribbon_opacity_pct,
      page_alignment: page_alignment,
      logo_variant: logo_variant,
      logo: resolved_logo,
      logo_white: resolved_logo_white,
      logo_black: resolved_logo_black,
    )
    let resolved_box_fill = if box_fill == auto { resolved.title_box_fill } else { box_fill }
    let resolved_title_text_fill = if title_text_fill == auto { resolved.title_text_fill } else { title_text_fill }
    let resolved_bottom_text_fill = if bottom_text_fill == auto { resolved.bottom_text_fill } else { bottom_text_fill }

    cover_page_graphical(
      resolved_title,
      subtitle: subtitle,
      authors: authors,
      image_path: resolved_image_path,
      title_box_opacity_pct: title_box_opacity_pct,
      box_fill: resolved_box_fill,
      title_text_fill: resolved_title_text_fill,
      bottom_text_fill: resolved_bottom_text_fill,
      title_weight: title_weight,
      subtitle_weight: subtitle_weight,
      author_weight: author_weight,
      show_subtitle: show_subtitle,
      page_alignment: resolved.page_alignment,
      title_box_text: title_box_text,
      logo_text: logo_text,
      show_bottom_ribbon: show_bottom_ribbon,
      bottom_ribbon_fill: resolved.bottom_ribbon_fill,
      bottom_block_dy: bottom_block_dy,
      logo: resolved.logo,
    )
  } else {
    cover_page_custom(
      resolved_title,
      subtitle: subtitle,
      authors: authors,
      show_subtitle: show_subtitle,
    )
  }
}
