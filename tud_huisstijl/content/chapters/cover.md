# Cover, title page and colophon

## Typst template features

The TU Delft Typst template provides a flexible and configurable framework for generating professionally formatted PDF documents that comply with the university's corporate identity guidelines. An important design principle of the template is that **nearly all visual and structural elements are controlled through configuration variables**, rather than being hard-coded into the document layout.

These variables are defined in the MyST export configuration file (`typst_export_tud_huisstijl.yml`) and passed to the Typst template during PDF generation. This allows authors to customise the appearance and structure of their documents without modifying the underlying Typst source code or requiring knowledge of the Typst typesetting language.

The template provides predefined layouts and default values that establish a consistent TU Delft visual identity. At the same time, individual elements can be enabled, disabled, or adjusted through configuration settings. This makes it possible to accommodate different document types and publication requirements while maintaining a common design foundation.

The following sections describe three main components of the template:

- **Cover page:** The graphical introduction to the document, including the background image, title, subtitle, author information, TU Delft logo, and footer. Variables control the choice of cover variant, typography, colours, alignment, and visibility of individual elements.
- **Title page:** The formal presentation of document and academic information. Configurable options include different title page layouts, academic statements, contributor information, affiliations, and logo positioning.
- **Colophon:** The publication information page, containing details such as copyright, publication identifiers, cover image descriptions, confidentiality statements, and optional publisher information. Individual elements can be displayed or omitted depending on the available metadata and configuration.

For each component, this guide introduces the available variables, explains their purpose and accepted values, and illustrates how different settings affect the generated PDF.

**The underlying principle is simple: authors configure the document, while the template handles its presentation.** This separation makes the publishing workflow easier to maintain, reuse, and adapt, while providing a consistent starting point for TU Delft-branded publications.

+++ { "page-break": true }
## Cover page	

The cover page is the first visual element of the document and establishes its identity. The TU Delft Typst template provides a configurable cover page that follows the university's corporate identity guidelines. Authors can customise the cover image, title, subtitle, author information, colours, logo, and footer while maintaining a consistent visual appearance.

The default configuration uses a graphical cover with a background image, a TU Delft cyan title box, and the university logo at the bottom of the page.

### Cover page variants

The template supports three cover page variants, selected using the `cover_page_variant` variable:

| Value | Description |
|---|---|
| `graphical` | Default graphical cover with a background image, title box, and branding elements. |
| `simple` | Minimal cover with title, optional subtitle, and author information. |
| `custom` | Reserved for a custom cover implementation. |

The cover page can be enabled or disabled using `show_cover_full`.

```yaml
show_cover_full: true
cover_page_variant: graphical
```

The following options primarily describe the graphical cover variant.

### Cover title and subtitle

The document title is displayed prominently in the title box. By default, the TU Delft configuration uses **Roboto Slab**, in bold, with a font size of 40 pt. The title font and weight can be configured independently.

```yaml
title_font: "Roboto Slab"
cover_title_weight: bold
```

A subtitle can be displayed directly below the main title. It uses a smaller font size of 20 pt and regular weight by default. The subtitle is optional and can be hidden without changing the underlying document metadata.

```yaml
show_cover_subtitle: true
cover_subtitle_weight: regular
```

Setting `show_cover_subtitle` to `false` removes the subtitle from the cover page.

### Author information

The author name or names appear below the title and subtitle within the title box. The default TU Delft configuration displays author names in **bold italic**, at 30 pt.

```yaml
cover_author_weight: bold
cover_author_style: italic
```

The author weight and style can be changed independently. Multiple authors are supported and are displayed as a comma-separated list.

An optional additional text block can be placed below the author information, for example to display a faculty, department, programme, or other publication-specific information.

```yaml
cover_title_box_text: |
  Faculty of Civil Engineering and Geosciences
  Delft University of Technology
```

### Background image

The graphical cover supports a full-page background image. Authors are encouraged to replace the template's demonstration image with an image appropriate to their publication.

```yaml
cover_background_image: content/assets/defaultcover.jpg
```

The background image should provide sufficient contrast with the foreground elements. The template offers two appearance presets:

- `white-on-dark`: white text, suitable for darker backgrounds.
- `black-on-light`: black text, suitable for lighter backgrounds.

```yaml
cover_graphical_appearance: white-on-dark
```

### Title box appearance

The graphical cover uses a coloured title box to ensure that the title and author information remain legible against the background image.

The default TU Delft configuration uses the university's cyan colour (`#00A6D6`). The colour and opacity can be adjusted.

```yaml
cover_title_box_color: "#00A6D6"
cover_title_box_opacity_pct: 100
```

The opacity is specified as a percentage between `0` (fully transparent) and `100` (fully opaque).

The title box can be aligned to the left or centre of the page.

```yaml
cover_graphical_alignment: left
```

The title text colour can also be overridden independently using `cover_title_text_color`, accepting `white`, `black`, or a hexadecimal colour value.

