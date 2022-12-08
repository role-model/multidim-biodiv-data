---
title: "Summary statistics"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What are summary statistics and why do we use them?
- What are the common summary metrics used for different data types and how are they calculated?
- How do Hill numbers unify multiple data types into the same framework?
- How do I calculate Hill numbers for different data types?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Describe what summary statistics are and articulate potential applications in analyses
- Calculate datatype-specific summary statitics for species abundance, population genetic, phylogenetic, and trait data
    - Use `vegan` to summarize species abundance and trait data in terms of evenness and diversity <!-- I believe vegan does traits --->
    - Use `ape` to summarize population genetic structure (genetic distance)
    - Use `phytools` to describe phylogenetic structure
- Use Hill numbers as a single framework for summarizing multiple dimensions of biodiversity data
    - Be able to articulate the high-level mathematical intuition behind Hill numbers
    - Use `hillR` to calculate Hill numbers for each data type
   
::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

TODO


::::::::::::::::::::::::::::::::::::: challenge

## Assumptions of vegan

Modify this code so it calculates Simpson evenness on the vector called `species_abundances`:

```
library(vegan)
diversity(species_abundances)
```

:::::::::::::::: solution

```
diversity(species_abundances, index = "simpson")
```

:::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::
