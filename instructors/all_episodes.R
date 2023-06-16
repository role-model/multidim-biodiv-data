


## ----setup, include=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
knitr::opts_chunk$set(echo = TRUE,  results = FALSE, eval = TRUE)

library(dplyr)
library(taxize)
library(hillR)
library(vegan)
library(tidyr)


## ----first-SAD-visual, echo = F, include = F## ----## ----## ----## ----## ----## ----## ----## ----## -------





## ----load-packages, include = T, eval = F## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------

library(dplyr)
library(taxize)
library(hillR)
library(vegan)
library(tidyr)



## ----load-data## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
abundances <- read.csv("https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/abundances_raw.csv")


## ----examine-data## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------

head(abundances)



## ----taxize-nameresolve## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----

species_list <- abundances$GenSp

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE,
                            canonical = TRUE) # returns only name, not authority



## ----explore-taxise-outcomes## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
head(name_resolve)


## ----find-mismatches## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------


mismatches <- name_resolve[ name_resolve$matched_name2 !=
                                name_resolve$user_supplied_name, ]

mismatches[, c("user_supplied_name", "matched_name2")]



## ----fix-agrotis-metrothorax## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------

name_resolve$matched_name2[
    name_resolve$user_supplied_name == "Agrotis chersotoides"] <-
    "Peridroma chersotoides"

name_resolve$matched_name2[
    name_resolve$user_supplied_name == "Metrothorax deverilli"] <-
    "Metrothorax deverilli"



## ----join-abundances-names## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
abundances <- left_join(abundances, name_resolve, by = c("GenSp" = "user_supplied_name"))

abundances$final_name <- abundances$matched_name2

head(abundances)


## ----include = FALSE, eval = FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
write.csv(abundances, here::here("episodes", "data", "abundances_resolved.csv"), row.names = F)



## ---- include = FALSE, eval = FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----

abundances <- read.csv("https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/abundances_raw.csv")




## ----use-split, eval =T## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----

island_abundances <- split(abundances, f = abundances$island)



## ----base-R-SAD-plots, eval = TRUE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
# figure out max number of species at a site for axis limit setting below
max_sp <- sapply(island_abundances, nrow)
max_sp <- max(max_sp)

pdf('instructors/fig_sad.pdf', width = 3, height = 3)

par(mar = c(3, 3, 0, 0) + 0.5, mgp = c(2.5, 1, 0))

plot(
    sort(island_abundances$Kauai$abundance, decreasing = TRUE),
    # main = "Species abundances at each site",
    xlab = "Rank",
    ylab = "Abundance",
    cex = 1.4,
    lwd = 1.4,
    col = "#440154FF",
    xlim = c(1, max_sp),
    ylim = c(1, max(abundances$abundance)),
    log = 'y'
)

points(
    sort(island_abundances$Maui$abundance, decreasing = T),
    cex = 1.4,
    lwd = 1.4,
    col = "#21908CFF"
)

points(
    sort(island_abundances$BigIsland$abundance, decreasing = T),
    cex = 1.4,
    lwd = 1.4,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Kauai", "Maui", "Hawaii"),
    pch = 1,
    pt.cex = 1.4,
    pt.lwd = 1.4,
    col = c("#440154FF", "#21908CFF", "#FDE725FF"),
    bty = "n",
    cex = 0.8
)

dev.off()

## ----site-by-species-matrix## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----

abundance_wide <- pivot_wider(abundances, id_cols = site,
                              names_from = final_name,
                              values_from = abundance,
                              values_fill = 0)

head(abundance_wide[,1:10])



## ----sbys-row-names## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----

abundance_wide <- as.data.frame(abundance_wide)

row.names(abundance_wide) <- abundance_wide$site

abundance_wide <- abundance_wide[, -1]

head(abundance_wide)



## ----hill0## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----

hill_0 <- hill_taxa(abundance_wide, q = 0)

hill_0



## ----hill1## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----

hill_1 <- hill_taxa(abundance_wide, q = 1)

hill_1



## ----hill2## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----

hill_2 <- hill_taxa(abundance_wide, q = 2)

hill_2



