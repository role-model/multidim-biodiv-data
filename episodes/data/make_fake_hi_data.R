library(pika)
library(taxize)

# read and clean taxonomy ----

hiArth <- read.csv(paste('https://raw.githubusercontent.com/role-model',
                         'hi_arth_checklist/main',
                         'hawaii_arthropod_checklist.csv',
                         sep = '/'),
                   as.is = TRUE)

hiArth <- hiArth[, c('Order', 'Family', 'Genus', 'Species', 'Status',
                     'Kauai', 'Molokai', 'Maui', 'HawaiiIsland')]

hiArth <- hiArth[!grepl('\\.', hiArth$Species), ]
hiArth <- hiArth[!grepl('\\?|dub|qua|pur', hiArth$Status) &
                     hiArth$Status != '', ]

# clean island occupancy to be 0 or 1
for(i in c('Kauai', 'Molokai', 'Maui', 'HawaiiIsland')) {
    x <- rep(0, nrow(hiArth))
    x[hiArth[[i]] == substr(i, 1, 2)] <- 1
    hiArth[[i]] <- x
}

# # clean order names
# foo <- gnr_resolve(unique(hiArth$Order), fields = 'all')
# foo$rank <- gsub('.*\\|', '', foo$classification_path_ranks)
# foo <- foo[!grepl('genus|species|family', foo$rank), ]
#
# foo[, c('submitted_name', 'matched_name', 'rank')]
#
# length(unique(hiArth$Order))
#
# unique(hiArth$Order)[!(unique(hiArth$Order) %in% foo$user_supplied_name)]


# simulate abundance data for a site from each island ----

islands <- c('Kauai', 'Molokai', 'Maui', 'HawaiiIsland')
ks <- seq(3, 0.01, length.out = length(islands))
mus <- c(2, 3, 6, 1)
names(ks) <- names(mus) <- islands

# df to hold abund data
abund <- data.frame(island = character(0),
                  site = character(0),
                  GenSp = character(0),
                  abundance = numeric(0))

# loop over islands and simulate abundances
for(i in islands) {
    # number of species to sample
    si <- rpois(1, sum(hiArth[[i]]) * 0.25) + 1
    if(si > sum(hiArth[[i]])) {
        si <- sum(hiArth[[i]])
    }

    # sample species names
    namesi <- sample(nrow(hiArth), si, prob = hiArth[[i]])

    # sample abundances
    xi <- rtnegb(si, mu = mus[i], k = ks[i])

    out <- data.frame(island = tolower(i),
                      site = paste(tolower(i), '01', sep = '_'),
                      GenSp = paste(hiArth$Genus[namesi],
                                    hiArth$Species[namesi]),
                      abundance = xi)

    abund <- rbind(abund, out)
}


write.csv(abund, 'episodes/data/abundance_data.csv', row.names = FALSE)
