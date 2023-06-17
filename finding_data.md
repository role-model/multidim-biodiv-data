---
title: "Finding multi-dimensional biodiversity data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---



::: questions
-   Where do multi-dimensional biodiversity data
    live online?
-   How can we use R APIs to quickly and
    reproducibly retrieve data?
-   What about data that's not in a database?
:::

::: objectives
After following this episode, we intend that
participants will be able to:

1.  Effectively search for and find trait,
    sequence, and abundance data online given a
    taxon or research question
2.  Retrieve data from NCBI & GBIF using their R
    APIs and apply API principles to other
    databases
:::

# Sources of multidimensional biodiversity data: large open-access databases

Large open-access biological databases have been
growing at an incredible pace in recent years.
Often they accumulate data from many projects and
organizations. These platforms are then used to
share and standardize data for wide use.

Many such databases exist, but here are some
listed examples:

-   [GBIF](https://www.gbif.org/) contains occurrence records of
    individuals assembled from dozens of smaller
    databases.

-   [NCBI](https://www.ncbi.nlm.nih.gov/) (National Center for Biotechnology
    Information) database, which includes [GenBank](https://www.ncbi.nlm.nih.gov/genbank/)
    is the largest repository of genetic data in
    the world, but includes a lot of biomedical
    data.

-   [OTOL](https://tree.opentreeoflife.org/opentree/argus/opentree14.7@ott93302) (Open Tree of Life) is a database that
    combines numerous published trees and
    taxonomies into one supertree

-   [GEOME](https://geome-db.org/) (Genomic Observatories MetaDatabase)
    contains genetic data associated with
    specimens or samples from the field.

-   [BOLD](https://boldsystems.org/) (Barcode of Life) is a reference library
    and database for DNA barcoding

-   [EOL](https://eol.org/) (Encyclopedia of Life) is a species-level
    platform containing data like taxonomic
    descriptions, distribution maps, and images

## What's an API?

An API is a set of tools that allows users to
interact with a database, such as reading,
writing, updating, and deleting data. We can't go
over all of these databases in detail, but let's
cover some examples that illustrate some
principles of how these APIs work for different
types of biodiversity data.

We can do this using the example of Hawaiian arthropods. Hawaii is known for its diversity of
*Tetragnatha*, a genus of orb weaver spiders. With
this target in mind let's download some *occurrence*
data from GBIF, some *sequence* data from NCBI, and
a *phylogeny* for *Tetragnatha* spiders from OTOL.

### Using APIs: Setup

For this episode, we'll be working with some R
packages that wrap the APIs of online
repositories. Let's set those up now.


```r
library(spocc)
library(rentrez)
library(rotl) 
```

```{.output}

Attaching package: 'rotl'
```

```{.output}
The following object is masked from 'package:spocc':

    inspect
```

```r
library(taxize)
```

```{.output}

Attaching package: 'taxize'
```

```{.output}
The following objects are masked from 'package:rotl':

    synonyms, tax_name, tax_rank
```

### Getting consistent species names using `taxize`

We will want to source records of the genus *Tetragnatha*,
but some APIs will require species names rather
than the names of broader taxa like genus or
family. We can use the `taxize` package for this. `taxize` links to a genus identification number, drawn from NCBI, for each genus. We use the `get_uid()` function to get this number: 


```r
uid <- get_uid("Tetragnatha")
```

```{.output}
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
```

```{.output}
══  1 queries  ═══════════════
```

```{.output}

Retrieving data for taxon 'Tetragnatha'
```

```{.output}
✔  Found:  Tetragnatha
══  Results  ═════════════════

• Total: 1 
• Found: 1 
• Not Found: 0
```

::: instructor

You will be prompted to get an ENTREZ API key.  This is a good idea to do in order to make larger queries, but it won't be neccesary for this workshop.

:::

Then, we use the `downstream()` function to get a list of all
species in *Tetragnatha*. 

::: callout

This also works on
larger taxa like families and orders.

:::


```r
species_uids <- downstream(uid,downto="species")
```

```{.output}
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
```

```{.warning}
Warning in ncbi_get_taxon_summary(children_uid, key = key, ...): query failed,
proceeding to next if there is one
```

```{.error}
Error in names(output) <- c("childtaxa_id", "childtaxa_name", "childtaxa_rank"): 'names' attribute [3] must be the same length as the vector [0]
```

```r
species_names <- species_uids[[1]]$childtaxa_name
```

```{.error}
Error in eval(expr, envir, enclos): object 'species_uids' not found
```

```r
head(species_names)
```

```{.error}
Error in eval(expr, envir, enclos): object 'species_names' not found
```

### Occurrence data from GBIF 

The `spocc` package is all about occurrence data and
lets you download occurrences from all major
occurrence databases. For GBIF access using the
spocc package, we use the `occ()` function.

We'll put the species names we retrieved as the
`query` and specify `gbif` as our target database in
the `from` field.

Since the occurrences from spocc are organized as
a list of dataframes, one per species, we use the
bind_rows() function from dplyr to combine this
into a single dataframe.

We can also specify a geographic bounding box of where we'd like to look for occrences. Here we're using a bounding box that covers the Hawaiian Islands.


```r
occurrences <- occ(query = species_names, from = 'gbif', has_coords=TRUE, 
                   gbifopts=list("decimalLatitude"='18.910361,28.402123',
                                 "decimalLongitude"='-178.334698,-154.806773')) 
```

```{.error}
Error in eval(expr, envir, enclos): object 'species_names' not found
```

```r
# extract the data from gbif
occurrences_gbif <- occurrences$gbif$data 
```

```{.error}
Error in eval(expr, envir, enclos): object 'occurrences' not found
```

```r
# the results in `$data` are a list with one element per species, 
# so we combine all those elements
occurrences_df <- bind_rows(occurrences_gbif)
```

```{.error}
Error in bind_rows(occurrences_gbif): could not find function "bind_rows"
```

```r
head(occurrences_df)
```

```{.error}
Error in eval(expr, envir, enclos): object 'occurrences_df' not found
```


### Phylogenetic trees from the Open Tree of Life

First we need to get a clean list of taxonomic names from the GBIF results:


```r
hiTetragnatha <- unique(occurrences_df$name)
```

```{.error}
Error in eval(expr, envir, enclos): object 'occurrences_df' not found
```

```r
hiTetClean <- gnr_resolve(hiTetragnatha, best_match_only = TRUE, 
                          canonical = TRUE)
```

```{.error}
Error in eval(expr, envir, enclos): object 'hiTetragnatha' not found
```

```r
hiTetragnatha <- hiTetClean$matched_name2
```

```{.error}
Error in eval(expr, envir, enclos): object 'hiTetClean' not found
```

```r
hiTetragnatha
```

```{.error}
Error in eval(expr, envir, enclos): object 'hiTetragnatha' not found
```

Now we can use the `rotl` package. The `rotl` package provides an interface to the Open
Tree of Life. To get a tree from this database, we
have to match our species names to OTOL's ids.

We first use `trns_match_names()` to match our
species names to OTOL's taxonomy.

Then we use `ott_id()` to get OTOL ids for these
matched names.


```r
resolved_names <- tnrs_match_names(hiTetragnatha)
```

```{.error}
Error in eval(expr, envir, enclos): object 'hiTetragnatha' not found
```

```r
otol_ids <- ott_id(resolved_names)
```

```{.error}
Error in eval(expr, envir, enclos): object 'resolved_names' not found
```

Finally, we get the tree containing these IDs as
tips.


```r
tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))
```

```{.error}
Error in eval(expr, envir, enclos): object 'resolved_names' not found
```

```r
plot(tr)
```

```{.error}
Error in eval(expr, envir, enclos): object 'tr' not found
```

Unfortunately we can see that the phylogenetic
relationships between these species aren't
resolved in OTOL, so we may have to look elsewhere
for a phylogeny. This is an example of how not all data are in large repositories.

### Sequence data from NCBI

Let's continue with the `rentrez` package, which
provides an interface to NCBI.

NCBI's API works with genera and larger ranks, but
has a harder time with lists of species.

For this reason, let's just search for
*Tetragnatha* using the 'term' argument, which
takes a string in a specific format describing the
query.


```r
# note we're using `hiTetragnatha` that we made previously to make a long
# string of names that will be sent to NCBI via the ENTREZ API
termstring <- paste(sprintf('%s[ORGN]', hiTetragnatha), collapse = ' OR ')
```

```{.error}
Error in eval(expr, envir, enclos): object 'hiTetragnatha' not found
```

```r
termstring
```

```{.error}
Error in eval(expr, envir, enclos): object 'termstring' not found
```

```r
search_results <- entrez_search(db="nucleotide", term = termstring)
```

```{.error}
Error in eval(expr, envir, enclos): object 'termstring' not found
```

*Unlike* `spocc` but *similarly* to `rotl`, this first
search returns a set of IDs.

We then have to use `entrez_fetch()` on the IDs in
search_results to obtain the actual record
information.

We specify 'db' as 'nucleotide' and 'rettype' as
'fasta' to get FASTA sequences


```r
sequences <- entrez_fetch(db = "nucleotide", id = search_results$ids, 
                          rettype = "fasta")
```

```{.error}
Error in eval(expr, envir, enclos): object 'search_results' not found
```

```r
# just look at the first part of this *long* returned string
cat(substr(sequences, 1, 1148))
```

```{.error}
Error in eval(expr, envir, enclos): object 'sequences' not found
```


::: challenge
What are some similarities and differences in how
data is obtained using the R APIs of GBIF, NCBI,
and OTOL?
:::

::: solution
NCBI and OTOL both require an initial search to
obtain record IDs, then a second fetch to obtain
the actual record data for each ID

NCBI uses a string-based query where the search is
a specially-formated string, while GBIF uses an
argument-based query where the search is based on
the various arguments you give to the R API
function

NCBI is capable of taking a genus and returning
the records of all its species, but OTOL and GBIF
require obtaining the species names first using a
package like taxize

NCBI can take a state in the query, GBIF can take
a country but not a state.

GBIF data is formatted as a list of occurrences
for each species contained in the object we get
from the query.
:::

# Sources of MDBD: Databases without APIs

Many excellent databases exist without specialized APIs or R packages to facilitate their use. 

For example, the BioTIME database is a compilation of timeseries of species ocurrence, abundance, and biomass data. It is [openly available](https://biotime.st-andrews.ac.uk/) via the University of St. Andrews. The North American Breeding Bird Survey, run by the USGS, contains data on bird species abundances across the United States and Canada going back more than 50 years. These data are hosted on [ScienceBase](https://www.sciencebase.gov/catalog/item/52b1dfa8e4b0d9b325230cd9).

Some of these databases can be accessed via the [Data Retriever and accompanying R package the `rdataretriever`.](https://retriever.readthedocs.io/en/latest/) 

Some are findable via [DataONE](https://search.dataone.org/data) and the [Ecological Data Initiative](https://edirepository.org/). 

Others can be downloaded directly from the source. 

# Sources of MDBD: "small data" attached to papers

Finally, A lot of useful data is not held in  databases,
and is instead attached to papers. Searching manuscript databases or Google Scholar can be an effective way
to find such data. You can filter Web of Science to find entries with "associated data".

However, this can still be a somewhat heterogeneous and time-consuming strategy!

::: instructor

Time-permitting, this could be an opportunity for a 15-minute breakout exercise where individuals or groups pick a database or website and search for data, then report back on what they found and what the process was like. 

:::

# Recap

::: keypoints
-   Many sources exist online where
    multidimensional biodiversity data can be
    obtained
-   APIs allow for fast and reproducible querying
    and downloading
-   While there are patterns in how these APIs
    work, there will always be differences between
    databases that make using each API a bit
    different.
-   Standalone databases and even the supplemental data in manuscripts can also be re-used. 
:::
