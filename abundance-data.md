---
title: "Abundance Data"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How is organismal abundance data typically stored?
- How is the species abundance distribution used to compare abundance data from differing systems?
- How do we use summary statistics - including Hill numbers - to quantitatively compare species abundance distributions?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...


1. Import and examine organismal abundance data from .csv files
1. Clean taxonomic names
2. Manipulate abundance data into different formats
2. Generate species abundance distribution plots from abundance data
3. Summarize species abundance data using Hill numbers
4. Interpret how different Hill numbers correspond to different patterns in species diversity




::::::::::::::::::::::::::::::::::::::::::::::::


# Setup

For this episode, we'll be working with a couple of specialized packages for biological data. 


```r
library(dplyr)
```

```{.output}

Attaching package: 'dplyr'
```

```{.output}
The following objects are masked from 'package:stats':

    filter, lag
```

```{.output}
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union
```

```r
library(taxize)
library(hillR)
```

# Data import and cleaning

## Loading data

We'll be working with ecological species abundance data stored in `.csv` files. For help working with other storage formats, [the Carpentries' Ecological Data lesson materials on databases](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html) are a great place to start!

Let's load the data:

::: instructor
Fix the data path.
:::



```r
abundances <- read.csv("https://github.com/role-model/multidim-biodiv-data/raw/main/episodes/data/long_abundances.csv")
```

And look at what we've got:



```r
head(abundances)
```

```{.output}
  island     site                   GenSp
1  kauai kauai_01 Nesophrosyne umbratilis
2  kauai kauai_01 Nesophrosyne umbratilis
3  kauai kauai_01 Nesophrosyne umbratilis
4  kauai kauai_01      Entomobrya sauteri
5  kauai kauai_01      Trigonidium virens
6  kauai kauai_01      Oodemas longicorne
```

`abundances` is a data frame with columns for `island`, `site`, and `GenSp`. These data are in a common format in which each row represents a single individual observed. 

## Cleaning taxonomic names

The first thing we'll want to do is check for human error wherever we can, in this case in the form of typos in data entry.

The `taxize` R package can help identify and resolve simple typos in taxonomic names. 


```r
species_list <- unique(abundances$GenSp)

wtf <- gnr_resolve(species_list, best_match_only = TRUE, 
                           canonical = TRUE) # returns only name, not authority


# one clean/QC check is to remove entries with score < 0.6
```

Here is what I would do, naively:


```r
library(dplyr)

# don't need if using `best_match_only = TRUE` in `gnr_resolve`
# best_scores <- wtf %>% group_by(user_supplied_name) %>%
#     mutate(rank_score = dplyr::row_number()) %>%
#     filter(rank_score == 1) %>%
#     select(user_supplied_name,
#            matched_name)

abundances <- left_join(abundances, wtf, by = c("GenSp" = "user_supplied_name"))

unique(abundances[which(abundances$GenSp != abundances$matched_name), 
                  c("GenSp", "matched_name2")])
```

```{.output}
                          GenSp            matched_name2
94          Oodemas leiothoraxx       Oodemas leiothorax
144          Cirphis amblycasis                  Cirphis
292   Antrocephalus pertooorvus  Antrocephalus pertorvus
335  Aleurocanthus spiniferusis Aleurocanthus spiniferus
1430         Saldula oahuensiss        Saldula oahuensis
4985       Hylaeus anthracinuss      Hylaeus anthracinus
```

```r
abundances$final_name <- abundances$matched_name2
abundances$final_name[abundances$final_name == "Cirphis"] <- "Mythimna amblycasis" # This one I picked seems to be a synonym and this is the one that comes up on Wikipedia
```


## Wrangling abundance data

The data we have have one record per individual, but we'd like to have the _total_ number of individuals of each species in our data. 



```r
abundance_tallies <- group_by(abundances, site, island, matched_name2)
abundance_tallies <- summarize(abundance_tallies, abundance = n())
```

```{.output}
`summarise()` has grouped output by 'site', 'island'. You can override using
the `.groups` argument.
```

```r
abundance_tallies <- ungroup(abundance_tallies)

head(abundance_tallies)
```

```{.output}
# A tibble: 6 × 4
  site            island       matched_name2             abundance
  <chr>           <chr>        <chr>                         <int>
1 hawaiiisland_01 hawaiiisland Abgrallaspis cyanophylli          3
2 hawaiiisland_01 hawaiiisland Acalles lateralis                 2
3 hawaiiisland_01 hawaiiisland Aceria swezeyi                    2
4 hawaiiisland_01 hawaiiisland Acrolepiopsis sapporensis        35
5 hawaiiisland_01 hawaiiisland Acrotelsa hawaiiensis            83
6 hawaiiisland_01 hawaiiisland Aeletes longipes                 24
```


```r
x <- aggregate(abundances[, 'matched_name2', drop = FALSE], abundances[, c('matched_name2', 'site')], 
               length)

head(x) #is identical
```

```{.output}
              matched_name2            site matched_name2
1  Abgrallaspis cyanophylli hawaiiisland_01             3
2         Acalles lateralis hawaiiisland_01             2
3            Aceria swezeyi hawaiiisland_01             2
4 Acrolepiopsis sapporensis hawaiiisland_01            35
5     Acrotelsa hawaiiensis hawaiiisland_01            83
6          Aeletes longipes hawaiiisland_01            24
```

# Visualization via the species abundance distribution

## Plotting SADs

# Summary statistics

## Diversity indices

## Hill numbers

## Relating Hill numbers to patterns in diversity



# Recap

::: keypoints

- Organismal abundance data are a fundamental data type for population and community ecology.
- The `taxise` package can help with data cleaning, but quality checks are often ultimately dataset-specific. 
- The species abundance distribution (SAD) summarizes site-specific abundance information to facilitate cross-site or over-time comparisons.
- We can quantify the shape of the SAD using *summary statistics*. Specifically, *Hill numbers* provide a unified framework for describing the diversity of a system.

:::
