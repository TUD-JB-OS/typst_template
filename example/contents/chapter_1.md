---
abstract: This is an example of a Typst based thesis template for Delft University of Technology. It includes options for cover page, abstract, ToC, logos, fonts, colors and more. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
---
# Chapter 1

## section 1 

Here is a nice equation:
```{math}
:label: my-equation1
w_{t+1} = (1 + r_{t+1}) s(w_t) + y_{t+1}
```

And here is a figure:

```{figure} ../figures/avatar.png
:label: myFigure11
:alt: Sunset at the beach
:align: center

With a nice caption
```

```{note}
This is a note!
```


## section 2 

A second section with a reference to equation {numref}`my-equation1` and {numref}`myFigure11`.

