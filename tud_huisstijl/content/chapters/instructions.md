# Instructions

Some general info

## JBOSS starterkit
The template was originally designed for the use {abbr}`JBOSS` project. It is automatically included in the [JBOSS-starterkit](https://tud-jb-os.github.io/starterkit/), where line XXX has to be uncommented. With every new push to GitHub, the pdf will be rebuild.

Something about pixi and typst - instructions on the website.

## Jupyter Book
For including the template in your own Jupyter Book project, include the [typst_export.yml file](../typst_export_tudelft.yml). In your myst.yml file include:
```yml
extends:
  - typst_export.yml
```

when running `myst build --pdf` your thesis is made.

## Typst
A full Typst template has been uploaded to the Typst ...