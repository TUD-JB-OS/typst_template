# Example page

This is an example page to show how a regular thesis page could look like, including a formula like the one in @eq:NS, see @constantin1988navier for more information on the Navier-Stokes equation. Note that the bibliography style can be specified in the export.yml file!

```{note} Numbered references
The referencing is now not correctly done. This is a problem in the myst-to-typst export rather than an error in our template.
```

You can include figures, set their width, label them and refer to them. In @fig_setup we provide the schematic setup of an experiment carried out in the TU Delft's first year physics lab course [@10.1103/PhysRevPhysEducRes.20.010117]. It illustrates how a cappuccino machine works: water is evaporated, the steam is blown into the milk and heats it using latent heat. 

```{figure} fig.png
:width: 70%
:label: fig_setup

A schematic figure of the experimental setup to determine the latent heat of water.
```

This chapter presents the experimental results and key observations.

$$
\rho\left(\frac{\delta \mathbf{u}}{\delta t} + (\mathbf{u}\cdot\nabla)\mathbf{u}\right)
= -\nabla p + \mu\nabla^2\mathbf{u} + \mathbf{f}
$$(eq:NS)


:::{table} Here is nice looking markdown made caption
:label: table
:align: center

|category 1 | category 2 | category 3|
| --- | --- | --- |
| item 1 | item 2 | item 3|
| item 4 | item 5 | item 6|
:::