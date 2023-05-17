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
-   What are some patterns in how these APIs work?
:::

::: objectives
After following this episode, we intend that
participants will be able to:

1.  Effectively search for and find trait,
    sequence, and abundance data online given a
    taxon or research question
2.  Retrieve data from GEOME & GBIF using their R
    APIs and apply API principles to other
    databases
:::

# Setup

For this episode, we'll be working with some R
packages that wrap the APIs of online
repositories. Let's set those up now.


```{.output}

Attaching package: 'rotl'
```

```{.output}
The following object is masked from 'package:spocc':

    inspect
```

```{.output}

Attaching package: 'taxize'
```

```{.output}
The following objects are masked from 'package:rotl':

    synonyms, tax_name, tax_rank
```

# Sources of multidimensional biodiversity data: large open-access databases

Large open-access biological databases have been
growing at an incredible pace in recent years.
Often they accumulate data from many projects and
organizations. These platforms are then used to
share and standardize data for wide use.

Many such databases exist, but here are some
listed examples:

-   GBIF contains occurrence records of
    individuals assembled from dozens of smaller
    databases.

-   NCBI (National Center for Biotechnology
    Information) database, which includes GenBank
    is the largest repository of genetic data in
    the world, but includes a lot of biomedical
    data.

-   OTOL (Open Tree of Life) is a database that
    combines numerous published trees and
    taxonomies into one supertree

-   GEOME (Genomic Observatories MetaDatabase)
    contains genetic data associated with
    specimens or samples from the field.

-   BOLD (Barcode of Life) is a reference library
    and database for DNA barcoding

-   EOL (Encyclopedia of Life) is a species-level
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

Hawaii is known for its diversity of
*Tetragnatha*, a genus of orb weaver spiders. With
this target in mind let's download some occurrence
data from GBIF, some sequence data from NCBI, and
a phylogeny from OTOL.

## Searching by taxon: getting species names

We want records of only the genus *Tetragnatha*,
but some APIs will require species names rather
than the names of broader taxa like genus or
family. We can use the taxize package for this.

First we use get_uid() to get the identification
number for the genus in the taxonomy (drawn from
NCBI).


```r
library(taxize)
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

Then we use the downstream() function to get all
species in *Tetragnatha*. This also works on
larger taxa like families and orders.


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

```r
species_names <- species_uids[[1]]$childtaxa_name
species_names
```

```{.output}
 [1] "Tetragnatha paludicola"              
 [2] "Tetragnatha boydi"                   
 [3] "Tetragnatha cavaleriei"              
 [4] "Tetragnatha virescens"               
 [5] "Tetragnatha josephi"                 
 [6] "Tetragnatha gui"                     
 [7] "Tetragnatha bituberculata"           
 [8] "Tetragnatha shinanoensis"            
 [9] "Tetragnatha chauliodus"              
[10] "Tetragnatha cf. tincochacae DDC-2018"
[11] "Tetragnatha similis"                 
[12] "Tetragnatha riveti"                  
[13] "Tetragnatha puella"                  
[14] "Tetragnatha paschae"                 
[15] "Tetragnatha caudicula"               
[16] "Tetragnatha tanigawai"               
[17] "Tetragnatha ceylonica"               
[18] "Tetragnatha makiharai"               
[19] "Tetragnatha iriomotensis"            
[20] "Tetragnatha yesoensis"               
[21] "Tetragnatha cf. vermiformis JJA-2017"
[22] "Tetragnatha cf. moua sc_02763"       
[23] "Tetragnatha lauta"                   
[24] "Tetragnatha hasselti"                
[25] "Tetragnatha geniculata"              
[26] "Tetragnatha vermiformis"             
[27] "Tetragnatha shoshone"                
[28] "Tetragnatha caudata"                 
[29] "Tetragnatha dearmata"                
[30] "Tetragnatha squamata"                
[31] "Tetragnatha praedonia"               
[32] "Tetragnatha pinicola"                
[33] "Tetragnatha extensa"                 
[34] "Tetragnatha viridis"                 
[35] "Tetragnatha javana"                  
[36] "Tetragnatha obtusa"                  
[37] "Tetragnatha nigrita"                 
[38] "Tetragnatha rava"                    
[39] "Tetragnatha punua"                   
[40] "Tetragnatha nitens"                  
[41] "Tetragnatha moua"                    
[42] "Tetragnatha marquesiana"             
[43] "Tetragnatha macilenta"               
[44] "Tetragnatha montana"                 
[45] "Tetragnatha straminea"               
[46] "Tetragnatha guatemalensis"           
[47] "Tetragnatha elongata"                
[48] "Tetragnatha stelarobusta"            
[49] "Tetragnatha perkinsi"                
[50] "Tetragnatha pallescens"              
[51] "Tetragnatha limu"                    
[52] "Tetragnatha laboriosa"               
[53] "Tetragnatha filiciphilia"            
[54] "Tetragnatha eurychasma"              
[55] "Tetragnatha obscura"                 
[56] "Tetragnatha kukuiki"                 
[57] "Tetragnatha macracantha"             
[58] "Tetragnatha kikokiko"                
[59] "Tetragnatha anuenue"                 
[60] "Tetragnatha maxillosa"               
[61] "Tetragnatha acuta"                   
[62] "Tetragnatha pilosa"                  
[63] "Tetragnatha quasimodo"               
[64] "Tetragnatha tantalus"                
[65] "Tetragnatha polychromata"            
[66] "Tetragnatha perreirai"               
[67] "Tetragnatha restricta"               
[68] "Tetragnatha brevignatha"             
[69] "Tetragnatha kamakou"                 
[70] "Tetragnatha kukuhaa"                 
[71] "Tetragnatha versicolor"              
[72] "Tetragnatha kauaiensis"              
[73] "Tetragnatha waikamoi"                
[74] "Tetragnatha mandibulata"             
[75] "Tetragnatha hawaiensis"              
```

## Searching by taxon: querying GBIF, OTOL, and NCBI

The spocc package is all about occurrence data and
lets you download occurrences from all major
occurrence databases. For GBIF access using the
spocc package, we use the occ() function.

We'll put the species names we retrieved as the
'query' and specify gbif as our target database in
the 'from' field.

Since the occurrences from spocc are organized as
a list of dataframes, one per species, we use the
bind_rows() function from dplyr to combine this
into a single dataframe.


```r
library(spocc)
library(dplyr)
```

```{.output}

