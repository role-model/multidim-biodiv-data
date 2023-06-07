---
title: "Abundance Data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---






::: questions 

- What is abundance data, and how can we use it to gain insights about a system?
- How do I clean and manipulate abundance data to prepare for analyses?
- How do I calculate summary statistics and relate these to ecological pattern?

:::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...

1. Describe ecological abundance data and what it can tell us about a system
1. Import and examine organismal abundance data from .csv files
1. Clean taxonomic names
2. Manipulate abundance data into different formats
2. Generate species abundance distribution plots from abundance data
3. Summarize species abundance data using Hill numbers
4. Interpret how different Hill numbers correspond to different signatures of species diversity


::::::::::::::::::::::::::::::::::::::::::::::::


# Introduction to abundance data

Abundance data is one of the most widely-collected biodiversity data types. It generally keeps track of how many individuals of each species (or taxonomic unit) are present at a site. It may also be recorded as relative abundances or percent cover, depending on the group. 

:::: discussion

How have you used species abundance data in your work?

::::

There's a huge diversity of applications of abundance data. Here, we'll focus on one of the most generally-applicable approaches, which is to look at the _diversity_ of a system. By diversity, we mean how abundance is distributed among the different taxonomic groups present in that system. This incorporates both species richness, and the _evenness_ of how abundances is portioned among different species.


Let's make this more concrete. If we plot the abundances of all the species in a system, sorted from most to least abundant, we end up with something like this:



This is the _species abundance distribution_, or SAD.

The SAD can show how even or uneven our system is.

Ok, great. What if we want to make comparisons between different systems? For that we need a quantifiable metric. 

There are dozens - literally - of summary statistics for ecological diversity. 

::: discussion

What diversity metrics have you encountered?

:::

For this workshop, we're going to focus on **Hill numbers**.

Hill numbers are a family of diversity indices that can be described verbally as the "effective number of species". That is, they describe how many species of _equal abundances_ would be present in a system to generate the corresponding diversity index.

::: discussion

Let's get into Hill numbers more on the whiteboard.

:::

Hill numbers are similar to other diversity indices you might have encountered. In fact, they mathematically converge with Shannon, Simpson, and species evenness.

# Working with abundance data

Ok, so how about we do some actual coding?

For this episode, we'll be working with a couple of specialized packages for biological data. 


```r
library(dplyr)
library(taxize)
library(hillR)
library(vegan)
library(tidyr)
```


## Loading data

We'll be working with ecological species abundance data stored in `.csv` files. For help working with other storage formats, [the Carpentries' Ecological Data lesson materials on databases](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html) are a great place to start!

Let's load the data:



```r
abundances <- read.csv("https://raw.githubusercontent.com/role-model/multidim-biodiv-data/rmd-review/episodes/data/abundances_raw.csv")
```

And look at what we've got:


```r
head(abundances)
```

`abundances` is a data frame with columns for `island`, `site`, `GenSp`, and `abundance`. Each row tells us how many individuals of each species (GenSp) were recorded at a given site on each island. This is a common format - imagine you are censusing a plant quadrat, counting up how many individuals of each species you see. 

## Cleaning taxonomic names

The first thing we'll want to do is check for human error wherever we can, in this case in the form of typos in data entry.

The `taxize` R package can help identify and resolve simple typos in taxonomic names. 


```r
species_list <- abundances$GenSp

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE, 
                            canonical = TRUE) # returns only name, not authority
```

::: instructor

From the `taxize` documentation:

> 503 Service Unavailable: This is typically a temporary problem; often given when a server is handling too many requests, and is briefly down.

Note that RMD is getting this error consistently Friday afternoon 5/19 and Monday morning 5/22.

:::



```r
head(name_resolve)
```


```r
mismatches <- name_resolve[ name_resolve$matched_name2 != name_resolve$user_supplied_name, ]

mismatches[, c("user_supplied_name", "matched_name2")]
```

Four of these are just typos. But `Agrotis chersotoides` in our data is resolved only to Agrotis. What's up there?

::: discussion

Agrotis taxonomic resolution

:::



```r
name_resolve$matched_name2[name_resolve$user_supplied_name == "Agrotis chersotoides"] <- "Peridroma chersotoides"
```



