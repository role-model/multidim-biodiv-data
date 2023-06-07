---
title: 'phylo_hill'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do you calculate phylogenetic hill numbers in R?
- How do different phylogenetic structures and community structures translate into different values for phylogenetic hill numbers?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Use `hillR` to calculate phylogenetic hill numbers in R
- Interpret how hill numbers change with different phylogenetic structures and community composition.

::::::::::::::::::::::::::::::::::::::::::::::::

::: instructor

Assumed to follow:

- introduction to Newick phylogenies, `ape`, hill numbers using `hillR`.

Assumed to precede (?):

- calculations on "real" data

:::

# Intro

Phylogenetic hill numbers incorporate information on both the phylogenetic structure of a system and the abundances of different species. We'll explore the behavior of some toy datasets to get an intuition for how these different components influence phylogenetic hill numbers. 

## Toy datasets


```r
library(ape)
library(hillR)

uneven_tree <- read.tree(text = '((A:0.5,B:0.5):2.5,C:3);')

plot(uneven_tree)
```

<img src="fig/phylo-hill-rendered-unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

```r
even_tree <- read.tree(text = '((A:2.5,B:2.5,C:2.5):0.5);')

plot(even_tree)
```

<img src="fig/phylo-hill-rendered-unnamed-chunk-1-2.png" style="display: block; margin: auto;" />

```r
uneven_community1 <- data.frame(
    A = 50,
    B = 50,
    C = 300
)

uneven_community2 <- data.frame(
    A = 225,
    B = 225,
    C = 50
)

even_community <- data.frame(
    A = 125,
    B = 125,
    C = 125
)
```

## Changing the phylogeny

First, let's see what happens if we have a hypothetical community that is completely even, and we vary the _phylogeny_.


```r
### Even tree

even_even <- data.frame(
    hill_nb = NA,
    q = 0:3,
    scenario = "even community, even tree"
)


for(i in 1:nrow(even_even)) {
    
    even_even$hill_nb[i] <- hill_phylo(even_community, even_tree, q = even_even$q[i])

}


even_even
```

```{.output}
   hill_nb q                  scenario
1 8.000000 0 even community, even tree
2 7.494149 1 even community, even tree
3 6.750000 2 even community, even tree
4 5.891883 3 even community, even tree
```

```r
### Uneven tree


even_uneven <- data.frame(
    hill_nb = NA,
    q = 0:3,
    scenario = "even community, uneven tree"
)


for(i in 1:nrow(even_uneven)) {
    even_uneven$hill_nb[i] <- hill_phylo(even_community, uneven_tree, q = even_uneven$q[i])
}


even_uneven
```

```{.output}
   hill_nb q                    scenario
1 6.500000 0 even community, uneven tree
2 6.123555 1 even community, uneven tree
3 5.785714 2 even community, uneven tree
4 5.511352 3 even community, uneven tree
```

::: callout

If community abundances are all equal, a more uneven tree (in terms of branch lengths) will give _lower_ overall hill numbers. 

:::

::: challenge

Experiment with changing branch lengths and see how this affects hill numbers in a perfectly even community.

You can use code based on this solution:

:::: solution


```r
# Update these branch lengths as much as you like
new_tree <- read.tree(text = '((A:0.5,B:0.5):0.5,C:3);') 

even_new <- data.frame(
    hill_nb = NA,
    q = 0:3,
    scenario = "even community, new tree"
)


for(i in 1:nrow(even_new)) {
    even_new$hill_nb[i] <- hill_phylo(even_community, new_tree, q = even_new$q[i])
}


plot(new_tree)
```

<img src="fig/phylo-hill-rendered-unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

```r
even_new
```

```{.output}
   hill_nb q                 scenario
1 4.500000 0 even community, new tree
2 4.352753 1 even community, new tree
3 4.166667 2 even community, new tree
4 3.952847 3 even community, new tree
```

:::

:::

## Changing species abundances with an even phylogeny


```r
### Even tree

even_even <- data.frame(
    hill_nb = NA,
    q = 0:3,
    scenario = "even community, even tree"
)


for(i in 1:nrow(even_even)) {
    
    even_even$hill_nb[i] <- hill_phylo(even_community, even_tree, q = even_even$q[i])

}


even_even
```

```{.output}
   hill_nb q                  scenario
1 8.000000 0 even community, even tree
2 7.494149 1 even community, even tree
3 6.750000 2 even community, even tree
4 5.891883 3 even community, even tree
```

```r
### Uneven tree


uneven1_even <- data.frame(
    hill_nb = NA,
    q = 0:3,
    scenario = "uneven community 1, even tree"
)


for(i in 1:nrow(uneven1_even)) {
    even_uneven$hill_nb[i] <- hill_phylo(uneven_community1, ueven_tree, q = even_uneven$q[i])
}
```

```{.error}
Error in eval(expr, envir, enclos): object 'ueven_tree' not found
```

```r
uneven1_even
```

```{.output}
  hill_nb q                      scenario
1      NA 0 uneven community 1, even tree
2      NA 1 uneven community 1, even tree
3      NA 2 uneven community 1, even tree
4      NA 3 uneven community 1, even tree
```


::::::::::::::::::::::::::::::::::::: keypoints 

- `hillR` calculates phylogenetic hill numbers given a phylogeny and a site by species matrix.
- Both the phylogenetic structure (branch lengths) and community structure (relative abundance of different species) contribute to phylogenetic hill numbers.

::::::::::::::::::::::::::::::::::::::::::::::::

