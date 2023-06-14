---
title: Setup
---

## Learner expectations
We expect learners to have some familiarity with R, including a few basic concepts:
- what a function is and how to assign output of a function to an object, e.g. `object <- function(x)`
- read in tabular data, e.g. `read.csv()` for comma-separated values files
- bracket indexing, e.g. understanding that `data[,3]` returns the third column of the `data` dataframe.
- install and load packages, e.g. `install.packages()` and `library()`

If you need a bit of catching up, no worries! The Software Data Carpentries has a nice [Introduction to R and RStudio workshop](https://swcarpentry.github.io/r-novice-gapminder/) that will get you up to speed. The episodes up to and including "Subsetting Data" will get you where you need to be for this workshop. 

Additionally, you will need to have the latest versions of [R](https://cran.r-project.org/) and [RStudio](https://posit.co/downloads/) downloaded onto your personal computer.

## Software Setup

::::::::::::::::::::::::::::::::::::::: checklist

1. Please ensure you have R and RStudio (the latest versions would be best, and at minimum you will need R > 4.0.0).
1. Please also install the following packages using the general syntax `install.packages("package_name")`:

```

dplyr
tidyr
ape
taxize
hillR
spocc
rotl
rentrez

```

:::::::::::::::::::::::::::::::::::::::::::::::::::

## Project setup

::::::::::::::::::::::::::::::::::::::: checklist


1. We recommend creating an R project for this workshop. This will simplify your working directories, etc during the workshop. For more on creating R projects, see https://r4ds.had.co.nz/workflow-projects.html#rstudio-projects. 

::::::

## Data Sets

::::::::::::::::::::::::::::::::::::::: checklist


1. We will be working with some simulated datasets. Please download them from [DATA URL] and save them. We suggest saving them in a `data/` directory in your R project for this workshop.

:::::

## Troubleshooting

::::: callout

If you have any difficulties with these installations prior to the workshop, please reach out to the instruction team at [CONTACT] and we will be delighted to help figure things out!

:::::::
