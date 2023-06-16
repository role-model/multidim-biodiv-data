f <- c("episodes/introduction.Rmd",
       "episodes/care.Rmd",
       "episodes/abundance-data.Rmd",
       "episodes/traits-data.Rmd",
       "episodes/phylo-data.Rmd",
       "episodes/popgen-data.Rmd",
       "episodes/connecting-data-types.Rmd",
       "episodes/finding_data.Rmd",
       "episodes/care-data-repos.Rmd")

for(i in f) {
    knitr::purl(i, documentation = 0)
}

fr <- gsub('\\.Rmd', '.R', f)
fr <- gsub('episodes/', '', fr)


big <- ''

for(i in fr) {
    big <- c(big, readLines(i))
    file.remove(i)
}

big <- gsub('## ', '', big)

writeLines(big, 'instructors/all_episodes.R')

