## Reduce the number of species in the abundances data set


library(dplyr)

abundances <- read.csv(here::here("episodes", "data", "abundance_data.csv"))

unique_species <- unique(abundances$GenSp)


## Use taxize to find which species have challenging matches

library(taxize)

us_list <- list(
    unique_species[1:800],
    unique_species[801:1600],
    unique_species[1601:2377]
)

us_resolved <- lapply(us_list, FUN = taxize::gnr_resolve, best_match_only = T, canonical = TRUE)

us_taxized <- bind_rows(us_resolved)

original_data <- data.frame(
    GenSp = unique_species
)


joined_data <- original_data %>% left_join(us_taxized, by = c("GenSp" = "user_supplied_name"))

species_not_found <- joined_data %>%
    filter(is.na(matched_name2))

poor_matches <- joined_data %>%
    filter(score < .6)


ok_matches <- joined_data %>%
    filter(score < .8)

species_changed <- joined_data %>%
    filter(GenSp != matched_name2)

hist(species_changed$score) # most of the species changed have a score about .75. 10ish of them have a score like 98.

nwords_in_match <- function(match) {

    ml <- strsplit(match, " ")

    length(ml[[1]])
}

genus_matches <- species_changed %>%
    group_by_all() %>%
    mutate(nwords = nwords_in_match(matched_name2)) %>%
    ungroup() %>%
    filter(nwords == 1)

## unchanged species - we still need to cut this down

unchanged_species <- joined_data %>%
    filter(GenSp == matched_name2)

# Pick 500 species with good matches in taxize

set.seed(1989)
selected_species <- unchanged_species$GenSp[sample.int(length(unchanged_species$GenSp), size = 500, replace = F)]

# Add one species with a genus-only match
# chosen arbitrarily, this one is a synonym
selected_species <- c(selected_species, "Cirphis amblycasis")

# Ok, these species are the ones to add typos to. We will add _different_ typos to the abundances and traits data, so we need the clean list to start.

## Pick up here to work with abundances and traits.

### fxn to add typos


intro_typo <- function(a_name) {

    typo_spot <- sample(nchar(a_name))

    typo_char <- sample(nchar(a_name), 1)

    a_typo_name <- paste0(substr(a_name, 0, typo_spot),
                          substr(a_name, typo_char, typo_char),
                          substr(a_name, typo_spot, nchar(a_name)))

    a_typo_name
}

### Abundances
# add typos
# convert to long
abundances <- abundances [ abundances$GenSp %in% selected_species, ]

typo_spots <- sample.int(length(abundances$GenSp), 5, replace = F)

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


### Traits
# add typos
# incl. site column?


traits <- read.csv(here::here("episodes", "data", "body_size_data.csv"))

traits <- traits [ traits$GenSp %in% selected_species, ]

typo_spots <- sample.int(length(traits$GenSp), 5, replace = F)

traits$GenSp[typo_spots] <- intro_typo(traits$GenSp[typo_spots])

write.csv(traits, here::here("episodes", "data", "filtered_body_size_data.csv"), row.names = F)


