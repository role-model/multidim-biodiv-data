---
title: "Abundance Data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---



::: questions 

- How is organismal abundance data typically stored?
- How is the species abundance distribution used to compare abundance data from differing systems?
- How do we use summary statistics - including Hill numbers - to quantitatively compare species abundance distributions?

:::

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
library(vegan)
```

```{.output}
Loading required package: permute
```

```{.output}
Loading required package: lattice
```

```{.output}
This is vegan 2.6-4
```

```r
library(tidyr)
```

# Data import and cleaning

## Loading data

We'll be working with ecological species abundance data stored in `.csv` files. For help working with other storage formats, [the Carpentries' Ecological Data lesson materials on databases](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html) are a great place to start!

Let's load the data:




```r
abundances <- read.csv("http://bit.ly/3INNA9V")
```

And look at what we've got:



```r
head(abundances)
```

```{.output}
  island     site               GenSp
1  Kauai Kauai_01 Xyleborus perforans
2  Kauai Kauai_01 Xyleborus perforans
3  Kauai Kauai_01 Xyleborus perforans
4  Kauai Kauai_01 Xyleborus perforans
5  Kauai Kauai_01 Xyleborus perforans
6  Kauai Kauai_01 Xyleborus perforans
```

`abundances` is a data frame with columns for `island`, `site`, and `GenSp`. These data are in a common format in which each row represents a single individual observed. 

## Cleaning taxonomic names

The first thing we'll want to do is check for human error wherever we can, in this case in the form of typos in data entry.

The `taxize` R package can help identify and resolve simple typos in taxonomic names. 


```r
species_list <- unique(abundances$GenSp)

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE, 
                            canonical = TRUE) # returns only name, not authority
```

```{.error}
Error: Service Unavailable (HTTP 503)
```



```r
head(name_resolve)
```

```{.error}
Error in eval(expr, envir, enclos): object 'name_resolve' not found
```


```r
mismatches <- name_resolve[ name_resolve$matched_name2 != name_resolve$user_supplied_name, ]
```

```{.error}
Error in eval(expr, envir, enclos): object 'name_resolve' not found
```

```r
mismatches[, c("user_supplied_name", "matched_name2")]
```

```{.error}
Error in eval(expr, envir, enclos): object 'mismatches' not found
```

Four of these are just typos. But `Agrotis chersotoides` in our data is resolved only to Agrotis. What's up there?

::: discussion

Agrotis taxonomic resolution

:::



```r
name_resolve$matched_name2[name_resolve$user_supplied_name == "Agrotis chersotoides"] <- "Peridroma chersotoides"
```

```{.error}
Error: object 'name_resolve' not found
```



Now we need to add the newly-resolved names to our `abundnaces` data:



```r
abundances <- left_join(abundances, name_resolve, by = c("GenSp" = "user_supplied_name"))
```

```{.error}
Error in eval(expr, envir, enclos): object 'name_resolve' not found
```

```r
abundances$final_name <- abundances$matched_name2
```


## Wrangling abundance data

The data we have have one record per individual, but we'd like to have the _total_ number of individuals of each species in our data. 



```r
abundance_tallies <- group_by(abundances, site, island, final_name)
```

```{.error}
Error in `group_by()`:
! Must group by variables found in `.data`.
✖ Column `final_name` is not found.
```

```r
abundance_tallies <- summarize(abundance_tallies, abundance = n())
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

```r
head(abundance_tallies)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

Write out the tallied data for later use:


```r
write.csv(abundance_tallies,  "abundance_tallies.csv", row.names = FALSE)
```


## Site-by-species matrix

Often we'll want to work with a _site by species matrix_, which has sites as rows and species as columns. We can get there using the `pivot_wider` function from the package `tidyr`:


```r
abundance_wide <- pivot_wider(abundance_tallies, id_cols = site,
                              names_from = final_name,
                              values_from = abundance, 
                              values_fill = 0)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

```r
head(abundance_wide[,1:10])
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

We'll want this data to have _row names_ based on the sites, so we'll need some more steps:


```r
abundance_wide <- as.data.frame(abundance_wide)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
row.names(abundance_wide) <- abundance_wide$site
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
abundance_wide <- abundance_wide[, -1]
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
head(abundance_wide)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

<!-- ```{r or base r} -->
<!-- x <- aggregate(abundances[, 'final_name', drop = FALSE], abundances[, c('final_name', 'site')],  -->
<!--                length) -->

<!-- head(x) #is identical -->
<!-- ``` -->

# Visualization via the species abundance distribution

## Separating the islands


