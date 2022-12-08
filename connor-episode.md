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