## ----render-SAD-plots-again## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
plot(
    sort(island_abundances$Kauai$abundance, decreasing = TRUE),
    main = "Species abundances at each site",
    xlab = "Rank",
    ylab = "Abundance",
    lwd = 2,
    col = "#440154FF",
    xlim = c(1, max_sp),
    ylim = c(1, max(abundances$abundance)),
    log = 'y'
)

points(
    sort(island_abundances$Maui$abundance, decreasing = T),
    lwd = 2,
    col = "#21908CFF"
)

points(
    sort(island_abundances$BigIsland$abundance, decreasing = T),
    lwd = 2,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Kauai", "Maui", "Hawaii"),
    pch = 1,
    pt.lwd = 2,
    col = c("#440154FF", "#21908CFF", "#FDE725FF"),
    bty = "n",
    cex = 0.8
)



## ----look-at-hill-numbers-again## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
hill_numbers <- rbind(hill_0, hill_1, hill_2)
hill_numbers


## ----setup, include=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
knitr::opts_chunk$set(echo = TRUE,  results = FALSE, eval = FALSE)



## ----plot of trait diversity distribution## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------



## ----show trait hill numbers## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------





## ----trait-import-sol## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
traits <- read.csv('https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/body_size_data.csv')

head(traits)


## ----trait-resolve-sol1## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
library(taxize)
# only need to check the unique names
species_list <- unique(traits$GenSp)

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE,
                            canonical = TRUE)

head(name_resolve)


## ----trait-resolve-sol2## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
mismatches_traits <-
    name_resolve[name_resolve$user_supplied_name != name_resolve$matched_name2,
                 c("user_supplied_name", "matched_name2")]

mismatches_traits


## ----trait-resolve-sol3## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
library(dplyr)

traits <- left_join(traits,
                    name_resolve[, c("user_supplied_name", "matched_name2")],
                    by = c("GenSp" = "user_supplied_name"))

head(traits)


## ----trait-resolve-sol4## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
traits$matched_name2[traits$matched_name2 == "Agrotis"] <-
    "Peridroma chersotoides"

traits$matched_name2[traits$matched_name2 == "Metrothorax"] <-
    "Metrothorax deverilli"

colnames(traits)[colnames(traits) == "matched_name2"] <- "final_name"

head(traits)


## ----group-traits-species## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(dplyr)

# group the data frame by species
traits_sumstats <- group_by(traits, final_name)



## ----agg-traits-species## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
# summarize the grouped data frame, so you're calculating the summary statistics for each species
traits_sumstats <-
    summarize(
        traits_sumstats,
        mean_mass_g = mean(mass_g),
        median_mass_g = median(mass_g),
        sd_mass_g = sd(mass_g)
    )

head(traits_sumstats)


## ----read-abundance## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
abundances <- read.csv("https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/abundances_resolved.csv")

head(abundances)


## ----traits-sumstats-join## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
traits_sumstats <- left_join(abundances,
                             traits_sumstats,
                             by = "final_name")

head(traits_sumstats)


## ----density-all## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------

hist(
    traits_sumstats$mean_mass_g,
    breaks = 40,
    xlab = "Average mass (g)",
    ylab = "Density",
    main = "All species",
    freq = FALSE
)

lines(density(traits_sumstats$mean_mass_g))



## ----density-site-split## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
# split by site
traits_sumstats_split <- split(traits_sumstats, traits_sumstats$site)

names(traits_sumstats_split)


## ----density-site-plot## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
plot(
    density(traits_sumstats_split$KA_01$mean_mass_g),
    main = "Average mass per study site",
    xlab = "Average mass (g)",
    ylab = "Density",
    lwd = 2,
    col = "#440154FF",
    xlim = c(-3, 20),
    ylim = c(0, 0.25)
)

lines(
    density(traits_sumstats_split$MA_01$mean_mass_g),
    lwd = 2,
    col = "#21908CFF"
)

lines(
    density(traits_sumstats_split$BI_01$mean_mass_g),
    lwd = 2,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Kauai", "Maui", "Big Island"),
    lwd = 2,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)


## ----abundance-site-by-species## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
library(tidyr)