Attaching package: 'dplyr'
```

```{.output}
The following objects are masked from 'package:stats':

    filter, lag
```

```{.output}
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union
```

```r
occurrences <- occ(query = species_names, from = 'gbif')
occurrences_df <- bind_rows(occurrences$gbif$data)
head(occurrences_df)
```

```{.output}
# A tibble: 6 × 192
  name           longitude latitude issues prov  key   scientificName datasetKey
  <chr>              <dbl>    <dbl> <chr>  <chr> <chr> <chr>          <chr>     
1 Tetragnatha p…     -157.     20.9 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
2 Tetragnatha p…     -157.     20.9 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
3 Tetragnatha p…     -156.     20.8 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
4 Tetragnatha p…     -157.     20.9 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
5 Tetragnatha p…     -157.     20.9 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
6 Tetragnatha p…     -157.     20.9 cdc,o… gbif  1060… Tetragnatha p… 5d283bb6-…
# ℹ 184 more variables: publishingOrgKey <chr>, installationKey <chr>,
#   publishingCountry <chr>, protocol <chr>, lastCrawled <chr>,
#   lastParsed <chr>, crawlId <int>, hostingOrganizationKey <chr>,
#   basisOfRecord <chr>, individualCount <int>, occurrenceStatus <chr>,
#   taxonKey <int>, kingdomKey <int>, phylumKey <int>, classKey <int>,
#   orderKey <int>, familyKey <int>, genusKey <int>, speciesKey <int>,
#   acceptedTaxonKey <int>, acceptedScientificName <chr>, kingdom <chr>, …
```

The rotl package provides an interface to the Open
Tree of Life. To get a tree from this database, we
have to match our species names to OTOL's ids.

We first use trns_match_names() to match our
species names to OTOL's taxonomy.

Then we use ott_id() to get OTOL ids for these
matched names.


```r
resolved_names <- tnrs_match_names(species_names)
otol_ids <- ott_id(resolved_names)
```

Finally, we get the tree containing these IDs as
tips.


```r
tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))
plot(tr)
```

<img src="fig/finding_data-rendered-unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

Unfortunately we can see that the phylogenetic
relationships between these species aren't
resolved in OTOL, so we may have to look elsewhere
for a phylogeny.

Let's continue with the rentrez package, which
provides an interface to NCBI.

NCBI's API works with genera and larger ranks, but
has a harder time with lists of species.

For this reason, let's just search for
*Tetragnatha* using the 'term' argument, which
takes a string in a specific format describing the
query.


```r
search_results <- entrez_search(db="nucleotide", term="Tetragnatha & Genus[RANK]")
```

UNLIKE spocc but SIMILARLY to rotol, this first
search returns a set of IDs.

We then have to use entrez_fetch() on the IDs in
search_results to obtain the actual record
information.

We specify 'db' as 'nucleotide' and 'rettype' as
'fasta' to get fasta sequences


```r
sequences <- entrez_fetch(db = "nucleotide", id = search_results$ids, rettype = "fasta")
```

## Searching by location: querying GBIF and NCBI

In addition to or instead of querying by species,
we can search for records in a given location in
the world. Within spocc we need to pass location
queries directly to GBIF using 'gbifopts'. We'll
search in a lat-long bounding box around Hawaii.


```r
#df <- occ(query = species_names, from = 'gbif', has_coords=TRUE, gbifopts=list("continent"#="north_america"))
occurences_df <- occ(query = species_names, from = 'gbif', has_coords=TRUE, 
                     gbifopts=list("decimalLatitude"='18.910361,28.402123',
                                   "decimalLongitude"='-178.334698,-154.806773')) 
```

For NCBI, we can add the state of Hawaii to the
query string. HI is the abbreviation for Hawaii.


```r
search_results <- entrez_search(db="nucleotide", term="Tetragnatha & HI[State]")

sequences <- entrez_fetch(db = "nucleotide", id = search_results$ids, rettype = "fasta")
```

From this we obtain 5 nucleotide sequences from
Hawaii *Tetragnatha*.

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

# Sources of MDBD: "small data" attached to papers

A lot of useful data is not held in big databases,
and is instead attached to papers. Searching on
Google and Google Scholar can be an effective way
to find such data. Let's search for "mammal trait
database" on Google Scholar.

The first paper looks good, so let's look at the
Supplementary Data which will contain their data.

Let's download and unzip the data.

Reading the metadata file, we see that a certain
data file contains the traits. Great! Let's read
it into R.

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
:::
