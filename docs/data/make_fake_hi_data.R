# library(pika)
# library(taxize)
#
# # read and clean ----
#
# hiArth <- read.csv(paste('https://raw.githubusercontent.com/role-model',
#                          'hi_arth_checklist/main',
#                          'hawaii_arthropod_checklist.csv',
#                          sep = '/'),
#                    as.is = TRUE)
#
# hiArth <- hiArth[, c('Order', 'Family', 'Genus', 'Species', 'Status',
#                      'Kauai', 'Molokai', 'Maui', 'HawaiiIsland')]
#
# hiArth <- hiArth[!grepl('\\.', hiArth$Species), ]
# hiArth <- hiArth[!grepl('\\?|dub|qua|pur', hiArth$Status) &
#                      hiArth$Status != '', ]
#
# # clean island occupancy to be 0 or 1
# for(i in c('Kauai', 'Molokai', 'Maui', 'HawaiiIsland')) {
#     x <- rep(0, nrow(hiArth))
#     x[hiArth[[i]] == substr(i, 1, 2)] <- 1
#     hiArth[[i]] <- x
# }
#
# # add a column for gensp
# hiArth$GenSp <- paste(hiArth$Genus, hiArth$Species)
#
# # sample spp for a site from each island ----
#
# # things to sample
# islands <- c('Kauai', 'Maui', 'HawaiiIsland')
# nspp <- c(100, 140, 60)
#
# # make a data.frame to hold everything
# abund <- data.frame(island = rep(islands, nspp),
#                     site = '', GenSp = '', abund = 0)
# abund$site <- paste0(abund$island, '_01')
#
# # loop over islands, sampling species names
# set.seed(123)
# for(i in 1:length(islands)) {
#     # sample species names
#     namesi <- sample(hiArth$GenSp, nspp[i], prob = hiArth[[islands[i]]])
#
#     abund$GenSp[abund$island == islands[i]] <- namesi
# }
#
#
# # clean taxonomy ----
#
# # get the unique names of all species in the data set
# spnames <- unique(abund$GenSp)
#
# # split the spnames vector into roughly equal sized chunks of 200
# x <- seq_along(spnames)
# spnames_list <- split(spnames, ceiling(x/100))
#
# # run gnr_resolve() over each species chunk
# resolved_list <- lapply(spnames_list, gnr_resolve,
#                         best_match_only = TRUE, canonical = TRUE)
#
# # turn this back into a single data frame
# resolved_names <- do.call(rbind, resolved_list)
#
# badNames <- which(resolved_names$submitted_name != resolved_names$matched_name2)
# badNames <- badNames[-1]
#
# abund <- abund[!(abund$GenSp %in% resolved_names$user_supplied_name[badNames]), ]
#
#
# # simulate abundances ----
#
# # neg binom params
# ks <- seq(3, 0.1, length.out = length(islands))
# mus <- c(10, 4, 1)
#
# # loop over islands and populate abundances
# set.seed(123)
# for(i in 1:length(islands)) {
#     n <- sum(abund$island == islands[i])
#     x <- rtnegb(n, k = ks[i], mu = mus[i])
#     abund$abund[abund$island == islands[i]] <- x
#
#     plot(sort(x, TRUE), log = 'y')
# }
#
#
# # make `abund` *really* long
# abund <- abund[rep(1:nrow(abund), abund$abund), ]
# abund <- abund[, -4]
# row.names(abund) <- NULL
#
#
# # introduce some typos ----
# typo_spots <- sample.int(length(abund$GenSp), 5, replace = F)
#
# intro_typo <- function(a_name) {
#
#     typo_spot <- sample(nchar(a_name))
#
#     typo_char <- sample(nchar(a_name), 1)
#
#     a_typo_name <- paste0(substr(a_name, 0, typo_spot),
#                           substr(a_name, typo_char, typo_char),
#                           substr(a_name, typo_spot, nchar(a_name)))
#
#     a_typo_name
# }
#
# abund$GenSp[typo_spots] <- intro_typo(abund$GenSp[typo_spots])
#
#
# # write out abund ----
# write.csv(abund, 'episodes/data/abundance_data.csv', row.names = FALSE)
#
#
# # simulate traits ----
#
# # function for hill traits
# hillDivTrait <- function(n, trt, q) {
#     traits <- trt
#
#     p <- n / sum(n)
#     dij <- as.matrix(dist(traits))
#     Q <- as.vector(p %*% dij %*% p)
#     a <- outer(p, p, '*') / Q
#
#     Hk <- sapply(q, function(qk) {
#         if(qk == 1) {
#             return(exp(- sum(dij * a * log(a))))
#         } else {
#             return(sum(dij * a^qk)^(1 / (1 - qk)))
#         }
#     })
#
#     D <- sqrt(Hk / Q)
#
#     return(D)
# }
#
#
# # get a data.frame of unique spp per site
# siteSpp <- unique(abund)
# siteSpp$b <- 0
#
# # body size dist params by island
# s <- rep(4, 3)
# r <- c(0.25, 0.5, 0.5)
#
# # loop over islands and populate body sizes
# set.seed(123)
# for(i in 1:length(islands)) {
#     ni <- sum(siteSpp$island == islands[i])
#     bi <- rgamma(ni, s[i], r[i])
#
#     siteSpp$b[siteSpp$island == islands[i]] <- bi
# }
#
# # extract out one body size per spp
# keepThese <- !duplicated(siteSpp$GenSp)
# bsize <- siteSpp[keepThese, 3:4]
#
# # give some reps to size measuremens
# sdev <- sd(bsize$b) * 0.01
# ms <- rep(bsize$b, each = 5)
#
# bsize <- data.frame(GenSp = rep(bsize$GenSp, each = 5),
#                     mass_g = rnorm(nrow(bsize) * 5, ms, sdev))
#
#
# # introduce some typos
# typo_spots <- sample.int(length(bsize$GenSp), 5, replace = F)
# bsize$GenSp[typo_spots] <- intro_typo(bsize$GenSp[typo_spots])
#
# write.csv(bsize, 'episodes/data/body_size_data.csv', row.names = FALSE)
#
#
#
# # write out taxonomy ----
#
# tax <- hiArth[, 1:3]
# tax$GenSp <- paste(hiArth$Genus, hiArth$Species)
#
# tax$Status <- hiArth$Status
#
# tax <- tax[tax$GenSp %in% abund$GenSp, ]
#
# write.csv(tax, 'episodes/data/taxonomy.csv', row.names = FALSE)
