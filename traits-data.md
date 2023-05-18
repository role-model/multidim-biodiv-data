---
title: "Trait data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 72
---

:::::::::::::::::::::::::::::::::::::: questions

-   How do you read in and clean trait data?
-   What visualization techniques help you perform quality control and
    understand the distribution of your data?
-   What do Hill numbers convey in the context of trait data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...

1.  Import trait data in a CSV format into the R environment
2.  Clean taxonomic names using the `taxize` package
3.  Aggregate traits
4.  Visualize trait distributions
5.  Calculate Hill numbers
6.  Interpret Hill numbers using ranked trait plots

::::::::::::::::::::::::::::::::::::::::::::::::

We will work now with trait (i.e., phenotypic) data for communities in
the Hawaiian islands. Similarly to abundance, investigating trait data
can give insights into the ecological processes shaping different
communities. Specifically, it would be interesting to answer questions
like: 1) how much does a specific trait vary in a community?; 2) Are all
species converging into a similar trait value or dispersing into a wide
range of values for the trait?; 3) do those patterns of variation change
across different communities? Answering these questions can help us
understand how species are interacting with the environment and/or with
each other.

Here, we will work with a dataset containing values of **body mass** for
the species in the Hawaiian islands. Similar to the abundance data, each
row represents one specimen: in this dataset, each row contains the body
mass measured for that specimen. Our overall goal here is to clean this
data and attach it to the species data, so we can investigate trait
patterns per community.

We're starting with a challenge!

:::::: challenge

### Import and clean trait data

In the abundance-data episode, you learned how to read in a `CSV` file
with the `read.csv()` function. In addition, you learned how to clean
and standardize the taxonomic information in your data set using the
`gnr_resolve()` function from the `taxize` package.

You're going to use those skills to import and clean the trait data set.
The trait data set contains two columns: `GenSp`, which contains the
binomial species names, and `mass_g`, which contains the individual's
mass in grams, the metric of body size chosen for the study. The data
also contain typos and a problem with the taxonomy that you must correct
and investigate. Make sure to glance at the data before cleaning!

Your trait data is located at: <http://bit.ly/41GsgvE>

:::

::: solution

Read in the traits data using the `read.csv` function and supplying it
with the path to the data.


```r
traits <- read.csv('http://bit.ly/41GsgvE')
```

Check the names of the traits using the `gnr_resolve()` function. To
streamline your efforts, supply only the unique species names in your
data to `gnr_resolve()`.


```r
library(taxize)
# only need to check the unique names
species_list <- unique(traits$GenSp)

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE, canonical = TRUE)
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

To quickly see which taxa are in conflict with `taxize`'s, use bracket
subsetting and boolean matching.


```r
mismatches_traits <- name_resolve[name_resolve$user_supplied_name != name_resolve$matched_name2, c("user_supplied_name", "matched_name2")]
```

```{.error}
Error in eval(expr, envir, enclos): object 'name_resolve' not found
```

```r
mismatches_traits
```

```{.error}
Error in eval(expr, envir, enclos): object 'mismatches_traits' not found
```

Fixing the names comes in two steps. First, we join the `traits`
dataframe with the `name_resolve` dataframe using the `left_join()`
function. Note, we indicate that the `GenSp` and `user_supplied_name`
columns have the same information by supplying a named vector to the
`by =` argument.

:::::::::::::::::: instructor

```         
Remember, left_join is like sticking two things together with a shared
```

column

:::::::::::::::::::::::::::::::::::::::::::::::::::


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
traits <- left_join(traits, name_resolve[, c("user_supplied_name", "matched_name2")], by = c("GenSp" = "user_supplied_name"))
```

```{.error}
Error in eval(expr, envir, enclos): object 'name_resolve' not found
```

```r
head(traits)
```

```{.output}
                 GenSp   mass_g
1  Xyleborus perforans 10.13036
2  Xyleborus perforans 10.05684
3  Xyleborus perforans 10.14838
4  Xyleborus perforans 10.20234
5  Xyleborus perforans 10.14719
6 Agrotis chersotoides 24.25539
```

Then, to replace *Agrotis chersotoides* with the updated *Peridroma
chersotoides*, which you discovered in abundance-data episode, use
bracketed indexing, boolean matching, and assignment.

In addition, although not necessary, changing the column name
`matched_name2` to `final_name` to give it a more sensible name for
later use is good practice.


```r
traits$matched_name2[traits$matched_name2 == "Agrotis"] <- "Peridroma chersotoides"
```

```{.error}
Error in `$<-.data.frame`(`*tmp*`, matched_name2, value = character(0)): replacement has 0 rows, data has 1440
```

```r
colnames(traits)[colnames(traits) == "matched_name2"] <- "final_name"

head(traits)
```

