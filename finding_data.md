---
title: "Finding multi-dimensional biodiversity data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---

::: questions

- Where do multi-dimensional biodiversity data live online?
- How can we use R APIs to quickly and reproducibly retrieve data?
- How can we combine online resources to assemble and store multi-dimensional datasets?

:::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, we intend that participants will be able to:

1. Effectively search for and find trait, sequence, and abundance data online given a taxon and research question 
2. Retrieve data from GEOME & GBIF using their R APIs and apply API principles to other databases
3. Organize a dataset of multiple dimensions of biodiversity from multiple online sources

::::::::::::::::::::::::::::::::::::::::::::::::

# Setup

Later on in this episode, we'll be working with some R packages that wrap the APIs of online repositories. 
Let's set those up now. 


```r
install.packages("spocc")
```

```{.output}
Installing spocc [1.2.2] ...
	OK [linked cache in 0.28 milliseconds]
* Installed 1 package in 1.1 seconds.
```

```r
library(spocc)
install.packages("rentrez")
```

```{.output}
Installing rentrez [1.2.3] ...
	OK [linked cache in 0.19 milliseconds]
* Installed 1 package in 0.14 seconds.
```

```r
library(rentrez)
install.packages("rotl")
```

```{.output}
Installing rotl [3.0.14] ...
	OK [linked cache in 0.19 milliseconds]
* Installed 1 package in 81 milliseconds.
```

```r
library(rotl) 
```

```{.output}

Attaching package: 'rotl'
```

```{.output}
The following object is masked from 'package:spocc':

    inspect
```

# Sources of multidimensional biodiversity data: large open-access databases

In recent years, large grant-supported open-access databases have been growing at an incredible pace. 
Databases like this host data from a wide variety of sources. Often data is accumulated from other large projects and organizations.
These platforms are then used to share and standardize data for the widest possible use. 

Many of these databases exist, but here are some examples:
  GBIF contains occurrance records of individuals assembled from dozens of smaller databases.
  NCBI (National Center for Biotechnology Information) database, which includes GenBank is the largest repository of genetic data in the world, but includes a lot of biomedical data
  GEOME (Genomic Observatories MetaDatabase) contains genetic data associated with specimens or samples from the field. 
  OTOL (Open Tree of Life) is a database that combines published trees and taxonomies into one supertree 
  BOLD (Barcode of Life) 
  EOL (Encyclopedia of Life)
  
## Using R APIs to download database data 

An API is a set of tools that allows users to interact with a database, such as reading, writing, updating, and deleting data.
We can't go over all of these databases in detail, but let's cover some examples that illustrate some principles of how these APIs work for different data types. 

Hawaii has some amazing diversity of Tetragnatha, a genus of long-jawed orb weaver spiders.
With this target in mind let's download some occurrance data from GBIF, some sequence data from NBCI, and a phylogeny from OTOL.

Many APIs searches will requires species names rather than the names of broader taxa like genus or family. 

We can use our good friend taxize for this. First we use get_uid to get the identifier for the genus, then we get the names of the children taxa for that UID.
These are our species!


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

```r
uid <- get_uid("Tetragnatha", db = "ncbi")
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

```r
species_uids <- children(uid, db = "ncbi")
```

```{.warning}
Warning: 'db' value 'ncbi' ignored; does not match dispatched method 'uid'
```

```{.output}
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
```

```{.output}
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
No ENTREZ API key provided
 Get one via taxize::use_entrez()
See https://ncbiinsights.ncbi.nlm.nih.gov/2017/11/02/new-api-keys-for-the-e-utilities/
```

```r
species_names <- species_uids$Tetragnatha$childtaxa_name
```

Perhaps the simplest search you can do is for records of one or more species in a given database.

The spocc package is all about occurrence data and lets you download occurrences from all major occurrence databases. 
For GBIF access using the spocc package, we use the occ() function.

We'll put the species names we retrieved  'query' and specify gbif as our target database in the 'from' field.


```r
occurences_df <- occ(query = species_names, from = 'gbif')
```

For NCBI access using the rentez package we can just search for our genus. 
BUT unlike spocc this returns a set of record IDs rather than the actual records.


```r
search_results <- entrez_search(db="taxonomy", term="Tetragnatha & Genus[RANK]")
```

We then have to use entrez_summary() on the IDs in search_results to obtain the actual record information.


```r
sequences <- entrez_fetch(db = "nucleotide", id = search_results$ids, rettype = "fasta")
```

OTOL works similarly in that we need two steps, but the first search returns a set of resolved taxon IDs organized in a dataframe, not record IDs like NCBI.


```r
resolved_names <- tnrs_match_names(c("Pongo", "Pan", "Gorilla", "Hoolock", "Homo"))
```

We can then get the tree containing only these matched taxa as tips


```r
tr <- tol_induced_subtree(ott_ids = ott_id(resolved_names))
```

```{.warning}
Warning in collapse_singles(tr, show_progress): Dropping singleton nodes with
labels: mrcaott83926ott6145147, mrcaott83926ott3607728, mrcaott83926ott3607876,
mrcaott83926ott3607873, mrcaott83926ott3607687, mrcaott83926ott3607716,
mrcaott83926ott3607689, mrcaott83926ott3607732, mrcaott770295ott3607719,
mrcaott770295ott3607692, Ponginae ott1082538, Hylobatidae ott166544
```

In addition to or instead of querying by species, we can search for records in a given location in the world.
Within spocc we need to pass location queries directly to GBIF using gbifopts


```r
df <- occ(query = 'Accipiter striatus', from = 'gbif', has_coords=TRUE, gbifopts=list("continent"="north_america"))
df <- occ(query = 'Accipiter striatus', from = 'gbif', has_coords=TRUE, gbifopts=list("decimalLatitude"='30,35',"decimalLongitude"='-30,-25'))
```

For NCBI, we can use the "country" argument 


```r
search_results <- entrez_search(db="sra",
              term="Tetrahymena thermophila[ORGN]", country="US", 
              retmax=0)
```

Now let's take a closer look at the data we have downloaded and some similarities in how MDBD database data is formatted.

For GBIF, 


```r
df
```

```{.output}
Searched: gbif
Occurrences - Found: 0, Returned: 0
Search type: Scientific
```


## Common issues with API big data downloads 

Download limits

Query limits 

# Sources of MDBD: "small data" attached to papers 

A lot of useful data is not held in big databases, and is instead attached to papers. 
Searching on Google and Google Scholar can be an effective way to find such data. 
Let's search for "mammal trait database" on Google Scholar.

The first paper looks good, so let's look at the Supplementary Data which will contain their data.

Let's download and unzip the data. 

Reading the metadata file, we see that a certain data file contains the traits. Great! Let's read it into R. 

# Assembling a combined dataset


# Recap

::: keypoints

- Many sources exist online where multidimensional biodiversity data can be obtained
- APIs allow for fast and reproducible querying and downloading
- Storing multidimensional data efficiently is important

:::
