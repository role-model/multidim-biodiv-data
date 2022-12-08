---
title: "Visualization"
teaching: 60
exercises: 5
---

:::::::::::::::::::::::::::::::::::::: questions 

TODO

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

* Create a barplot of the rank species abundance distribution
* Create a barplot of the rank genetic diversity
* Create a plot of the phylogeny with `ape`
* Create a histogram of trait values
* **Bonus objective:** Modify the phylogeny with the tips colored according to their trait values

::::::::::::::::::::::::::::::::::::::::::::::::




:::::::::::::::::::::::::::::::::::::: challenge 

Now that you have read in `trait.csv` as the R object `traits`, you tried to visualize the distribution of your data, but ran into a problem. Correct your code so you can see the distribution of your trait! *Note*: your data has a single column named `trait`  
Your code:  
```r
histogram(traits$trait)
```

::::::::::::::::::: solution

```r
hist(traits$trait)
```
:::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

:::: challenge
### Coloring branches based on trait values
>You are interested in how the wing length phenotypic variable you measured maps onto the phylogeny. You decided to color the tips according to wing length using a continuous scale. However, you get wonky results when you run your code. How do you fix it to correctly map the colors? Assume your data is sorted by wing length.  
> Your code:  
```
wing_color <- colorRampPalette(c("blue", "red"))(length(birds$edge))
plot(birds, tip.color = wing_color)
```

Answer:  
::: solution
```
wing_color <- colorRampPalette(c("blue", "red"))(length(birds$wing.length))
plot(birds, tip.color = wing_color)
```
:::
::::


:::: challenge
### Rank ordering abundances
Generating a *rank* abundance plot requires ordering the abunances from greatest to least. Your raw data will typically not be ordered this way by default. Assume that `abunds` is a vector of abundances.

Fill in the blank below to sort the abunance values prior to plotting.
```
sorted <- sort(abunds, decreasing=______)
barplot(sorted)
```
::: solution
```
sorted <- sort(abunds, decreasing=TRUE)
barplot(sorted)
```
:::

::::