abundance_wide <- pivot_wider(
    abundances,
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


## ----traits-remove-cols## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
traits_simple <- traits_sumstats[, c("final_name", "mean_mass_g")]

head(traits_simple)


## ----traits-remove-dups## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
traits_simple <- unique(traits_simple)

head(traits_simple)


## ----traits-set-rownames## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
row.names(traits_simple) <- traits_simple$final_name

traits_simple <- traits_simple[, -1, drop = FALSE]

head(traits_simple)


## ----hill-traits## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
library(hillR)

traits_hill_0 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 0)

traits_hill_1 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 1)

traits_hill_2 <- hill_func(comm = abundance_wide, traits = traits_simple, q = 2)


## ----hill1-output## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
traits_hill_1


## ----traits-hill-df## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
traits_hill <- data.frame(q0 = traits_hill_0[3, ],
                          q1 = traits_hill_1[3, ],
                          q2 = traits_hill_2[3, ])

# I don't like rownames for plotting, so making the rownames a column
traits_hill$site <- row.names(traits_hill)

row.names(traits_hill) <- NULL


## ----hill-plot-raw## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
plot(factor(traits_hill$site, levels = c("KA_01", "MA_01", "BI_01")),
     traits_hill$q1, ylab = "Hill q = 1")


## ----hill-plot-rank## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
# figure out max number of species at a site for axis limit setting below
max_sp <- sapply(traits_sumstats_split, nrow)
max_sp <- max(max_sp)


plot(
    sort(traits_sumstats_split$KA_01$mean_mass_g, decreasing = TRUE),
    main = "Average mass per study site",
    xlab = "Rank",
    ylab = "Average mass (mg)",
    pch = 19,
    col = "#440154FF",
    xlim = c(1, max_sp),
    ylim = c(0, max(traits_simple$mean_mass_g))
)

points(
    sort(traits_sumstats_split$MA_01$mean_mass_g, decreasing = TRUE),
    pch = 19,
    col = "#21908CFF"
)

points(
    sort(traits_sumstats_split$BI_01$mean_mass_g, decreasing = TRUE),
    pch = 19,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Kauai", "Maui", "Big Island"),
    pch = 19,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)




## ----individuals-traits-plot## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
# replicate abundances
biIndividualsTrt <- rep(traits_sumstats_split$BI_01$mean_mass_g,
                        traits_sumstats_split$BI_01$abundance)
maIndividualsTrt <- rep(traits_sumstats_split$MA_01$mean_mass_g,
                        traits_sumstats_split$MA_01$abundance)
kaIndividualsTrt <- rep(traits_sumstats_split$KA_01$mean_mass_g,
                        traits_sumstats_split$KA_01$abundance)


plot(
    sort(kaIndividualsTrt, decreasing = TRUE),
    main = "Average mass across individuals",
    xlab = "Rank",
    ylab = "Average mass (mg)",
    pch = 19,
    col = "#440154FF",
    ylim = c(0, max(traits_simple$mean_mass_g))
)

points(
    sort(maIndividualsTrt, decreasing = TRUE),
    pch = 19,
    col = "#21908CFF"
)

points(
    sort(biIndividualsTrt, decreasing = TRUE),
    pch = 19,
    col = "#FDE725FF"
)

legend(
    "topright",
    legend = c("Kauai", "Maui", "Big Island"),
    pch = 19,
    col = c("#440154FF", "#21908CFF", "#FDE725FF")
)


## ----setup, include=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
knitr::opts_chunk$set(echo = FALSE,  results = FALSE, eval = FALSE)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(tidyr)
library(ape)
library(hillR)


## ----loading-ape## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
library(ape)


## ----read-example## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
example_tree <- read.tree(text = '((A:0.5,B:0.5):0.5,C:1);')


## ----plot-example## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
plot(example_tree)


## ----calling-example## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
example_tree


## ----calling-tips-edge## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
example_tree$tip.label

example_tree$edge.length


## ----reading-arthro-phylo## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
arthro_tree <- read.tree('https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/phylo_raw.nwk')

class(arthro_tree)


## ----plotting-phylogeny## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
plot(arthro_tree, type = 'fan', show.tip.label = F)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
arthro_tree$tip.label <- gsub('_',' ',arthro_tree$tip.label)


