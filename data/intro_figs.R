# sbys <- tidyr::pivot_wider(abundance_tallies, id_cols = site,
#                            names_from = final_name, values_from = abundance,
#                            values_fill = 0)
# sbys <- as.data.frame(sbys)
# rownames(sbys) <- sbys$site
# sbys <- sbys[, -1]
#
# trt <- as.data.frame(traits_agg_sp)[, 1:2]
# rownames(trt) <- trt$final_name
# trt <- trt[, -1, drop = FALSE]
#
#
# rownames(trt)[rownames(trt) == 'Peridroma chersotoides'] <-
#     'Agrotis chersotoides'
#
#
# which(!(colnames(sbys) %in% rownames(trt)))
#
#
# library(hillR)
#
# trt <- trt[colnames(sbys), , drop = FALSE]
#
# trtH <- hill_func(comm = sbys, traits = trt, q = 1)
#
# taxH <- hill_taxa(comm, q = 1)
#
#
#
# pdf('episodes/data/fig_data-distrib.pdf', width = 6, height = 4)
#
# layout(matrix(1:6, nrow = 2))
#
# par(mar = c(3.5, 3, 0.5, 0.5),
#     mgp = c(1.5, 0.5, 0), tcl = -0.25,
#     xpd = NA,
#     bg = 'black', fg = 'white', col.axis = 'white', col.lab = 'white')
#
# for(i in c('Kauai_01', 'Maui_01', 'HawaiiIsland_01')) {
#     n <- sbys[i, ]
#     x <- trt[names(n), ]
#
#     x <- rep(x, n)
#     n <- n[n > 0]
#
#     plot(sort(n, TRUE), cex = 1.4,
#          xlim = c(1, max(rowSums(sbys > 0))),
#          ylim = c(1, max(sbys)),
#          xlab = 'Species Rank',
#          ylab = 'Abundance')
#
#     plot(sort(x, TRUE), cex = 1.4,
#          xlim = c(1, max(rowSums(sbys))),
#          ylim = range(trt$mean_mass_g),
#          xlab = 'Individuals Rank',
#          ylab = 'Body Size')
# }
#
# dev.off()