### TU Delft logo

The TU Delft logo is positioned near the bottom of the graphical cover. The default configuration uses the **black logo variant**, which is suitable when the white footer bar is enabled.

A white logo variant is also available, particularly for covers where the footer bar is disabled and the logo is displayed directly over a dark background image.

```yaml
cover_logo_variant: black
cover_logo_width: 5
cover_logo_alignment: left
```

The logo can be aligned to the left or centre. Its displayed width is configurable.

Custom logo files can be specified for the black and white variants:

```yaml
cover_logo_black: content/assets/TuDelft_logo_cmyk.svg
# cover_logo_white: content/assets/logo_white.svg
```

When no cover-specific logo file is supplied, the template uses its shared fallback logo.

An optional text block can also be displayed beneath the logo using `cover_logo_text`. This can be useful for an imprint or organisational designation.

### Footer bar

The graphical cover supports a white footer bar at the bottom of the page. This provides a consistent background for the TU Delft logo and separates the branding from the cover image.

The footer bar can be enabled or disabled:

```yaml
cover_footer_bar: true
cover_footer_bar_height: 2
```

When the footer bar is enabled, the black TU Delft logo is recommended. When the footer bar is disabled, the white logo can be selected to provide sufficient contrast against a dark background.

The vertical position of the bottom branding block can be adjusted independently using `cover_bottom_block_dy_cm`.

An optional translucent ribbon can also be displayed behind the bottom logo and text block:

```yaml
show_cover_bottom_ribbon: false
# cover_bottom_ribbon_color: black
# cover_bottom_ribbon_opacity_pct: 55
```

The ribbon is separate from the footer bar and can be used to improve the legibility of branding elements over complex background images.

### Additional configuration options

The graphical cover includes several further options for fine-tuning its appearance.

| Variable | Purpose |
|---|---|
| `cover_title_text_color` | Overrides the title-box text colour. |
| `cover_bottom_text_color` | Overrides the colour of text beneath the logo. |
| `cover_subtitle_weight` | Controls the subtitle font weight. |
| `cover_title_box_text` | Adds optional multiline text below the author. |
| `cover_logo_text` | Adds optional multiline text beneath the logo. |
| `cover_bottom_block_dy_cm` | Adjusts the vertical position of the bottom branding block. |
| `show_cover_bottom_ribbon` | Enables or disables the translucent ribbon behind the logo. |
| `cover_bottom_ribbon_color` | Sets the ribbon colour. |
| `cover_bottom_ribbon_opacity_pct` | Sets the ribbon opacity between 0 and 100. |

+++ { "page-break": true }
## Title page	
Basic and formal variants, metadata and configurable statements

Th# Title page

The title page presents the formal information associated with the document, including its title, authors, academic programme, supervisors, and examination committee. Unlike the graphical cover page, which primarily establishes the document's visual identity, the title page focuses on presenting academic and administrative information in a structured and readable format.

The TU Delft Typst template provides multiple title page layouts to accommodate different publication requirements. The default configuration uses a **formal, centred title page**, suitable for theses and other academic publications.

The title page can be enabled or disabled independently of the cover page.

```yaml
show_title_page: true
```

### Title page variants

The template supports three title page variants, selected using the `title_page_variant` variable.

| Value | Description |
|---|---|
| `formal` | Default. Centred title page with prominent title, author information, an optional formal statement, and supervisor or committee details. |
| `basic` | Structured title page with configurable alignment and metadata tables. |
| `custom` | Starting point for a user-defined title page layout. |

The variants can also be selected using their numerical aliases: `1` for basic, `2` for formal, and `3` for custom. The value `simple` is also accepted as an alias for `basic`.

```yaml
title_page_variant: formal
```

The `custom` variant currently uses the basic layout as a placeholder. A different design requires modifying the Typst implementation.

### Title and subtitle

The document title is displayed prominently at the top of the title page. Its typography depends on the selected variant.

| Property | Formal variant | Basic variant |
|---|---|---|
| Title size | 30 pt | 22 pt |
| Title weight | Bold | Bold |
| Subtitle size | 16 pt | 12 pt |
| Title alignment | Centre | Left or centre |
| Subtitle alignment | Centre | Follows title alignment |

The title and subtitle are obtained from the MyST project metadata. When no title is provided, the template uses the fallback text *Untitled Report*.

The subtitle is optional and is only displayed when a value is available.

For the basic title page, the alignment of the title and subtitle can be configured:

```yaml
title_page_basic_title_alignment: center
```

Accepted values are `left` and `center`. This setting does not affect the formal variant, which always uses centred headings.

### Author information

The author information is obtained from the MyST project metadata. Multiple authors are supported and are displayed as a comma-separated list.

In the formal variant, the authors are displayed beneath the title and optional subtitle. The word *by* appears above the author names, which are rendered in 16 pt medium-weight text.