## ----eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
all_names <- unique(abundances$final_name)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
not_found <- !(all_names %in% arthro_tree$tip.label)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
all_names[not_found]


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
new_names <- all_names


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
new_names[not_found] <- c('ADD_LIST_HERE')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
abundances_phylo <- abundances
abundances_phylo$final_name <- new_names


## ----eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
arthro_tree_pruned <- keep.tip(arthro_tree,abundances_phylo$final_name)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
phylo_wide <- pivot_wider(abundances_phylo,
                          id_cols = site,
                          names_from = final_name,
                          values_from = abundance,
                          values_fill = 0)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
even_comm <- data.frame(rbind(rep(1,8))) # Abundance = 1 for all species
uneven_comm <- data.frame(rbind(seq(1,8))) # Abundance equal 1 for species A and goes up to 8 towards species H.

# We name the columns with the species names
colnames(even_comm) <- colnames(uneven_comm) <- c('A','B','C','D','E','F','G','H')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
short_tree <- read.tree(text='(((A:3,B:3):1,(C:3,D:3):1):1,((E:3,F:3):1,(G:3,H:3):1):1);')
long_tree <- read.tree(text='(((A:6,B:6):1,(C:6,D:6):1):1,((E:6,F:6):1,(G:6,H:6):1):1);')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
plot(short_tree)
plot(long_tree)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
even_comm_short_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "even",
    tree = "short"
)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(hillR)
for(i in 1:nrow(even_comm_short_tree)) {
    even_comm_short_tree$hill_nb[i] <- hill_phylo(even_comm, short_tree, q = even_comm_short_tree$q[i])
}


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
even_comm_long_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "even",
    tree = "long"
)

for(i in 1:nrow(even_comm_long_tree)) {
    even_comm_long_tree$hill_nb[i] <- hill_phylo(even_comm, long_tree, q = even_comm_long_tree$q[i])
}


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
even_comm_nb <- data.frame(rbind(even_comm_short_tree,even_comm_long_tree))

plot(even_comm_nb$q[even_comm_nb$tree=='short'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='short'],
     type='b',col='red',
     xlab = 'Order',ylab='Hill values',
     xlim = range(even_comm_nb$q),
     ylim = range(even_comm_nb$hill_nb))

lines(even_comm_nb$q[even_comm_nb$tree=='long'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='long'],
     type='b',col='darkred')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# Uneven comm with short tree
uneven_comm_short_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "uneven",
    tree = "short"
)

for(i in 1:nrow(uneven_comm_short_tree)) {
    uneven_comm_short_tree$hill_nb[i] <- hill_phylo(uneven_comm, short_tree, q = uneven_comm_short_tree$q[i])
}

# Uneven comm with long tree
uneven_comm_long_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "uneven",
    tree = "long"
)

for(i in 1:nrow(uneven_comm_long_tree)) {
    uneven_comm_long_tree$hill_nb[i] <- hill_phylo(uneven_comm, long_tree, q = uneven_comm_long_tree$q[i])
}

# Combining results
uneven_comm_nb <- data.frame(rbind(uneven_comm_short_tree,uneven_comm_long_tree))


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
plot(even_comm_nb$q[even_comm_nb$tree=='short'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='short'],
     type='b',col='red',
     xlab = 'Order',ylab='Hill values',
     xlim = range(even_comm_nb$q),
     ylim = range(min(uneven_comm_nb$hill_nb),max(even_comm_nb$hill_nb)))

lines(even_comm_nb$q[even_comm_nb$tree=='long'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='long'],
     type='b',col='darkred')

lines(uneven_comm_nb$q[uneven_comm_nb$tree=='short'],
     uneven_comm_nb$hill_nb[uneven_comm_nb$tree=='short'],
     type='b',col='lightblue')

lines(uneven_comm_nb$q[uneven_comm_nb$tree=='long'],
     uneven_comm_nb$hill_nb[uneven_comm_nb$tree=='long'],
     type='b',col='darkblue')


