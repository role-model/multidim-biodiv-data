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



## Setup

For this lesson, we'll need a few packages commonly used in ecology.


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
library(ggplot2)
library(hillR)
```

## Introduction

If you've done work in the spheres of population or community ecology, chances are you have already worked some with organismal abundance data - that is, _counts of the population sizes of the different species within a system_. Here, we'll work through some approaches for importing, wrangling, and summarizing abundance data. 


## Data import 

Abundance data are often stored in the `.csv` format. Here, we'll load data from the `data` directory of this lesson.

::: instructor
We'll want to update the data path.


:::


```r
abundances <- read.csv("https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/abundance_data_cleaned.csv") 
```

## Data examination

The `abundances` data are simulated data for arthropods in the Hawaiian archipelago. We have real species names (this will be important later!) but computer-simulated occurrence and abundance values. 

Let's look at these data. 



```r
# look at a little bit of data
head(abundances)
```

```{.output}
        island            site                     GenSp abundance
1 hawaiiisland hawaiiisland_01     Abanchogastra debilis        10
2 hawaiiisland hawaiiisland_01  Abgrallaspis cyanophylli         3
3 hawaiiisland hawaiiisland_01         Acalles lateralis         2
4 hawaiiisland hawaiiisland_01            Aceria swezeyi         2
5 hawaiiisland hawaiiisland_01 Acrolepiopsis sapporensis        35
6 hawaiiisland hawaiiisland_01     Acrotelsa hawaiiensis        83
```


We see that we have columns for `island`, `site`, and `GenSp`, and `abundance`. We seem to have one site on each island. `GenSp` is the scientific name (*gen*us *sp*ecies). `abundance` is the total number of individuals of that species "observed" in our (fictitious) survey. 



```r
unique(abundances[, c('site', 'island')])
```

```{.output}
                site       island
1    hawaiiisland_01 hawaiiisland
886         kauai_01        kauai
1540         maui_01         maui
2267      molokai_01      molokai
```

## Cleaning

- checking for typos
- checking aggregation 



```r
library(taxize)


wtf <- gnr_resolve(abund$GenSp)
```



```r
# aggregation example
x <- aggregate(abund[, 'abundance', drop = FALSE], abund[, c('GenSp', 'site')], 
               sum)
```


## Visualization by species and site

As a first step, let's take a look at how species' abundances vary across different sites. We'll do this using the visualization package `ggplot2`.


Let's start by looking at the species composition on Hawaii itself:


```r
x1 <- abundances$abundance[abundances$site == 'hawaiiisland_01']
x4 <- abundances$abundance[abundances$site == 'kauai_01']
plot(x1)
hist(x1)
hist(log(x1))
plot(sort(x1, TRUE), log = 'y')


hawaii_abund <- abundances %>%
    filter(island == "hawaiiisland")

plot(sort(hawaii_abund, TRUE))

ggplot(hawaii_abund, aes(GenSp, abundance)) +
    geom_col() +
    theme(axis.text.x = element_text(angle = 90, size = 4))
```


This is nearly unreadable because of the high species richness (885!).

It gets harder if we incorporate all the islands:


```r
ggplot(abundances, aes(GenSp, abundance)) +
    geom_col() +
    facet_wrap(vars(island), scales = 'free')
```

This is a common problem with ecological abundance data. We often have a lot of species, too many to keep track of to tell a simple story or even really get a handle on via visualization. 

So, we need a different way of describing these data. Enter the species abundance distribution.

## Species abundance distributions

In working with species abundance distributions, we relinquish a focus on species *identity* and look instead at how abundance is *distributed* across all the species in a community. 

To construct a species abundance distribution, we need to arrange the species in each of our sites from most to least abundant and plot the curve.


```r
abundances_ranked <- abundances %>%
    group_by(site) %>%
    arrange(desc(abundance)) %>%
    mutate(rank = dplyr::row_number()) %>%
    ungroup()
```


```r
hawaii_abund_ranked <- abundances_ranked %>%
    filter(island == "hawaiiisland")

ggplot(hawaii_abund_ranked, aes(rank, abundance)) +
    geom_line()
```


::: challenge

Can you plot the SADs for all the islands in one plot?

:::

::: solution


```r
ggplot(abundances_ranked, aes(rank, abundance)) +
    geom_line() +
    facet_wrap(vars(island), scales = "free")
