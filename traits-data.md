---
title: "Importing and summarizing trait data"
teaching: 10
exercises: 2
---


::: questions

- How do you import trait data?
- How do you clean trait data?
- How do you summarize trait data?
- How do you visualize trait data?

:::::::::::::

::: objectives

After following this episode, participants should be able to...

1. Import trait data in a CSV format into the R environment
2. Clean taxonomic names using the `taxize` package
3. Aggregate traits
4. Calculate Hill numbers 
5. Interpret Hill numbers
6. Visualize trait distributions
7. Interpret trait distribution plots
8. Connect trait distribution patterns to Hill numbers

::::::::::::::

# 1. Importing and cleaning the data

A little background on trait literature? Why do we want to look at traits?
The distribution of traits gives hints about the ecological processes in that community.
- Traits values clustering together
- Traits very dispersed
- A few traits super represented
- Random distribution of traits
- Correlation among traits (when using multidimensional trait)?

One trait or several traits
Unit does not matter, as long as they are numeric values of a variable

Different formats we might expect for trait data
- Categorical vs continuous traits?
- Data can come per individual (direct measurement) or per species (from the literature).

Read with `read.csv`

Cleaning:
- Solving for the species, standardizing taxonomy (`taxize` package)
    - argument options and output of `taxize::gnr_resolve`

[From taxsize vignette](http://cran.nexr.com/web/packages/taxize/vignettes/taxize_vignette.html)
"taxize takes the approach that the user should be able to make decisions about what resource to trust,
rather than making the decision. Both the EOL GNR and the TNRS services provide data from a variety of data sources.
The user may trust a specific data source, thus may want to use the names from that data source. In the future,
we may provide the ability for taxize to suggest the best match from a variety of sources."


temp <- gnr_resolve(names = c("Helianthos annus", "Homo saapiens"), best_match_only = TRUE)

Get the one with maximum score

- Coding for categorical data?
- Collapsing individual trait data and getting mean, median, SD
- Merging trait data from different sources (individual-based vs species-based)
- Creating a multi-dimensional trait database


:::::: challenge

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

::: solution


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

:::::::::::

::::::::::::::

# Basic visualization of trait distribution

- Visualizing the distribution of one trait (body size) over the community


# Visualizing with abundance


# Summary stats


1. Introduction








# Chunks of code to keep

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Inline instructor notes can help inform instructors of timing challenges
associated with the lessons. They appear in the "Instructor View"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::: challenge

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

::: solution


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

:::::::::::

::::::::::::::