## ---- eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
balanced_tree <- read.tree(text='(((A:1,B:1):1,(C:1,D:1):1):1,((E:1,F:1):1,(G:1,H:1):1):1);')


## ---- eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
unbalanced_tree <- read.tree(text='(A:7,(B:6,(C:5,(D:4,(E:3,(F:2,(G:1,H:1):1):1):1):1):1):1);')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
plot(even_tree)
plot(uneven_tree)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
even_comm_even_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "even",
    tree = "even"
)

for(i in 1:nrow(even_comm_even_tree)) {
    even_comm_even_tree$hill_nb[i] <- hill_phylo(even_comm, even_tree, q = even_comm_even_tree$q[i])
}

even_comm_uneven_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "even",
    tree = "uneven"
)

for(i in 1:nrow(even_comm_uneven_tree)) {
    even_comm_uneven_tree$hill_nb[i] <- hill_phylo(even_comm, uneven_tree, q = even_comm_uneven_tree$q[i])
}

even_comm_nb <- data.frame(rbind(even_comm_even_tree,even_comm_uneven_tree))

plot(even_comm_nb$q[even_comm_nb$tree=='even'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='even'],
     type='b',col='red',
     xlab = 'Order',ylab='Hill values',
     xlim = range(even_comm_nb$q),
     ylim = range(even_comm_nb$hill_nb))

lines(even_comm_nb$q[even_comm_nb$tree=='uneven'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='uneven'],
     type='b',col='darkred')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
uneven_comm_even_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "uneven",
    tree = "even"
)

for(i in 1:nrow(uneven_comm_even_tree)) {
    uneven_comm_even_tree$hill_nb[i] <- hill_phylo(uneven_comm, even_tree, q = uneven_comm_even_tree$q[i])
}

uneven_comm_uneven_tree <- data.frame(
    hill_nb = NA,
    q = 0:3,
    comm = "uneven",
    tree = "uneven"
)

for(i in 1:nrow(uneven_comm_uneven_tree)) {
    uneven_comm_uneven_tree$hill_nb[i] <- hill_phylo(uneven_comm, uneven_tree, q = uneven_comm_uneven_tree$q[i])
}

uneven_comm_nb <- data.frame(rbind(uneven_comm_even_tree,uneven_comm_uneven_tree))

plot(even_comm_nb$q[even_comm_nb$tree=='even'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='even'],
     type='b',col='red',
     xlab = 'Order',ylab='Hill values',
     xlim = range(even_comm_nb$q),
     ylim = range(min(uneven_comm_nb$hill_nb),max(even_comm_nb$hill_nb)))

lines(even_comm_nb$q[even_comm_nb$tree=='uneven'],
     even_comm_nb$hill_nb[even_comm_nb$tree=='uneven'],
     type='b',col='darkred')

lines(uneven_comm_nb$q[uneven_comm_nb$tree=='even'],
     uneven_comm_nb$hill_nb[uneven_comm_nb$tree=='even'],
     type='b',col='lightblue')

lines(uneven_comm_nb$q[uneven_comm_nb$tree=='uneven'],
     uneven_comm_nb$hill_nb[uneven_comm_nb$tree=='uneven'],
     type='b',col='darkblue')


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
hill_values <- vector('list',length = 4)
for (i in seq(0,3)) {
  hill_values[[i+1]] <- hill_phylo(phylo_wide,arthro_tree_pruned, q = i)
}


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
hill_values <- do.call(cbind.data.frame,hill_values)
colnames(hill_values) <- c('q0','q1','q2','q3')
hill_phylo_nbs <- data.frame(site = c('HawaiiIsland_01','Kauai_01','Maui_01'),
                             hill_values)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
plot(seq(0,3),hill_phylo_nbs[1,2:5],
     type='b',col="#440154FF",
     xlab = 'Order',ylab='Hill values',
     xlim = c(0,3),
     ylim = range(9,15))

lines(seq(0,3),hill_phylo_nbs[2,2:5],
      type='b',col="#21908CFF")

lines(seq(0,3),hill_phylo_nbs[2,2:5],
      type='b',col="#FDE725FF")


## ----setup, include=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
knitr::opts_chunk$set(echo = TRUE,  results = FALSE, eval = FALSE)



