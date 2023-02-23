---
title: "Introduction"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What are the four types of biodiversity data we'll be covering in this course? 
- What are the four steps in handling each type?
- What do the outcomes of analyzing multidimensional biodiversity data (MDBD) look like visualized? 
- What are some strategies for connecting data types?
- Where can you find MDBD?
- What are are CARE principles and why are they important?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...

1. Explain the four types of biodiversity data and the four steps in handling each
2. Interpret plots of MDBD
3. Find openly avaiable MDBD
4. Connect data to the Local Contexts Hub

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1

What do you think this plot says about ecological process?

:::::::::::::::::::::::: solution 

## Output

:::::::::::::::::::::::::::::::::


## Challenge 2: how do you nest solutions within challenge blocks?

:::::::::::::::::::::::: solution 

You can add a line with at least three colons and a `solution` tag.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Figures

You can also include figures generated from R Markdown:


```r
pie(
  c(Sky = 78, "Sunny side of pyramid" = 17, "Shady side of pyramid" = 5), 
  init.angle = 315, 
  col = c("deepskyblue", "yellow", "yellow3"), 
  border = FALSE
)
```

<div class="figure" style="text-align: center">
<img src="fig/introduction-rendered-pyramid-1.png" alt="pie chart illusion of a pyramid"  />
<p class="caption">Sun arise each and every morning</p>
</div>

Or you can use standard markdown for static figures with the following syntax:

`![optional caption that appears below the figure](figure url){alt='alt text for
accessibility purposes'}`

![You belong in The Carpentries!](https://raw.githubusercontent.com/carpentries/logo/master/Badge_Carpentries.svg){alt='Blue Carpentries hex person logo with no text.'}

## Math

One of our episodes contains $\LaTeX$ equations when describing how to create
dynamic reports with {knitr}, so we now use mathjax to describe this:

`$\alpha = \dfrac{1}{(1 - \beta)^2}$` becomes: $\alpha = \dfrac{1}{(1 - \beta)^2}$

Cool, right?

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `.md` files for episodes when you want static content
- Use `.Rmd` files for episodes when you need to generate output
- Run `sandpaper::check_lesson()` to identify any issues with your lesson
- Run `sandpaper::build_lesson()` to preview your lesson locally

::::::::::::::::::::::::::::::::::::::::::::::::

[r-markdown]: https://rmarkdown.rstudio.com/