```{.output}
                 GenSp   mass_g
1  Xyleborus perforans 10.13036
2  Xyleborus perforans 10.05684
3  Xyleborus perforans 10.14838
4  Xyleborus perforans 10.20234
5  Xyleborus perforans 10.14719
6 Agrotis chersotoides 24.25539
```

:::::::::::::::::: instructor

```         
Cleaning: - Solving for the species, standardizing taxonomy (`taxize`
                                                             package) - argument options and output of `taxize::gnr_resolve`
```

Get the one with maximum score

-   Coding for categorical data?
    -   Collapsing individual trait data and getting mean, median, SD
-   Merging trait data from different sources (individual-based vs
    species-based)
-   Creating a multi-dimensional trait database

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

<<<<<<< HEAD
# Aggregation

When analyzing trait data, it often needs to be summarized at a higher level than the individual. For instance, many community assembly
=======
:::

    # Aggregation
    
When analyzing trait data, it often needs to be summarized at a higher
level than the individual. For instance, many community assembly
>>>>>>> c86449c88ae44948adde76c7c0a39200bae38e26
analyses require species-level summaries, rather than individual
measurements. So, we often want to calculate summary statistics of
traits for each species. For numeric measurements, body size, statistics
like the mean, median, and standard deviation give information about the
center and spread of the distribution of traits for the species. For
this section, you will aggregate the trait data to the species level,
calculating the mean, median, and mode of body size for each species.

