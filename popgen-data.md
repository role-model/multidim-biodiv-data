---
title: "Working with population genetic data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---

## Pop gen data

::: questions

-   What are the common pop gen data formats?
-   How do you import pop gen data?
-   How do you clean pop gen data?
-   How do you summarize pop gen data?
-   How do you visualize pop gen data?

:::::::::::::

::: objectives

After following this episode, we intend that participants will be able to:

1.  Understand what genetic diversity is
2.  Visualize genetic diversity distributions
3.  Connect genetic diversity distributions to Hill numbers
4.  Identify key features of different pop gen data formats
5.  Import pop gen data in multiple formats into the R environment
6.  Manipulate pop gen data by adding and removing sequences
7.  Calculate genetic diversity $\pi$
8.  Calculate Hill numbers
9.  Interpret Hill numbers

:::

# Introduction

## What is genetic diversity?

GEOBON, in their description of Essential Biodiversity Variables, [define intraspecific genetic diversity](https://geobon.org/ebvs/what-are-ebvs/) as:

> The variation in DNA sequences among individuals of the same species.

This is a broad definition...

## What does it say about community assembly?

Genetic diversity is impacted by demographic events that shape the composition of the local community...

# Visualizing genetic diversity

## SFS visualization

The site frequency spectrum (SFS) is a summary of genetic variants across a population, similar to how abundances are summarized across a community. Specifically, it is the distribution of the allele frequencies of a given set of loci (generally single nucleotide polymorphisms, SNPs), in a population or sample. The best way to gain an intuition for what the SFS is, is to visualize it.

<img src="fig/popgen-data-rendered-plot-SFS-1.png" style="display: block; margin: auto;" />

The first bar of this plot indicates derived alleles (i.e. not ancestral) that appear once across the population. Approximately 35% of the sampled SNPs in the genome alignment are these "singletons". The second bar indicates derived alleles that appear twice across the population, where \~18% of the sampled SNPs are these "doubletons" and so forth.

The shape of the SFS can tell us important information about the demographic history of a population and their history of selection. A few examples of the impact of demographic history on the SFS include:

{{Stable pop viz}} {{Pop expansion viz}} {{Pop contraction viz}}

There are a variety of summary statistics that describe the shape of the SFS, which we can then summarize across species to understand change in an entire community. E.g., Tajima's pi...

## Genetic diversity distributions

{{pi across species neutral viz}}

{{pi across species filtering viz}}

{{pi across species competition viz}}

## Hill numbers of genetic diversity distributions

### Within-species (Hill of SFS) and among species (Hill of assemblage)

Do we need to do within-species Hill \#s?

In the context of summarizing species abundances, Hill numbers are the effective number of species in a community, where each exponent (q-value) increasingly weights rare species more heavily. The interpretation is similar when summarizing genetic diversity, where Hill numbers are the effective number species in a community, where each q-value increasingly weights species with lower genetic diversity more heavily. Rather than measuring an effective diversity of abundances, this is an effective measure of genetic diversities.

Something about correcting for species richness to just get evenness...

# Work with pop gen data

## Sequences

### FASTA

A FASTA file contains one or more DNA sequences, where the DNA sequence is preceded by a line with a carat ("&gt;") followed by an unique sequence ID:

&gt; seq0010  
GATCCCCAATTGGGG

This is perhaps the most common way to store sequence information as it is simple and has historical inertia. For more information, see the [the NCBI page](https://www.ncbi.nlm.nih.gov/genbank/fastaformat/#:~:text=In%20FASTA%20format%20the%20line,should%20not%20contain%20any%20spaces.).

#### ape


```r
library(ape)

fas <- read.FASTA(fasta_path)
```

```{.error}
Error in eval(expr, envir, enclos): object 'fasta_path' not found
```

#### Manipulate data

Filter individuals... get sizes of sequences... split by population...

#### Calculate genetic diversity

Tajima's pi ("raw" pairwise difference)... Why pairwise deletion rather than full deletion...


```r
fas_gendist <- dist.dna(fas, model = "raw", pairwise.deletion = TRUE)
```

```{.error}
Error in eval(expr, envir, enclos): object 'fas' not found
```

```r
fas_gendiv <- median(fas_gendist[upper.tri(fas_gendist)])
```

```{.error}
Error in eval(expr, envir, enclos): object 'fas_gendist' not found
```


```r
fas_gendist_pop <- lapply(fas_split, dist.dna, model = "raw", pairwise.deletion = TRUE)
```

```{.error}
Error in eval(expr, envir, enclos): object 'fas_split' not found
```

```r
calc_pi <- function(x) {
    gd <- median(x[upper.tri(x)])
    return(gd)
}
    
fas_gendiv_pop <- sapply(fas_gendist_pop, calc_pi)
```

```{.error}
Error in eval(expr, envir, enclos): object 'fas_gendist_pop' not found
```

```r
plot(fas_gendiv_pop)
```

```{.error}
Error in eval(expr, envir, enclos): object 'fas_gendiv_pop' not found
```

## SNPs

### VCF

Here are a few things about a VCF file... tab delimited... fields... size...

#### vcfR


```r
library(vcfR)
snps <- read.vcfR(vcf_path)
```

#### Manipulate data

Filter individuals Filter based on quality, missingness

#### Export to genind

A bit about genind and `adegenet`... If you have many SNPs, genlight may be a more appropriate format...

`vcfR2genind` also takes arguments for the function `df2genind` from the `adegenet` package. There are a couple things we can do to speed up the conversion, like specifying the ploidy of the file and setting the `check.ploidy` flag to `FALSE`.

To add populations...


```r
library(adegenet)
snps_genind <- vcfR2genind(
    snps, 
    n.cores = 1, 
    ploidy = 2, 
    check.ploidy = FALSE,
    pop = pops
    )

snps_genind
```

#### Calculate genetic diversity

If you didn't specify populations when converting or reading in the genind file, do so now...

Individual-based genetic distances... Maybe mention PCA?


```r
snps_gendist_ind <- dist(snps_genind, method = "euclidean")
```

```{.error}
Error in eval(expr, envir, enclos): object 'snps_genind' not found
```

Nei's genetic distance...


```r
snps_genpop <- genind2genpop(snps_genind)
```

```{.error}
Error in genind2genpop(snps_genind): could not find function "genind2genpop"
```

```r
snps_gendist_pop <- dist.genpop(snps_genpop, method = 1)
```

```{.error}
Error in dist.genpop(snps_genpop, method = 1): could not find function "dist.genpop"
```

FST...


```r
library(hierfstat)
```

```{.output}

Attaching package: 'hierfstat'
```

```{.output}
The following objects are masked from 'package:ape':

    pcoa, varcomp
```

```r
snps_hierfstat <- genind2hierfstat(snps_genind)
```

```{.error}
Error in eval(expr, envir, enclos): object 'snps_genind' not found
```

```r
snps_fst <- pairwise.fst(snps_hierfstat, diploid = TRUE)
```

```{.error}
Error in pairwise.fst(snps_hierfstat, diploid = TRUE): could not find function "pairwise.fst"
```

```r
hist(snps_fst[upper.tri(snps_fst)])
```

```{.error}
Error in eval(expr, envir, enclos): object 'snps_fst' not found
```

# Summarize genetic diversity

## Calculate Hill numbers within species/populations

*\* Going to need a SNP matrix*

Hill numbers of intraspecific allele frequencies are the *effective number of SNPs* in the population/species.


```r
library(hillR)
    
# columns are SNPs, rows are individuals
# treat it like abundances 
intra_hill_1 <- hillR::hill_taxa(snp_matrix, q = 1)
```

### Interpret (refer back to visualizations)

## Calculate Hill numbers across species

*Need species alignments from ape*


```r
# calculate pairwise distance matrices
per_species_dist <- lapply(species_alignments, ape::dist.dna, model = "raw", as.matrix = TRUE)

mat_avg <- function(x) {
    y <- x[upper.tri(x)]
    m <- mean(y)
    return(y)
}

per_species_pi <- sapply(per_species_dist, mat_avg)

hist(per_species_pi)
```

### Interpret (refer back to visualizations)
