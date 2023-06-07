library(ape)

uneven_tree <- read.tree(text = '((A:0.5,B:0.5):2.5,C:3);')

plot(uneven_tree)

even_tree <- read.tree(text = '((A:2.5,B:2.5,C:2.5):0.5);')

plot(even_tree)


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



library(hillR)

## Even community

### Even tree

hill_phylo(even_community, even_tree, q = 0)
hill_phylo(even_community, even_tree, q = 1)
hill_phylo(even_community, even_tree, q = 2)
hill_phylo(even_community, even_tree, q = 3)


### Uneven tree


hill_phylo(even_community, uneven_tree, q = 0)
hill_phylo(even_community, uneven_tree, q = 1)
hill_phylo(even_community, uneven_tree, q = 2)
hill_phylo(even_community, uneven_tree, q = 3)

