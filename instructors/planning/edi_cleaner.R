remotes::install_github('EDIorg/taxonomyCleanr')
library(taxonomyCleanr)
data <- data.table::fread(file = system.file('example_data.txt', package = 'taxonomyCleanr'))

output <- count_taxa(x = data, col = 'Species')

data$Trimmed <- trim_taxa(x = data$Species)

trimmed_output <- count_taxa(data, col = 'Trimmed')

trimmed_output <- remove_taxa("", x = trimmed_output, col = "Taxa")
trimmed_output <- remove_taxa("-9999", x = trimmed_output, col = "Taxa")
trimmed_output <- remove_taxa("Unsorted biomass", x = trimmed_output, col = "Taxa")
trimmed_output <- remove_taxa("Miscellaneous litter", x = trimmed_output, col = "Taxa")

resolved_taxa <- resolve_sci_taxa(trimmed_output, data.sources = c(165))