## ----alignment-read## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
library(msa)

seq_path <- "/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/Courses/Spring-2019/Machine-Learning/project/fasta/hypsiboas_seqs_aligned.fas"

seqs <- readDNAStringSet(seq_path)

seqs


## ----alignment## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
alignment <- msa(seqs, method = "ClustalOmega")

alignment



## ----alignment-remove-ind## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# remove individual
seqs_filt <- seqs[!(names(seqs) %in% "Itar128")]

seqs_filt


## ----alignment-realign## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
alignment <- msa(seqs_filt, method = "ClustalOmega")

alignment


## ----alignment-convert## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
ape_align <- msaConvert(alignment, type = "ape::DNAbin")

ape_align


## ----alignment-write## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
ape::write.FASTA(ape_align, "path/to/alignment.fas")


## ----ape-filt-inds## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
library(ape)

checkAlignment(ape_align, what = 1)


## ----fas-full-pi## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
fas_gendist <- dist.dna(ape_align, model = "raw", pairwise.deletion = TRUE)

fas_gendist


## ----fas-hist## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
hist(fas_gendist)


## ----fas-full-upper-tri## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
fas_gendiv <- median(fas_gendist)

fas_gendiv


## ----fas-read-multipop## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
fas_paths <- list.files("...", full.names = TRUE)

fas_alignments <- lapply(fas_paths, read.dna)



## ----fas-pop-pi## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
fas_gendist_pop <- lapply(fas_alignments, dist.dna, model = "raw", pairwise.deletion = TRUE)

fas_gendiv_pop <- sapply(fas_gendist_pop, median)

plot(fas_gendiv_pop)


## ----vcfr-read, message=FALSE, eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(vcfR)
snps <- read.vcfR(vcf_path)


## ----vcfR-to-genind, eval=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
library(adegenet)
snps_genind <- vcfR2genind(
    snps,
    n.cores = 1,
    ploidy = 2,
    check.ploidy = FALSE,
    pop = pops
    )

snps_genind


## ----per-ind-gendist-vcf## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
snps_gendist_ind <- dist(snps_genind, method = "euclidean")


## ----per-pop-gendiv-vcf## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----
snps_genpop <- genind2genpop(snps_genind)

snps_gendist_pop <- dist.genpop(snps_genpop, method = 1)


## ----fst-vcf## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -------
library(hierfstat)
snps_hierfstat <- genind2hierfstat(snps_genind)

snps_fst <- pairwise.fst(snps_hierfstat, diploid = TRUE)

hist(snps_fst[upper.tri(snps_fst)])


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(hillR)

# columns are SNPs, rows are individuals
# treat it like abundances
intra_hill_1 <- hillR::hill_taxa(snp_matrix, q = 1)



## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# calculate pairwise distance matrices
per_species_dist <- lapply(species_alignments, ape::dist.dna, model = "raw", as.matrix = TRUE)

mat_avg <- function(x) {
    y <- x[upper.tri(x)]
    m <- mean(y)
    return(y)
}

per_species_pi <- sapply(per_species_dist, mat_avg)

hist(per_species_pi)



## ---- plot-SFS, echo=FALSE## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----

library(tibble)
library(ggplot2)
d <- tibble(
    x = seq(1, 30),
    y = exp(-0.7 * x) * 0.7
)

set.seed(1111)
d$y <- d$y + abs(rnorm(length(d$y), 0, 0.01))

d <- d[d$x < 20,]

ggplot() +
    geom_col(data = d, aes(x = x, y = y)) +
    labs(x = "Allele frequency in the population",
         y = "Proportion of sampled SNPs") +
    theme_bw() +
    theme(panel.grid = element_blank())



## ---- plot-SFS-demography, echo=FALSE, fig.show="hold", out.width="50%"## ----## ----## ----

contraction_df <- tibble(
    x = seq(1, 30),
    y = exp(-0.7 * x) * 0.8
)

contraction_df <- contraction_df[contraction_df$x < 20,]

contraction_plot <- ggplot() +
    geom_col(data = contraction_df, aes(x = x, y = y)) +
    labs(x = "Allele frequency in the population",
         y = "Proportion of sampled SNPs",
         title = "Population contraction") +
    theme_bw() +
    theme(panel.grid = element_blank())

