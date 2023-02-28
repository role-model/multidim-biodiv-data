## Reduce the number of species in the abundances data set


library(dplyr)

abundances <- read.csv(here::here("episodes", "data", "abundance_data.csv"))

unique_species <- unique(abundances$GenSp)


set.seed(1989)
selected_species <- unique_species[sample.int(length(unique_species), size = 500, replace = F)]

abundances <- abundances [ abundances$GenSp %in% selected_species, ]

abundances %>%
    group_by(island, GenSp) %>%
    summarize(nrecords = dplyr::n()) %>%
    ungroup() %>%
    filter(nrecords > 1)

## reintroduce some typos

typo_spots <- sample.int(length(abundances$GenSp), 5, replace = F)

intro_typo <- function(a_name) {

    typo_spot <- sample(nchar(a_name))

    typo_char <- sample(nchar(a_name), 1)

    a_typo_name <- paste0(substr(a_name, 0, typo_spot),
                          substr(a_name, typo_char, typo_char),
                          substr(a_name, typo_spot, nchar(a_name)))

    a_typo_name
}

abundances$GenSp[typo_spots] <- intro_typo(abundances$GenSp[typo_spots])


# make long

sp_repeat <- function(a_row) {

    island = a_row[1]
    site = a_row[2]
    GenSp = rep(a_row[3], times = a_row[4])


    data.frame(island = island,
               site = site,
               GenSp = GenSp)
}

long_abundances <- apply(as.matrix(abundances), MARGIN = 1, FUN = sp_repeat, simplify = T)

long_abundances <- bind_rows(long_abundances)

write.csv(long_abundances, here::here("episodes", "data", "long_abundances.csv"), row.names = F)