```
:::


## Re-formatting

## Summarizing species abundance data

::: discussion

What metrics have you encountered for comparing the shape of the species abundance distribution? Sometimes described as, describing or comparing the *diversity* of a system to another?

:::


Some common metrics include Shannon diversity, Simpson's evenness, or purely species richness. We can calculate these on our Hawaii data:



### Conventional diversity metrics


```r
abundances_diversity <- abundances_ranked %>%
    group_by(site) %>%
    summarize(richness = dplyr::n(),
              evenness = vegan::diversity(abundance, index = "simpson"),
              shannon = vegan::diversity(abundance, index = "shannon")) %>%
    ungroup()

abundances_diversity
```




::: challenge

Can you add the calculation of the inverse Simpson index to the `abundances_diversity` data?

:::

::: solution


```r
abundances_diversity <- abundances_ranked %>%
    group_by(site) %>%
    summarize(richness = dplyr::n(),
              evenness = vegan::diversity(abundance, index = "simpson"),
              shannon = vegan::diversity(abundance, index = "shannon"),
              invsimpson = vegan::diversity(abundance, index = "invsimpson")) %>%
    ungroup()
```
:::

### Hill numbers


::: discussion

Hill numbers provide a unified framework for summarizing abundance/diversity data. 

We'll encounter them throughout the workshop.

:::


```r
# load
abund <- read.csv("https://github.com/role-model/multidim-biodiv-data/raw/main/episodes/data/abundance_data.csv")

# examine
head(abund)
```


Talk about the data (fake, pretend hawaii, 4 sites, real taxa)

Talk about other data formats (site by species, 1 row per individual)

Make some pictorial examples of those data

Talk about cleaning up species names


```r
library(taxize)


wtf <- gnr_resolve(abund$GenSp)
```



Converting between data types


```r
# aggregation example
x <- aggregate(abund[, 'abundance', drop = FALSE], abund[, c('GenSp', 'site')], 
               sum)

# should we use tidyverse????
tidyr::pivot_wider(abund, names_from = site, values_from = abundance, 
                   values_fn = sum, values_fill = 0)

# same with base r
y <- tapply(abund$abundance, abund[, c('GenSp', 'site')], sum)
y[is.na(y)] <- 0
y[1:3, 1:3]
```

::: instructor

Here we could cut to a discussion/whiteboard of Hill numbers?

:::


#### Calculating Hill numbers using `hillR`

::: instructor

In v.2 let's update this to using roleR.

:::


```r
abundances_hill <- abundances_ranked %>%
    group_by(site) %>%
    summarize(hill0 = hill_taxa(abundance, q = 0),
              hill1 = hill_taxa(abundance, q = 1),
              hill2 = hill_taxa(abundance, q = 2)) %>%
    ungroup()
```


::: challenge

Compare the Hill number calculations to the diversity metrics we calculated earlier.

:::

::: solution


```r
left_join(abundances_diversity, abundances_hill )
```

We see that:

- `hill0` converges to species richness
- `hill2` converges to the inverse Simpson index.

What about `hill1`? `hill1` converges to the _exponential_ of Shannon's index:



```r
left_join(abundances_diversity, abundances_hill) %>%
    mutate(shannon_exp = exp(shannon))
```

:::

#### Interpreting Hill numbers

Let's look at how different values for each Hill number correspond to different shapes for the SAD.

Let's start with Hill number of order 1. 



```r
abundances_ranked_with_hill <- left_join(abundances_ranked, abundances_hill, by = "site")

ggplot(abundances_ranked_with_hill, aes(rank, abundance, color = hill1)) +
    geom_line() +
    facet_wrap(vars(site), scales = "free")
```


::: challenge

Build these same plots for Hill number order 2. 

:::


::: solution



```r
ggplot(abundances_ranked_with_hill, aes(rank, abundance, color = hill2)) +
    geom_line() +
    facet_wrap(vars(site), scales = "free")
```

:::

::: discussion

How do different SAD shapes affect the Hill numbers?

:::


## Recap

::: keypoints

- Organismal abundance data are a fundamental data type for population and community ecology.
- The species abundance distribution (SAD) summarizes site-specific abundance information to facilitate cross-site or over-time comparisons.
- We can quantify the shape of the SAD using *summary statistics*. Specifically, *Hill numbers* provide a unified framework for describing the diversity of a system.

:::
