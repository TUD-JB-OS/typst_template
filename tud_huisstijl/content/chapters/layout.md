# Page layout and typography

The TU Delft Typst template provides configuration options for controlling the page dimensions, margins, typography, and text spacing of the generated PDF. These settings help ensure a consistent and readable document layout while allowing authors to adjust the presentation to their publication requirements.

The template defines default values for the main layout properties. Authors can override these values through the MyST export configuration without modifying the underlying Typst source files.

## Page layout

### Paper size

The paper size determines the dimensions of all pages in the generated PDF. The default format is **A4**, which is the standard paper size used for most academic documents at TU Delft.

The paper size is configured using `paper_size`.

```yaml
paper_size: a4
```

The configuration supports alternative formats, including:

| Value | Dimensions | Description |
|---|---|---|
| `a4` | 210 × 297 mm | Default. Standard format for TU Delft academic publications. |
| `us-letter` | 215.9 × 279.4 mm | Commonly used for documents in North America. |
| `b5` | 176 × 250 mm (ISO B5) | Smaller format suitable for compact publications. |

Changing the paper size affects the available content area and may influence line breaks, pagination, and the placement of figures and tables.

For documents intended to follow the standard TU Delft presentation, A4 is recommended.

### Page margins

Page margins define the space between the document content and the edges of the page. They influence the width of the text area, the number of lines per page, and the overall appearance of the document.

The template defines its own default margins, which can be overridden individually using the following variables:

```yaml
margin_top_cm: 2.5
margin_bottom_cm: 2.5
margin_left_cm: 2.5
margin_right_cm: 2.5
```

All margin values are expressed in centimetres.

| Variable | Description |
|---|---|
| `margin_top_cm` | Distance between the top edge of the page and the content area. |
| `margin_bottom_cm` | Distance between the bottom edge of the page and the content area. |
| `margin_left_cm` | Distance between the left edge of the page and the content area. |
| `margin_right_cm` | Distance between the right edge of the page and the content area. |

The values above illustrate a layout with equal margins on all sides. They are optional overrides, not necessarily the template's built-in defaults.

When margin variables are omitted, the template applies its predefined margin settings.

+++ { "page-break": true }
## Font

### Font families

The template supports separate font families for body text, mathematical expressions, and monospaced text such as code.

This separation allows authors to select typefaces that are appropriate for different kinds of content.

The available variables are:

| Variable | Purpose | Default |
|---|---|---|
| `font_body` | Main body text | Template fallback uses a built-in font family; supplied configuration selects Arial |
| `font_math` | Mathematical expressions | New Computer Modern Math |
| `font_mono` | Code and monospaced text | Template default; no explicit value in the supplied configuration |

For example:

```yaml
font_body: Arial
font_math: New Computer Modern Math
# font_mono: DejaVu Sans Mono
```

The template includes additional bundled font families that can be selected to provide alternative typographic styles.

### Serif font preset

The serif preset uses STIX Two Text for body text and STIX Two Math for mathematical expressions. This combination provides a traditional academic appearance.

```yaml
font_body: STIX Two Text
font_math: STIX Two Math
font_mono: JetBrains Mono
```

### Accessible sans-serif preset

The accessible sans-serif preset uses Atkinson Hyperlegible Next for body text, combined with New Computer Modern Math and JetBrains Mono.

```yaml
font_body: Atkinson Hyperlegible Next
font_math: New Computer Modern Math
font_mono: JetBrains Mono
```

The template also includes Atkinson Hyperlegible Mono, which can be selected as a matching monospaced font.

### Monospaced font

For documents containing code examples, the configuration recommends JetBrains Mono.

It can be selected independently of the body and mathematics fonts:

```yaml
font_mono: JetBrains Mono
```

This allows authors to improve the presentation of code without changing the typography of the rest of the document.

### Font size

The base font size controls the size of the main body text. It influences readability, text density, and the number of pages in the document.

The default base font size is **11 pt**. In the supplied example configuration, it is explicitly set to 10 pt.

```yaml
font_size_pt: 10
```

The value is expressed in typographic points.

A smaller font size allows more text to fit on each page, while a larger font size can improve readability but may increase the total page count.

The base font size is particularly relevant for longer academic publications, where consistent text presentation is important.

### Line spacing

Line spacing controls the vertical distance between lines of body text. Together with the font size, it determines the density and readability of paragraphs.

The template exposes the `line_spacing_em` variable, with a default value of `0.7`.

```yaml
line_spacing_em: 0.7
```

The value is expressed in `em` units, relative to the font size.

Increasing the value introduces more vertical space between lines, while decreasing it produces a more compact text layout.

The exact visual effect depends on how the Typst template applies this value in its paragraph styling.