Now we need to add the newly-resolved names to our `abundances` data. For this, we'll use a function called `left_join`. 

::: discussion

Visual of how `left_join` works

:::



```r
abundances <- left_join(abundances, name_resolve, by = c("GenSp" = "user_supplied_name"))

abundances$final_name <- abundances$matched_name2
```




::: instructor

For now I am skipping cleaning the abundances name cleaning section because taxize is giving the server error. This may need some updating if there are duplicate species names once cleaned. _But_ that element of it will also probably change if we update the data (nestedness thing) so skippable for now.

:::



## Visualizing species abundance distributions

Now that we have cleaned data, we can generate plots of how abundance is distributed.

Because we'll want to look at each island separately, we'll use the `split` command to break the `abundances` data frame apart by island. `split` will split a dataframe into groups defined by the `f` argument (for "factor") - in this case, the different values of the `island` column of the `abundances` data frame:


```r
island_abundances <- split(abundances, f = abundances$island)
```

Usual practice is to plot distributions of abundance as the species abundance on the y-axis and the _rank_ of that species (from most-to-least-abundant) on the x-axis. This allows us to make comparisons between sites that don't have any species in common.

Now, we'll construct a plot with lines for the abundances of species on each island. 


```r
plot(
    sort(island_abundances$HawaiiIsland$abundance, decreasing = T),
    main = "Species abundances at each site",
    xlab = "Rank",
    ylab = "Abundance",
    lwd = 2,
    col = "#440154FF",
    xlim = c(0, 140),
    ylim = c(0, 40)
)

points(
    sort(island_abundances$Kauai$abundance, decreasing = T),
    lwd = 2,
    col = "#21908CFF"
)

points(
    sort(island_abundances$Maui$abundance, decreasing = T),
    lwd = 2,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Hawaii", "Kauai", "Maui"),
    lwd = 2,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)
```

<img src="fig/abundance-data-rendered-base R plots of SADs-1.png" style="display: block; margin: auto;" />

::: discussion

What do you notice about the SADs on the different islands?

:::



## Quantifying diversity using Hill numbers

Let's calculate Hill numbers to put some numbers to these shapes. 

For this, we'll need what's known as a **site by species matrix**. This is a very common data format for ecological diversity data. 

### Site-by-species matrix

A site by species sites as rows and species as columns. We can get there using the `pivot_wider` function from the package `tidyr`:


```r
abundance_wide <- pivot_wider(abundances, id_cols = site,
                              names_from = final_name,
                              values_from = abundance, 
                              values_fill = 0)

head(abundance_wide[,1:10])
```

We'll want this data to have _row names_ based on the sites, so we'll need some more steps:


```r
abundance_wide <- as.data.frame(abundance_wide)

row.names(abundance_wide) <- abundance_wide$site

abundance_wide <- abundance_wide[, -1]

head(abundance_wide)
```

### Calculating Hill numbers with `hillR`

The `hillR` package allows us to calculate Hill numbers. 


```r
hill_0 <- hill_taxa(abundance_wide, q = 0 )

hill_0
```


```r
hill_1 <- hill_taxa(abundance_wide, q = 1)

hill_1
```


::: challenge

Calculate the hill numbers for q = 2.


::: solution


```r
hill_2 <- hill_taxa(abundance_wide, q = 2)

hill_2
```

:::

:::


## Relating Hill numbers to patterns in diversity

Let's revisit the SAD plots we generated before, and think about these in terms of Hill numbers. 


```r
plot(
    sort(island_abundances$HawaiiIsland$abundance, decreasing = T),
    main = "Species abundances at each site",
    xlab = "Rank",
    ylab = "Abundance",
    lwd = 2,
    col = "#440154FF",
    xlim = c(0, 140),
    ylim = c(0, 40)
)

points(
    sort(island_abundances$Kauai$abundance, decreasing = T),
    lwd = 2,
    col = "#21908CFF"
)

points(
    sort(island_abundances$Maui$abundance, decreasing = T),
    lwd = 2,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Hawaii", "Kauai", "Maui"),
    lwd = 2,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)
```

<img src="fig/abundance-data-rendered-render SAD plots again-1.png" style="display: block; margin: auto;" />



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
    
