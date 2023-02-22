## Abundances as imported from episodes/data/abundance_data.csv has a few duplicate species.
## The following might make a good lesson on data cleaning, doing this without explanation for now

library(dplyr)

abundances <- read.csv(here::here("episodes", "data", "abundance_data.csv"))

dups <- abundances %>%
    group_by(island, site, GenSp) %>%
    summarize(n = dplyr::n()) %>%
    ungroup() %>%
    filter(n > 1)

dups

abundances <- abundances %>%
    group_by(island, site, GenSp) %>%
    summarize(abundance = sum(abundance)) %>%
    ungroup()

write.csv(abundances, here::here("episodes", "data", "abundance_data_cleaned.csv"), row.names = F)