expansion_df <- d

set.seed(2223)

expansion_df$y[expansion_df$x > 10] <- expansion_df$y[expansion_df$x > 10] + abs(rnorm(length(expansion_df$y[expansion_df$x > 10]), 0, 0.03))

expansion_plot <- ggplot() +
    geom_col(data = expansion_df, aes(x = x, y = y)) +
    labs(x = "Allele frequency in the population",
         y = "Proportion of sampled SNPs",
         title = "Population expansion") +
    theme_bw() +
    theme(panel.grid = element_blank())

contraction_plot
expansion_plot


## ----setup## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## -----
library(spocc)
library(rentrez)
library(rotl)
library(taxize)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(taxize)
uid <- get_uid("Tetragnatha")


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
species_uids <- downstream(uid,downto="species")
species_names <- species_uids[[1]]$childtaxa_name

head(species_names)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------

library(spocc)
library(dplyr)

occurrences <- occ(query = species_names, from = 'gbif', has_coords=TRUE,
                   gbifopts=list("decimalLatitude"='18.910361,28.402123',
                                 "decimalLongitude"='-178.334698,-154.806773'))

# extract the data from gbif
occurrences_gbif <- occurrences$gbif$data

# the results in `$data` are a list with one element per species,
# so we combine all those elements
occurrences_df <- bind_rows(occurrences_gbif)

head(occurrences_df)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
hiTetragnatha <- unique(occurrences_df$name)
hiTetClean <- gnr_resolve(hiTetragnatha, best_match_only = TRUE,
                          canonical = TRUE)
hiTetragnatha <- hiTetClean$matched_name2
hiTetragnatha


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
resolved_names <- tnrs_match_names(hiTetragnatha)
otol_ids <- ott_id(resolved_names)



## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))

plot(tr)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# note we're using `hiTetragnatha` that we made previously to make a long
# string of names that will be sent to NCBI via the ENTREZ API
termstring <- paste(sprintf('%s[ORGN]', hiTetragnatha), collapse = ' OR ')
head(termstrig)

search_results <- entrez_search(db="nucleotide", term = termstring)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------

sequences <- entrez_fetch(db = "nucleotide", id = search_results$ids,
                          rettype = "fasta")

# just look at the first part of this *long* returned string
cat(substr(sequences, 1, 1148))

## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
library(jsonlite)
library(httr)

# the API documentation tells us this is the base URL to access the API
baseURL <- "https://localcontextshub.org/api/v1"

# to retrive project information, we add this to the base URL
projDetail <- "/projects/<PROJECT_UNIQUE_ID>/"

# we need to know the protect ID, we can find it in our LC Hub account
projID <- "6d34be51-0f60-4fc5-a699-bed4091c02e0"

# now we start to construct our query string
q <- paste0(baseURL, projDetail)
q


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# we need to replace "<PROJECT_UNIQUE_ID>" with `projID`
q <- gsub("<PROJECT_UNIQUE_ID>", projID, q)
q


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# now we can use functions from jsonlite and httr to pull the info
rawRes <- GET(q)
jsonRes <- rawToChar(rawRes$content)

res <- fromJSON(jsonRes)

# have a look
res


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
remotes::install_github("jacobgolan/enRich")
library(enRich)


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
projID <- "6d34be51-0f60-4fc5-a699-bed4091c02e0"
meDNA <- find.projects(projID)
meDNA


## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ----## ------
# read in a fasta file using the dedicated function from enRich
seqs <- readFASTA('https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/big_island_seqs.fas')

# just for demonstration purposes, set up a temporary directory
temp <- tempdir()

# write out the file
outputFASTA(
    seqs = seqs$sequence,
    seqid = seqs$name,
    uqID = projID, # the uniqe ID for the project we found above in Step 3
    filename = file.path(temp, "seqs-LCH-ID") # .fasta is automatically added
)

# read it back in and notice that the LC Hub ID is now in the fasta header
res <- readLines(file.path(temp, "seqs-LCH-ID.fasta"), n = 10)
cat(res)