While there are methods to aggregate data in base R, the
[dplyr](https://dplyr.tidyverse.org/) makes this task and other data
wrangling tasks much more intuitive. The function `group_by()` groups
your data frame by a variable. The first argument to `group_by()` is
your data frame, and all following unnamed arguments are the variables
you want to group the data by. In our case, we want to group by species
name, so we'll supply `final_name`.


```r
library(dplyr)

# group the data frame by species
traits_sumstats <- group_by(traits, final_name)
```

```{.error}
Error in `group_by()`:
! Must group by variables found in `.data`.
✖ Column `final_name` is not found.
```

`group_by()` just adds an index that tells any following `dplyr`
functions to perform their calculations on the group the data frame was
indexed by. So, to perform the actual calculations, we will use the
`summarize()` function (`summarise()` works too for non-Americans). The
first argument you supply is the data frame, following by the
calculations you want to perform on the grouped data and what you want
to name the resulting variables. The structure is
`new_var_name = function(original_var_name)` for each calculation. Here,
we're using the `mean()`, `median()`, and `sd()` functions. Then, we'll
take a look at the new data set with the `head()` function.


```r
# summarize the grouped data frame, so you're calculating the summary statistics for each species
traits_sumstats <-
    summarize(
        traits_sumstats,
        mean_mass_g = mean(mass_g),
        median_mass_g = median(mass_g),
        sd_mass_g = sd(mass_g)
    )
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

```r
head(traits_sumstats)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

Finally, you need to add the aggregated species-level information back
to the abundance data, so you have the summary statistics for each
species at each site.

First, read in the abundance tallies dataframe you made in the abundance
episode.


```r
abundance_tallies <- read.csv("http://bit.ly/3L2OFxk")
```

To join the data, you'll use `left_join()`, which is hopefully getting
familiar to you now!

`abundance_tallies` should be on the left side, since we want the
species-information for each species in each community.


```r
traits_sumstats <- left_join(abundance_tallies, traits_sumstats, by = "final_name")
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

```r
head(traits_sumstats)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

# Visualize trait distributions

Histograms and density plots can help give you a quick look at the
distribution of your data. For quality control purposes, they are useful
to see if there are any suspicious values due to human error. Let's
overlay the histogram and density plots to get an idea of what
aggregated (histogram) and smoothed (density) representations of the
data look like.

The first argument to the `hist()` function is your data. `breaks` sets
the number of histogram bars, which can be tuned heuristically to find a
number of bars that best represents the distribution of your data. I
found that `breaks = 40` is a reasonable value. `xlab`, `ylab`, and
`main` are all used to specify labels for the x-axis, y-axis, and title,
respectively. When scaling the plot, sometimes base R plotting functions
aren't as responsive to the data as we like. To fix this, you can use
the `xlim` or `ylim` functions to set the value range of the x-axis and
y-axis, respectively. Here, we set `ylim` to a vector `c(0, 0.11)`,
which specifies the y-axis to range from 0 to 0.11.

If you're used to seeing histograms, the y-axis may look unfamiliar. To
get the two plots to use the same scale, you set `freq = FALSE`, which
converts the histogram counts to a density value. The density scales the
distribution from 0-1, so the bar height (and line height on the density
plot) is a fraction of the total distribution.

Finally, to add the density line to the plot, you calculate the density
of the trait distribution with the `density()` function and wrap it with
the `lines()` function.


```r
hist(
    traits_sumstats$mean_mass_g,
    breaks = 40,
    xlab = "Average mass (g)",
    ylab = "Density",
    main = "All species",
    ylim = c(0, 0.11),
    freq = FALSE
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

```r
lines(density(traits_sumstats$mean_mass_g))
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

In addition to quality control, knowing the distribution of trait data
lends itself towards questions of what processes are shaping the
communities under study. Are the traits overdispersed? Underdispersed?
Does the average vary across communities? To get at these questions, you
need to plot each site and compare among sites. To facilitate
comparison, you're going to layer the distributions on top of each other
in a single plot. Histograms get cluttered quickly, so let's use density
plots for this task.

To plot each site, you need a separate dataframe for each site. The
easiest way to do this is with the `split()` function, which takes a
dataframe followed by a variable to split the dataframe by. It then
returns a list of data frames for each element in the variable.

Running `head()` on the list returns a lot of output, so you can use the
`names()` function to make sure the names of the dataframes in your list
are the sites you intended to split by.


```r
# split by site
traits_sumstats_split <- split(traits_sumstats, traits_sumstats$site)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

```r
names(traits_sumstats_split)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

To plot the data, you first need to initialize the plot with the
`plot()` function of a single site's density. Here is also where you add
the plot aesthetics (labels, colors, line characteristics, etc.). You're
labeling the title and axis labels with `main`, `xlab`, and `ylab`. The
`lwd` ("linewidth") function specifies the size of the line, and I found
a value of two is reasonable. You then supply the color of the line
(`col`) with a color name or hex code. I chose a hex representing a
purple color from the
[viridis](https://sjmgarnier.github.io/viridisLite/index.html) color
palette. Finally, you need to specify the x-axis limits and y-axis
limits with `xlim` and `ylim`. While a negative mass doesn't make
biological sense, it is an artifact of the smoothing done by the
`density` function.

To add density lines to the plot, you use the `lines()` function with
the data for the desired site as the first argument. You also need to
specify the line-specific aesthetics for each line, which are the `lwd`
and `col`. I chose the green and yellow colors from the *viridis*
palette, but you can pick whatever your heart desires!

Finally, you need a legend for the plot. Within the `legend()` function,
you specify the position of the legend ("topright"), the legend labels,
the line width, and colors to assign to the labels.


```r
plot(
    density(traits_sumstats_split$HawaiiIsland_01$mean_mass_g),
    main = "Average mass per study site",
    xlab = "Average mass (g)",
    ylab = "Density",
    lwd = 2,
    col = "#440154FF",
    xlim = c(-3, 40),
    ylim = c(0, 0.11)
    
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
lines(
    density(traits_sumstats_split$Kauai_01$mean_mass_g),
    lwd = 2,
    col = "#21908CFF"
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
lines(
    density(traits_sumstats_split$Maui_01$mean_mass_g),
    lwd = 2,
    col = "#FDE725FF"
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
legend(
    "topright",
    legend = c("Hawaii 01", "Kauai 01", "Maui 01"),
    lwd = 2,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)
```

```{.error}
Error in (function (s, units = "user", cex = NULL, font = NULL, vfont = NULL, : plot.new has not been called yet
```

It looks like Kauai insects have a higher average mass and more
dispersed distribution of masses than Hawaii and Maui! Next, we'll take
a look at using Hill numbers to summarize the distribution of traits.

# Hill numbers

Hill numbers are a useful and informative summary of trait diversity, in
addition to other biodiversity variables ([Gaggiotti et al.
2018](https://onlinelibrary.wiley.com/doi/10.1111/eva.12593)). They
contain signatures of the processes underlying community assembly. To
calculate Hill numbers for traits, you're going to use the `hill_func()`
function from the `hillR` package. It requires two inputs- the site by
species abundance dataframe and a traits dataframe that has species as
rows and traits as columns.

:::::: challenge

Your first challenge, if you don't have the site by species abundance
dataframe, is to recreate it here. Remember, you'll need to use the
`pivot_wider()` function and the `abundance_tallies` data!

:::

:::: solution


```r
library(tidyr)

abundance_wide <- pivot_wider(
    abundance_tallies,
    id_cols = site,
    names_from = final_name,
    values_from = abundance,
    values_fill = 0
)

# tibbles don't like row names
abundance_wide <- as.data.frame(abundance_wide)

row.names(abundance_wide) <- abundance_wide$site

# remove the site column
abundance_wide <- abundance_wide[,-1]
```

:::::::::::::::::

```         
Now, to create the traits dataframe you first need to remove the `site`,
```

`island`, `abundance`, `median_mass_g`, and `sd_mass_g` columns.


```r
traits_simple <- traits_sumstats[, -c(1, 2, 4, 6, 7)]
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats' not found
```

```r
head(traits_simple)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

Next, you need to filter for unique species in the dataframe.


```r
traits_simple <- unique(traits_simple)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

```r
head(traits_simple)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

Finally, you need to set the species names to be row names and remove
the `final_name` column. Note, you have to use the `drop=F` argument
because R has the funny behavior that it likes to convert single-column
dataframes into a vector.


```r
row.names(traits_simple) <- traits_simple$final_name
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

```r
traits_simple <- traits_simple[,-1, drop=F]
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

Next, you'll use the `hill_func()` function from the `hillR` package to
calculate Hill numbers 0-2 of body size across sites.


```r
library(hillR)

traits_hill_0 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 0)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

```r
traits_hill_1 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 1)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

```r
traits_hill_2 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 2)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_simple' not found
```

The output of `hill_func()` returns quite a few Hill number options,
which are defined in [Chao et al.
2014](https://www.annualreviews.org/doi/abs/10.1146/annurev-ecolsys-120213-091540).
For simplicity's sake, we will look at `D_q`, which from the
documentation is the:

```         
> functional Hill number, the effective number of equally abundant and
```

> functionally equally distinct species


```r
traits_hill_1
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill_1' not found
```

To gain an intuition for what this means, let's plot our data. First,
you will wrangle the output into a single dataframe to work with. Since
Hill q = 0 is species richness, let's focus on Hill q = 1 and Hill q =
2.


```r
traits_hill <- list(traits_hill_1[3,], traits_hill_2[3,])
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill_1' not found
```

```r
traits_hill <- do.call(cbind, traits_hill)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill' not found
```

```r
colnames(traits_hill) <- c("q1", "q2")
```

```{.error}
Error: object 'traits_hill' not found
```

```r
# convert to a dataframe
traits_hill <- as.data.frame(traits_hill)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill' not found
```

```r
# I don't like rownames for plotting, so making the rownames a column
traits_hill$site <- row.names(traits_hill)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill' not found
```

```r
row.names(traits_hill) <- NULL
```

```{.error}
Error: object 'traits_hill' not found
```

Let's look at how Hill q = 1 compare across sites.


```r
plot(as.factor(traits_hill$site), traits_hill$q1, ylab = "Hill q = 1")
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill' not found
```

Hill q = 1 is smallest on Hawaii Island, largest on Maui, and in the
middle on Kauai. But what does this mean? To gain an intuition for what
a higher or lower trait Hill number means, you will make rank plots of
the trait data, to make a plot analogous to the species abundance
distribution.


```r
plot(
    sort(traits_sumstats_split$HawaiiIsland_01$mean_mass_g, decreasing = TRUE),
    main = "Average mass per study site",
    xlab = "Rank",
    ylab = "Average mass (mg)",
    pch = 19,
    col = "#440154FF",
    ylim = c(0, 40),
    xlim = c(0, 135)
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
points(
    sort(traits_sumstats_split$Kauai_01$mean_mass_g, decreasing = TRUE),
    pch = 19,
    col = "#31688EFF"
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
points(
    sort(traits_sumstats_split$Maui_01$mean_mass_g, decreasing = TRUE),
    pch = 19,
    col = "#35B779FF"
)
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
legend(
    "topright",
    legend = c("Hawaii 01", "Kauai 01", "Maui 01"),
    pch = 19,
    col = c("#440154FF", "#31688EFF", "#35B779FF")
)
```

```{.error}
Error in (function (s, units = "user", cex = NULL, font = NULL, vfont = NULL, : plot.new has not been called yet
```

You can see clearly that the diversity differs across islands, where
Maui has many more species than the other islands and a seemingly more
even distribution than the others. However, species richness strongly
influences the calculation of a Hill number. To factor out the influence
of the number of species from the Hill number and get a stronger
indicator of "evenness", you can divide the Hill number by the number of
species, which you will do for Hill q = 1.


```r
sp_counts <-
    c(
        nrow(traits_sumstats_split$HawaiiIsland_01),
        nrow(traits_sumstats_split$Kauai_01),
        nrow(traits_sumstats_split$Maui_01)
    )
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_sumstats_split' not found
```

```r
traits_hill$q1 / sp_counts
```

```{.error}
Error in eval(expr, envir, enclos): object 'traits_hill' not found
```

Interestingly, we see that Kauai actually has a more even distribution
of trait values than Maui when accounting for species richness!

What are some other interpretations from the plots, summary statistics,
and what you know fr
