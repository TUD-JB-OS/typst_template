(ch_instructions)=
# Instructions

## Introduction to publishing with Jupyter Book
At Delft University of Technology (TUD), people started using Jupyter Book to create open educational resources mainly in the form of online educational textbooks. Various initiatives were taken to lower the technical barrier for educators to create and share their own resources, see for example Teachbooks.

With the introduction of Jupyter Book 2, the opportunity arose to create scientific content (e.g., research articles, theses, reports) in addition to educational content. Our general idea was that bachelor or master thesis are more than a static PDF that are submitted. These students made an enzyme where its 3D structure is key, built a 3D model, developed code, worked on an optimization problem, or designed something interactive. Yet in the end, all of that often gets flattened into a 2D document that can’t fully show what they have created. What if the reader could actually interact with your work, like 

- Explore your 3D models from different angles
- Run your code or simulations
- Adjust variables and see how results change
- Watch embedded videos or demos (e.g. YouTube clips) 

As new technologies are adopted when the benefits are clear and the barriers are low, we applied for the TUD’s Open Science Fund to explore a seemingly effortless workflow with Jupyter Book for open publishing scientific content. This grant was awarded in October 2025.

Using the grant, we created a workflow that produces both a static, high-quality pdf and an interactive website for your thesis, without additional work! The TUD guide to open publishing with JupyterBook provides a starter kit where your thesis is a website made in less than 5 minutes and automatically a high-quality pdf is created for the committee.


## The JBOSS starterkit
The [JBOSS starterkit](https://tud-jb-os.github.io/starterkit/) is an online GitHub repository set as a template. Therewith it is easy to copy as your own project - simply use this [link](https://github.com/new?template_name=starterkit&template_owner=TUD-JB-OS) and follow the steps described [here](https://tud-jb-os.github.io/starterkit/quickstart/). Within five minutes you have your own website and an automatically generated good looking downloadable pdf. 

In this project, we prefer to work with [pixi](https://pixi.prefix.dev/), a fast, modern, and reproducible package management tool. We included the most necessary software and packages that you will need, including JupyterLab and Typst.

## The TU Delft Typst template
The [TU Delft Typst template]() was originally designed for the use JBOSS project. It can be automatically included in the [JBOSS-starterkit](https://tud-jb-os.github.io/starterkit/) as the default template. Simply uncomment the line with `typst_export_tudelft.yml` and comment `typst_export_...`.

```yml

extends:
  - typst_export_tudelft.yml
  # - typst_export_general.yml
```

With every new push to GitHub, the pdf will be rebuild.

```{tip} Final edits
The conversion from markdown to Typst goes about 90% correct. You might want to tweak the very final version of your pdf. You can run `pixi run pdf` to make a local version of your pdf. The Typst files can be then found in the folder `_build/temp`. Editing these files with live preview can be done with the command `typst watch <filename>`.
```

## Typst
A full Typst template has been uploaded to the Typst ...

- where to find the repo
- how to refer to it