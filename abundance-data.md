---
title: "Abundance Data"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to import abundance data?
- How to clean abundance data?
- How to summarize abundance data?
- How to vizualize abundance data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...

1. Import abundance data in a CSV format into R environment
2. Clean taxonomic names using the *taxize* package
3. Aggregate abundances
4. Calculate Hill numbers 
5. Interpret Hill numbers
6. Vizualize species abundance distributions
7. Interpret species abundance distribution plots
8. Connect species abundance patterns to Hill numbers


::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

foo bar

## Abndance data import

foo bar


::: challenge

### Import and clean abundance data

Rearrange these lines of code to import and clean an abundance dataset


```r
names(cleanTax) <- c('sp', 'clean_name')

cleanTax <- gnr_resolve(abund$sp, 
                        best_match_only = TRUE)

cleanTax <- cleanTax[, c('user_supplied_name', 'matched_name')]


cleanTax$matched_name <- gsub(' \\(.*', '', cleanTax$matched_name)


library(taxize)

abund <- read.csv('data/abund.csv')

abund <- aggregate(list(abund = abund$n), list(sp = abund$clean_name), sum)

abund <- merge(abund, cleanTax)
```

:::::: solution


```r
library(taxize)

abund <- read.csv('data/abund.csv')

cleanTax <- gnr_resolve(abund$sp, 
                        best_match_only = TRUE)

cleanTax$matched_name <- gsub(' \\(.*', '', cleanTax$matched_name)
cleanTax <- cleanTax[, c('user_supplied_name', 'matched_name')]
names(cleanTax) <- c('sp', 'clean_name')

abund <- merge(abund, cleanTax)

abund <- aggregate(list(abund = abund$n), list(sp = abund$clean_name), sum)
```

:::::::::::::::

:::::::::::::