```r
kauai_abund <- abundance_tallies[ abundance_tallies$island == "Kauai", ]
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

```r
maui_abund <- abundance_tallies[ abundance_tallies$island == "Maui", ]
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

```r
hawaiiisland_abund <- abundance_tallies[ abundance_tallies$island == "HawaiiIsland", ]
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_tallies' not found
```

## Plotting SADs


```r
plot(sort(hawaiiisland_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'hawaiiisland_abund' not found
```


::: challenge

Plot the rank-abundance distributions for the remaining islands.

:::


::: solution



```r
plot(sort(kauai_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'kauai_abund' not found
```



```r
plot(sort(maui_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'maui_abund' not found
```

:::



# Summary statistics

## Diversity indices

The `vegan` package is a widely-used toolset for calculating diversity indices on ecological abundance data. 

### Species richness



```r
richness <- specnumber(abundance_wide)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
richness
```

```{.error}
Error in eval(expr, envir, enclos): object 'richness' not found
```

### Shannon's index


```r
shannon <- diversity(abundance_wide, index = "shannon")
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
shannon
```

```{.error}
Error in eval(expr, envir, enclos): object 'shannon' not found
```



```r
exp_shannon <- exp(shannon)
```

```{.error}
Error in eval(expr, envir, enclos): object 'shannon' not found
```

```r
exp_shannon
```

```{.error}
Error in eval(expr, envir, enclos): object 'exp_shannon' not found
```

### Simpson's evenness



```r
simpson <- diversity(abundance_wide, index = "simpson")
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
simpson
```

```{.error}
Error in eval(expr, envir, enclos): object 'simpson' not found
```

::: challenge

Compute the *inverse* Simpson index.

(Hint: use `?diversity` to get more information about the `diversity` function).

:::


::: solution


```r
invsimpson <- diversity(abundance_wide, index = "invsimpson")
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
invsimpson
```

```{.error}
Error in eval(expr, envir, enclos): object 'invsimpson' not found
```

:::


### Combining values into a dataframe


```r
diversity_metrics <- rbind(exp_shannon, 
                           invsimpson,
                           richness)
```

```{.error}
Error in eval(expr, envir, enclos): object 'exp_shannon' not found
```

```r
diversity_metrics
```

```{.error}
Error in eval(expr, envir, enclos): object 'diversity_metrics' not found
```

## Hill numbers

::: discussion

Hill numbers are a unifying framework.

:::

### Calculating Hill numbers

The `hillR` package allows us to calculate Hill numbers in much the same way we calculate diversity indices in `vegan`.


```r
hill_0 <- hill_taxa(abundance_wide, q = 0 )
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
hill_0
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_0' not found
```


```r
hill_1 <- hill_taxa(abundance_wide, q = 1)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
hill_1
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_1' not found
```


::: challenge

Calculate the hill numbers for q = 2.

:::

::: solution


```r
hill_2 <- hill_taxa(abundance_wide, q = 2)
```

```{.error}
Error in eval(expr, envir, enclos): object 'abundance_wide' not found
```

```r
hill_2
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_2' not found
```

:::


### Combining and plotting Hill numbers


```r
hill_numbers <- rbind(hill_0, hill_1, hill_2)
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_0' not found
```

```r
hill_numbers
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_numbers' not found
```

::: discussion

Compare the values for the Hill numbers to the values we generated earlier for richness,  Shannon's index, and the inverse Simpson.

The following may help:


```r
diversity_metrics
```

```{.error}
Error in eval(expr, envir, enclos): object 'diversity_metrics' not found
```



```r
hill_numbers
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_numbers' not found
```


:::


## Relating Hill numbers to patterns in diversity

Let's revisit the SAD plots we generated before, and think about these in terms of Hill numbers. 


```r
par(mfrow = c(3,1))
plot(sort(hawaiiisland_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'hawaiiisland_abund' not found
```

```r
plot(sort(kauai_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'kauai_abund' not found
```

```r
plot(sort(maui_abund$abundance, TRUE))
```

```{.error}
Error in eval(expr, envir, enclos): object 'maui_abund' not found
```



```r
hill_numbers
```

```{.error}
Error in eval(expr, envir, enclos): object 'hill_numbers' not found
```



# Recap

::: keypoints

- Organismal abundance data are a fundamental data type for population and community ecology.
- The `taxise` package can help with data cleaning, but quality checks are often ultimately dataset-specific. 
- The species abundance distribution (SAD) summarizes site-specific abundance information to facilitate cross-site or over-time comparisons.
- We can quantify the shape of the SAD using *summary statistics*. Specifically, *Hill numbers* provide a unified framework for describing the diversity of a system.

:::
    