In the basic variant, author names appear in a metadata table with the label *Author* or *Authors*, depending on the number of contributors.

The author information is automatically omitted when no authors are provided.

### Formal title page statement

The formal title page supports an optional statement describing the academic purpose of the document. This can include the degree, study programme, faculty, institution, and defense date.

The statement is configured using `title_page_formal_statement`.

```yaml
title_page_formal_statement: |
  submitted in partial fulfillment of the
  requirements for the degree of $thesis_degree
  in $thesis_program
  at $thesis_institution,
  to be defended on $thesis_defense_date.
```

The template automatically replaces the placeholders with values from the document metadata.

The following placeholders are supported:

| Placeholder | Description |
|---|---|
| `$thesis_degree` | Academic degree |
| `$thesis_program` | Study programme |
| `$thesis_track` | Study track or specialisation |
| `$thesis_faculty` | Faculty |
| `$thesis_institution` | Institution |
| `$thesis_defense_date` | Defense date |
| `$isbn` | International Standard Book Number |
| `$doi` | Digital Object Identifier |

Placeholders can be written as `$field`, `${field}`, or `{field}`.

The formal statement is centred, uses a font size of 10.5 pt, and is displayed in dark grey. Line breaks specified in the configuration are preserved.

If the statement is not configured or is empty, it is omitted entirely.

### Academic metadata

The basic title page supports a structured table containing academic metadata.

Depending on the information provided in the MyST project, the table can display the following fields:

- Degree
- Programme
- Track
- Faculty
- Institution
- Supervisor(s)
- Examination committee
- Defense date

Only fields containing information are displayed. Empty fields are omitted automatically, preventing unnecessary blank rows.

The basic variant separates author information, academic metadata, contributor information, and the defense date into structured groups.

The formal variant presents most academic metadata through the formal statement rather than a metadata table. Its table is limited to supervisor and committee information.

### Supervisors and examination committee

The template automatically identifies supervisors and committee members from the contributor metadata in MyST.

Contributor identifiers are used to determine their roles. The following identifiers are recognised:

| Contributor group | Recognised identifiers |
|---|---|
| Supervisors | `supervisor`, `supervisor-1`, `advisor`, `advisor-2`, etc. |
| Committee | `committee`, `committee-1`, `examiner`, etc. |

The template supports multiple supervisors and committee members. The supervisor label automatically changes between *Supervisor* and *Supervisors* depending on the number of entries.

### Contributor affiliations

Affiliations can optionally be displayed beneath supervisor and committee member names.

```yaml
show_contributor_affiliations: true
```

When enabled, affiliations are displayed in a smaller, italic font beneath the corresponding contributor name.

The template resolves affiliation identifiers against the affiliation information defined in the MyST project metadata. If an affiliation identifier cannot be resolved, the original value is displayed rather than silently omitted.

Setting `show_contributor_affiliations` to `false` displays contributor names without their affiliations.

### Metadata table alignment

The basic title page allows the alignment of the metadata tables to be configured independently of the title.

```yaml
title_page_basic_table_alignment: left
```

Accepted values are:

| Value | Appearance |
|---|---|
| `left` | The metadata table is positioned at the left side of the content area. |
| `center` | The metadata table is centred horizontally on the page. |

The tables use two columns, with labels on the left and their corresponding values on the right. Labels are displayed in semibold dark grey text.

For the centred table option, the labels are right-aligned to create a compact and balanced appearance.

The formal variant always uses a centred contributor table.

### TU Delft logo

The TU Delft logo is displayed at the bottom of the title page, independently of the title and metadata content.

The logo uses the shared logo asset configured for the document. Its width can be adjusted using `logo_titlepage_width`.

```yaml
logo_titlepage_width: 1.9cm
```

The basic title page also allows the logo alignment to be configured:

```yaml
title_page_logo_alignment: center
```

Accepted values are `left` and `center`.

For the formal variant, the logo is always centred at the bottom of the page, regardless of the alignment setting.

The logo is positioned with a fixed vertical offset from the bottom of the page to maintain consistent placement.

### Additional configuration options

The following table summarises the available title page configuration variables.

| Variable | Purpose |
|---|---|
| `show_title_page` | Enables or disables the title page. |
| `title_page_variant` | Selects the basic, formal, or custom layout. |
| `title_page_formal_statement` | Defines the formal academic statement with metadata placeholders. |
| `title_page_basic_title_alignment` | Controls title and subtitle alignment in the basic variant. |
| `title_page_basic_table_alignment` | Controls metadata table alignment in the basic variant. |
| `title_page_logo_alignment` | Controls logo alignment in the basic variant. |
| `logo_titlepage_width` | Sets the displayed width of the TU Delft logo. |
| `show_contributor_affiliations` | Enables or disables affiliations beneath supervisor and committee names. |



## Colophon	
Publication details, copyright, confidentiality and optional elements