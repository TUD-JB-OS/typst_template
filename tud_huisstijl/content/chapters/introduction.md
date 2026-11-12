# Introduction

## Background and motivation


Academic documents, such as theses, research reports, technical documentation, and educational materials, are nowadays created and distributed in digital environments. While PDF remains an important format for formal publication, archiving, and printing, web-based publications offer additional possibilities for accessibility, navigation, interactivity, and the integration of computational content.

Traditionally, producing both a website and a professionally typeset PDF requires separate publishing workflows or substantial manual adjustments. Maintaining multiple versions of the same document can introduce inconsistencies, increase maintenance efforts, and complicate the publication process.

To address these challenges, we started the [JBOSS project](https://jboss.tudelft.nl): An attempt to make interactive thesis and scientific publications with the generation of an automated pdf. This template combines **JupyterBOok**, **MyST Markdown (MySTMD)** and **Typst** into a unified publishing workflow. Authors can maintain their content in a single source format and generate both an interactive website and a professionally formatted PDF. This approach separates content creation from document presentation, allowing authors to focus on their work while maintaining consistency across publication formats.

Here we provide background on the project and this specific template. We explore the utilization of Jupyter Book 2 and the MyST Document Stack as a modular, extensible, web-native stack for authoring and publishing computational narratives @bolyen2025jupyter. 

```{figure} AST.png
:label: fig_AST

The Jupyter Book project allows to convert the sourcefiles in different outputs using the Abstract Syntax Tree, source [Mystmd.org](https://mystmd.org).
```

```{note}
At Delft University of Technology (TUD), people started using Jupyter Book to create open educational resources mainly in the form of [online educational textbooks](https://interactivetextbooks.tudelft.nl). Various initiatives were taken to lower the technical barrier for educators to create and share their own resources, see for example [Teachbooks](https://teachbooks.tudelft.nl).

With the introduction of Jupyter Book 2, the opportunity arose to create scientific content (e.g., research articles, theses, reports) in addition to educational content. As new technologies are adopted when the benefits are clear and the barriers are low, we applied for the [TUD's Open Science Fund](https://www.tudelft.nl/en/open-science) to explore a seemingly effortless workflow with Jupyter Book for open publishing scientific content. This grant was awarded in October 2025.

This template is one of the result of this project. We aim to help (TU Delft) students, researchers and educators to create, publish, and share open educational and scientific resources with Jupyter Book. The [project's guide](https://jboss.tudelft.nl) covers the entire workflow from installation, content creation, and customization to publishing and sharing. Below we highlight the Typst template features.

```

## Combining Jupyter Book, Myst Markdown and Typst
Jupyter Book is an open-source publishing framework designed for scientific and technical communication. Built on MyST Markdown, it combines familiar Markdown syntax with advanced features such as mathematical expressions, citations, cross-references, figures, tables, executable code, and interactive content. Jupyter Book enables authors to create structured, navigable websites and publish their work in multiple formats, including professionally typeset PDFs.

MyST Markdown is an extensible Markdown-based authoring framework designed for scientific and technical communication. It supports familiar Markdown syntax alongside advanced features such as mathematical expressions, citations, cross-references, figures, tables, and interactive content. Through the MyST publishing ecosystem, documents can be transformed into structured, navigable websites.

Typst is a modern typesetting system designed to produce high-quality documents with precise control over typography, page layout, and visual presentation. It provides a flexible alternative to traditional typesetting systems and is particularly suitable for academic publications that require consistent formatting and structured document elements.

```{aside}
This is an aside
```

By integrating these technologies, the publishing workflow takes advantage of their complementary strengths:

- **Jupyter Book** allows easy online and interactive publishing.
- **MyST Markdown** provides an accessible, structured authoring environment.
- **Typst** provides the typesetting capabilities required for professional, print-ready PDF documents.
- **A shared source** ensures that the website and PDF are generated from the same underlying content, reducing duplication and improving consistency.
- **Configuration-driven formatting** allows authors to customise the appearance and structure of the PDF without modifying the underlying template code.

The result is a publishing workflow in which content, configuration, and presentation are clearly separated.

## The TU Delft template

The TU Delft Typst template has been developed to provide a consistent and recognisable visual identity for academic documents produced through the JBOSS publishing workflow.

The template follows the TU Delft corporate identity guidelines and has been reviewed and approved by the TU Delft *huisstijl* team. It provides a standardised foundation for producing documents that align with the university's visual identity while retaining flexibility for different document types and author preferences.

The template includes configurable components for cover pages, title pages, front matter, chapter layouts, typography, bibliographies, and other document elements. Authors can adjust these components through configuration variables rather than modifying the underlying Typst implementation.

For example, the template supports multiple cover-page and title-page variants, optional front-matter sections, configurable tables of contents, bibliography styles, font selections, and layout settings. These options make it possible to adapt the document to specific publication requirements while preserving the overall TU Delft design language.

Importantly, the template is intended to simplify the publication process. Authors do not need extensive knowledge of Typst or the implementation of the TU Delft visual identity to produce a consistently formatted document.

## Purpose and scope of this guide

This guide introduces the TU Delft Typst template and documents the configuration options available to authors using MyST Markdown. In chapter [{number}](#ch_instructions) {numref}`ch_instructions` we describe the JBOSS workflow, while a fully description is provided on the [JBOSS website](https://jboss.tudelft.nl).

The primary purpose of this manual is to explain how the template can be configured and to demonstrate the visual effects of the available settings. Particular attention is given to the variables that control document structure, page layouts, typography, branding, and the appearance of individual document elements.

The guide is organised around the template's configuration categories. For each category, the relevant variables are described, including their purpose, accepted values, default behaviour, and resulting appearance in the generated PDF. Where appropriate, visual examples illustrate the differences between configuration options.

By combining technical explanations with rendered examples, this guide serves both as an introduction for new users and as a reference for authors who wish to customise their documents.

The overall objective is to make the creation of TU Delft-branded academic publications **consistent, reproducible, and accessible**, while supporting modern publishing workflows in which a single source can serve both interactive digital and traditional print formats.