+++ { "page-break": true }
## Font availability

The template includes bundled fonts in the following directory:

```text
../src/assets/fonts
```

When the PDF is generated through the provided GitHub Actions workflow, the build script automatically makes these fonts available to Typst by configuring the `TYPST_FONT_PATHS` environment variable.

For local compilation, the font directory must be made available to the Typst compiler.

On macOS, Linux, or WSL:

```bash
export TYPST_FONT_PATHS="$(cd ../src/assets/fonts)"
```

On Windows PowerShell:

```powershell
$env:TYPST_FONT_PATHS = (Resolve-Path ..\src\assets\fonts)
```

Alternatively, the fonts can be installed on the local system.

Using the bundled font directory is recommended because it provides a more self-contained and reproducible publishing workflow.

+++ { "page-break": true }

## Example configuration

The following configuration demonstrates the page layout and typography settings used in the supplied TU Delft export example.

```yaml
# Paper size
paper_size: a4

# Optional margin overrides
# margin_top_cm: 2.5
# margin_bottom_cm: 2.5
# margin_left_cm: 2.5
# margin_right_cm: 2.5

# Typography
font_size_pt: 10
line_spacing_em: 0.7

# Font families
font_body: Arial
font_math: New Computer Modern Math

# Optional code font
# font_mono: JetBrains Mono
```

These variables allow authors to adjust the physical layout and typography of the generated PDF while retaining the template's predefined document structure.

---

## Bibliography

The TU Delft Typst template supports the automatic generation of a bibliography from the references defined in the MyST project. The bibliography is placed after the main document content and can be configured independently of the document's page layout and typography.

Authors can control whether the bibliography is displayed, its heading, the citation style used, and whether the bibliography heading is numbered.

### Displaying the bibliography

The bibliography is enabled by default and is controlled using `show_bibliography`.

```yaml
show_bibliography: true
```

When enabled, the template renders a bibliography section after the main document content.

Setting the variable to `false` disables the bibliography section in the PDF.

```yaml
show_bibliography: false
```

This option is useful for publications that do not require a separate reference list.


### Bibliography title

The heading displayed above the bibliography can be customised using `bibliography_title`.

The default heading is *Bibliography*.

```yaml
bibliography_title: Bibliography
```

Authors can replace this with an alternative heading, for example:

```yaml
bibliography_title: References
```

The heading can therefore be adapted to the conventions of a particular faculty, department, publication, or citation style.

### Citation styles

The template supports several bibliography styles through the `bibliography_style` variable.

The default style is **Chicago Author-Date**.

```yaml
bibliography_style: chicago-author-date
```

The following values are supported by the configuration:

| Value | Citation style |
|---|---|
| `ieee` | IEEE |
| `apa` | American Psychological Association |
| `mla` | Modern Language Association |
| `chicago-author-date` | Chicago Author-Date (default) |
| `chicago-notes` | Chicago Notes |

Each style defines its own conventions for the formatting and ordering of bibliographic information.

For example, IEEE generally uses numbered references, while APA and Chicago Author-Date use author–date conventions.

The bibliography style is passed to Typst by the export template. The formatting of citations within the document may also depend on the MyST citation processing workflow.

### Bibliography heading numbering

By default, the bibliography heading is not numbered as a chapter.

This behaviour is controlled using `bibliography_numbered_heading`.

```yaml
bibliography_numbered_heading: false
```

When set to `false`, the bibliography is displayed with an unnumbered heading.

When set to `true`, the bibliography heading is numbered as a top-level heading.

```yaml
bibliography_numbered_heading: true
```

This allows the bibliography to follow the chapter-numbering conventions of the document when required.

## Additional configuration options

The bibliography settings are summarised below.

| Variable | Default | Purpose |
|---|---|---|
| `show_bibliography` | `true` | Enables or disables the bibliography section. |
| `bibliography_title` | `Bibliography` | Defines the heading displayed above the bibliography. |
| `bibliography_style` | `chicago-author-date` | Selects the bibliography formatting style. |
| `bibliography_numbered_heading` | `false` | Controls whether the bibliography heading is numbered. |

### Example configuration

The following example uses the default bibliography settings.

```yaml
# Bibliography
show_bibliography: true
bibliography_title: Bibliography
bibliography_style: chicago-author-date
bibliography_numbered_heading: false
```

For a document that requires IEEE formatting and a numbered references chapter, the configuration can be changed to:

```yaml
show_bibliography: true
bibliography_title: References
bibliography_style: ieee
bibliography_numbered_heading: true
```

These settings provide flexibility for different academic conventions while keeping bibliography formatting integrated into the MyST–Typst publishing workflow.