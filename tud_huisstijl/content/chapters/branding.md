# Branding 

The TU Delft Typst template has been developed to produce academic documents that follow the visual identity of Delft University of Technology. The template incorporates recognisable elements of the TU Delft corporate identity, including the university's cyan colour, typography, logo, and consistent page layouts.

The template has been reviewed and approved by the TU Delft *huisstijl* team, providing authors with a standardised foundation for creating professionally formatted publications.

Rather than requiring authors to implement the corporate identity themselves, the template integrates the branding into predefined document components. Most visual properties are controlled through configuration variables, allowing authors to customise their documents without modifying the underlying Typst source code.

The following sections describe how the TU Delft visual identity is implemented in the template, with particular attention to colours, typography, logo usage, and consistency across document components.

## TU Delft colour palette

Colour is one of the most recognisable elements of the TU Delft visual identity. The template uses **TU Delft cyan (`#00A6D6`)** as its primary branding colour, complemented by black and white for text, logos, and background elements.

The graphical cover uses cyan as the default colour of the title box, providing a prominent visual connection to the university.

The principal colours used in the template are:

| Colour | Hexadecimal value | Application |
|---|---|---|
| TU Delft cyan | `#00A6D6` | Graphical cover title box |
| Black | `#000000` | Text, logos, and branding elements |
| White | `#FFFFFF` | Cover text, footer background, and reversed logos |

The default cover configuration uses a fully opaque cyan title box:

```yaml
cover_title_box_color: "#00A6D6"
cover_title_box_opacity_pct: 100
```

The title box opacity can be adjusted between `0` (fully transparent) and `100` (fully opaque). This provides flexibility when combining the title box with different background images.

The template also allows the title-box colour to be overridden. However, the default cyan colour is recommended for documents intended to retain the approved TU Delft visual appearance.

## Typography

Typography contributes to the recognisability, readability, and consistency of the document. The template uses different typefaces and font styles for specific document elements.

The supplied TU Delft configuration uses **Roboto Slab** for the graphical cover title and **Arial** for the main document body.

### Cover typography

The graphical cover uses a clear typographic hierarchy to distinguish the document title, subtitle, and author information.

The default configuration applies:

- **Title:** Roboto Slab, bold.
- **Subtitle:** Optional, with regular font weight.
- **Author information:** Bold italic.

These settings are controlled through the following variables:

```yaml
title_font: "Roboto Slab"
cover_title_weight: bold
cover_author_weight: bold
cover_author_style: italic
```

The title and author styles are configurable, allowing authors to adapt the appearance of the cover while retaining the overall layout.

### Document typography

The supplied export configuration uses Arial for the main body text and New Computer Modern Math for mathematical expressions.

```yaml
font_body: Arial
font_math: New Computer Modern Math
```

The template also supports alternative font families, including STIX Two Text, STIX Two Math, Atkinson Hyperlegible Next, and JetBrains Mono.

These alternatives provide flexibility for publications with specific typographic or accessibility requirements. They should be regarded as configurable alternatives rather than automatically approved TU Delft branding choices.

The distinction between cover typography and body typography allows the template to maintain a recognisable graphical identity while supporting the requirements of different academic documents.

## TU Delft logo

The TU Delft logo is an important component of the university's visual identity. The template integrates the logo into the graphical cover and title page, providing consistent institutional identification throughout the document.

The template includes support for both **black and white logo variants**, allowing the logo to be displayed against different backgrounds.

### Logo variants

The black logo is the default variant used on the graphical cover. It is particularly suitable when the white footer bar is enabled.

The white logo can be selected when the footer bar is disabled and the logo is displayed directly over a sufficiently dark background image.

```yaml
cover_logo_variant: black
```

To use the white variant:

```yaml
cover_logo_variant: white
```

The template supports custom logo files for both variants:

```yaml
cover_logo_black: content/assets/TuDelft_logo_cmyk.svg
# cover_logo_white: content/assets/logo_white.svg
```

When no cover-specific logo is supplied, the template uses its predefined logo assets or shared fallback logo.

The choice between black and white should ensure that the logo remains clearly visible against its background.

### Logo positioning and dimensions

The graphical cover provides configuration options for the horizontal alignment, width, and vertical position of the logo.

```yaml
cover_logo_alignment: left
cover_logo_width: 5
cover_bottom_block_dy_cm: 0.3
```

The logo can be aligned to the left or centre. Its width can be adjusted, while the vertical offset allows the branding block to be positioned relative to its default location.

The title page has a separate logo width setting:

```yaml
logo_titlepage_width: 1.9cm
```

For the basic title page variant, the logo alignment can also be configured:

```yaml
title_page_logo_alignment: center
```

The formal title page uses a centred logo by default.

These variables provide control over the presentation of the logo without requiring changes to the Typst layout implementation.

## Branding across document components

The template applies the TU Delft visual identity across multiple document components. Although the cover page, title page, and colophon serve different purposes, they are designed to form a coherent publication.

### Cover page

The graphical cover provides the strongest visual expression of the TU Delft identity. Its default appearance combines a background image, a cyan title box, prominent typography, and the university logo.

An optional white footer bar separates the logo from the background image.

```yaml
cover_footer_bar: true
cover_footer_bar_height: 2
```

When the footer bar is enabled, the black logo is recommended. When disabled, the white logo can be used against a dark background.

The cover also supports a translucent ribbon behind the bottom branding block, providing an alternative way to improve contrast and readability.

### Title page

The title page presents the academic and administrative information associated with the publication.

Unlike the graphical cover, the title page uses a more restrained layout, emphasising the document title, authors, academic information, and university logo.

The template supports both formal and basic title page variants. The formal variant uses a centred layout, while the basic variant provides additional alignment options.

Both variants retain the TU Delft logo as an identifying element.

### Colophon

The colophon provides publication and administrative information, such as copyright details, publication identifiers, cover descriptions, and confidentiality statements.

Its primary role is informational rather than graphical. The template provides a structured presentation of this information, consistent with the typography and layout of the rest of the document.

An optional note identifying the MyST, Typst, and template-based publishing workflow can also be displayed at the bottom of the colophon.

```yaml
show_colophon_watermark: true
```

This note documents the publishing technology used to produce the document and is separate from the official TU Delft branding elements.

## Customisation and brand compliance

A central design principle of the template is the separation of document content, configuration, and presentation.

Authors can modify many visual properties through the MyST export configuration, including colours, fonts, logo variants, alignment, dimensions, and the visibility of individual elements.

This flexibility makes the template suitable for different document types and publication requirements. However, **the availability of a configuration option does not necessarily mean that every possible setting complies with the TU Delft corporate identity guidelines**.

The template's approved design provides a starting point for TU Delft-branded publications. Changes to primary branding elements, such as the cyan colour, typography, logo files, or logo positioning, may affect compliance with the university's visual identity.

For publications intended to follow the approved TU Delft design, it is therefore recommended to retain the default branding settings unless a specific adjustment is required.

The configuration options described in this guide document the capabilities of the template. They should not be interpreted as a replacement for the official TU Delft corporate identity guidelines.

By combining predefined branding elements with configurable document components, the template provides a consistent and reusable foundation for academic publishing. Authors can focus on creating and maintaining their content while the template manages the visual presentation of the generated PDF.