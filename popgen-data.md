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

-   What is genetic diversity?
-   What does genetic diversity say about community assembly?
-   What are common summaries of genetic diversity within species and communities?
-   What are common sequence file formats?
-   How do you read in and manipulate sequence data?
-   How do you visualize and summarize sequence data?

:::::::::::::

::: objectives

After following this episode, we intend that participants will be able to:

1.  Understand what genetic diversity is
2.  Visualize genetic diversity distributions
3.  Connect genetic diversity distributions to Hill numbers
4.  Identify key features of different sequence data formats
5.  Import population genetic data in multiple formats into the R environment
6.  Manipulate pop gen data by adding and removing sequences
7.  Calculate genetic diversity $\pi$
8.  Calculate Hill numbers
9.  Interpret Hill numbers

:::::::::::::

# Introduction

## What is genetic diversity?

GEOBON, in their description of Essential Biodiversity Variables, [define intraspecific genetic diversity](https://geobon.org/ebvs/what-are-ebvs/) as:

> The variation in DNA sequences among individuals of the same species.

This is a broad definition...

## What does it say about community assembly?

Genetic diversity is impacted by demographic events and natural selection that shape the composition of the local community...

# Visualizing genetic diversity

## Within-species

### SFS visualization

The site frequency spectrum (SFS) is a summary of genetic variants across a population, similar to how abundances are summarized across a community. Specifically, it is the distribution of the allele frequencies of a given set of loci (generally single nucleotide polymorphisms, SNPs), in a population or sample. The best way to gain an intuition for what the SFS is, is to visualize it.

<img src="fig/popgen-data-rendered-plot-SFS-1.png" style="display: block; margin: auto;" />

The first bar of this plot indicates derived alleles (i.e. not ancestral) that appear once across the population. Approximately 35% of the sampled SNPs in the genome alignment are these "singletons". The second bar indicates derived alleles that appear twice across the population, where \~18% of the sampled SNPs are these "doubletons" and so forth.

The shape of the SFS can tell us important information about the demographic history of a population and their history of selection. The above plot corresponds with a population that has experienced demographic stability. A couple other examples of the impact of demographic history on the SFS include:

<img src="fig/popgen-data-rendered-plot-SFS-demography-1.png" width="50%" style="display: block; margin: auto;" /><img src="fig/popgen-data-rendered-plot-SFS-demography-2.png" width="50%" style="display: block; margin: auto;" />

There are a variety of summary statistics that describe the shape of the SFS. The average number of pairwise nucleotide differences, a.k.a. Tajima's $\pi$, where a high value indicates a higher level of genetic diversity in the population, describes the average of the distribution. However, as you've seen above, the shape of the distribution contains important information about the population's history!

### Hill numbers of the SFS

In the context of summarizing species abundances, Hill numbers are the effective number of species in a community, where each exponent (q-value) increasingly weights rare species more heavily. The interpretation is similar when summarizing within-population genetic diversity. Hill numbers of within-population allele frequencies convey the *effective number of alleles* in a population, where each q-value increasingly weights rarer alleles more heavily.

## Across species

{{pi across species neutral viz}}

{{pi across species filtering viz}}

{{pi across species competition viz}}

### Hill numbers of genetic diversity across species

In the context of summarizing species abundances, Hill numbers are the effective number of species in a community, where each exponent (q-value) increasingly weights rare species more heavily. The interpretation is similar when summarizing genetic diversity. Hill numbers are the effective number species in a community, where each q-value increasingly weights species with lower genetic diversity more heavily. Rather than measuring an effective diversity of abundances, this is an effective diversity of genetic diversities.

Something about correcting for species richness to just get evenness...

# Work with pop gen data

## Sequences

### FASTA

A FASTA file contains one or more DNA sequences, where the DNA sequence is preceded by a line with a carat ("&gt;") followed by an unique sequence ID:

&gt; seq0010  
GATCCCCAATTGGGG

This is perhaps the most common way to store sequence information as it is simple and has historical inertia. For more information, see the [the NCBI page](https://www.ncbi.nlm.nih.gov/genbank/fastaformat/#:~:text=In%20FASTA%20format%20the%20line,should%20not%20contain%20any%20spaces.).

#### Alignment

Prior to analysis, sequence data must be aligned if they haven't been already. A sequence alignment is necessary to identify regions of DNA that are similar or that vary. There are [many pieces of software to perform alignments](https://en.wikipedia.org/wiki/List_of_sequence_alignment_software) and all have their advantages and disadvantages, but we will choose a single program, [Clustal Omega](https://www.ebi.ac.uk/Tools/msa/clustalo/), which is fast and robust for short sequence alignments. While Clustal Omega can be run from the command line, we will use the R package [msa](https://bioconductor.org/packages/release/bioc/html/msa.html) to keep everything in the R environment.

First, a FASTA file containing the sequences needs to be read in using the `readDNAStringSet()` function.


```r
library(msa)
```

```{.output}
Loading required package: Biostrings
```

```{.output}
Loading required package: BiocGenerics
```

```{.output}

Attaching package: 'BiocGenerics'
```

```{.output}
The following objects are masked from 'package:stats':

    IQR, mad, sd, var, xtabs
```

```{.output}
The following objects are masked from 'package:base':

    anyDuplicated, aperm, append, as.data.frame, basename, cbind,
    colnames, dirname, do.call, duplicated, eval, evalq, Filter, Find,
    get, grep, grepl, intersect, is.unsorted, lapply, Map, mapply,
    match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
    Position, rank, rbind, Reduce, rownames, sapply, setdiff, sort,
    table, tapply, union, unique, unsplit, which.max, which.min
```

```{.output}
Loading required package: S4Vectors
```

```{.output}
Loading required package: stats4
```

```{.output}

Attaching package: 'S4Vectors'
```

```{.output}
The following object is masked from 'package:utils':

    findMatches
```

```{.output}
The following objects are masked from 'package:base':

    expand.grid, I, unname
```

```{.output}
Loading required package: IRanges
```

```{.output}
Loading required package: XVector
```

```{.output}
Loading required package: GenomeInfoDb
```

```{.output}

Attaching package: 'Biostrings'
```

```{.output}
The following object is masked from 'package:base':

    strsplit
```

```r
seq_path <- "/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/Courses/Spring-2019/Machine-Learning/project/fasta/hypsiboas_seqs_aligned.fas"

seqs <- readDNAStringSet(seq_path)
```

```{.error}
Error in .Call2("new_input_filexp", filepath, PACKAGE = "XVector"): cannot open file '/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/Courses/Spring-2019/Machine-Learning/project/fasta/hypsiboas_seqs_aligned.fas'
```

```r
seqs
```

```{.error}
Error in eval(expr, envir, enclos): object 'seqs' not found
```

To align the sequences using Clustal Omega, we use the `msa` function and specify the `method` as "ClustalOmega". There are more arguments that you can use to fine-tune the alignment, but these are not necessary for the vast majority of alignments.


```r
alignment <- msa(seqs, method = "ClustalOmega")
```

```{.error}
Error in eval(expr, envir, enclos): object 'seqs' not found
```

```r
alignment
```

```{.error}
Error in eval(expr, envir, enclos): object 'alignment' not found
```

If after you perform your alignment you find that an individual does not belong or is negatively impacting the alignment, you have to manipulate your unaligned sequence data and then re-align the sequences. For instance, say you didn't want to include the individual `ind_name` in the alignment. First, remove the individual from the `seqs` object.


```r
# remove individual
seqs_filt <- seqs[!(names(seqs) %in% "Itar128")]
```

```{.error}
Error in eval(expr, envir, enclos): object 'seqs' not found
```

```r
seqs_filt
```

```{.error}
Error in eval(expr, envir, enclos): object 'seqs_filt' not found
```

Then, realign the new set of sequences.


```r
alignment <- msa(seqs_filt, method = "ClustalOmega")
```

```{.error}
Error in eval(expr, envir, enclos): object 'seqs_filt' not found
```

```r
alignment
```

```{.error}
Error in eval(expr, envir, enclos): object 'alignment' not found
```

There are quite a few packages in R to work with sequence data, for example [seqinr](https://cran.r-project.org/web/packages/seqinr/index.html), [phangorn](https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html), and [ape](https://cran.r-project.org/web/packages/ape/index.html). `ape` is the most versatile of these. But before we can use ape, the alignment must be converted to the `ape::DNAbin` format.


```r
ape_align <- msaConvert(alignment, type = "ape::DNAbin")
```

```{.error}
Error in eval(expr, envir, enclos): object 'alignment' not found
```

```r
ape_align
```

```{.error}
Error in eval(expr, envir, enclos): object 'ape_align' not found
```

Although not necessary for this workshop, it's generally advisable to write your DNA alignment to a new file to use later or with other programs.


```r
ape::write.FASTA(ape_align, "path/to/alignment.fas")
```

```{.error}
Error in eval(expr, envir, enclos): object 'ape_align' not found
```

#### ape

#### Check alignment

`ape` has a useful utility that allows you perform a series of diagnostics on your alignment to make sure nothing is fishy. The function can output multiple plots, but let's just visualize the alignment plot. If the colors seem jumbled in a region, this indicates that an alignment error may have occurred and to inspect your sequences for any problems.

In addition, the function outputs a series of helpful statistics to your console. Ideally, your alignment should have few gaps and a number of segregating sites that is reasonable for the number of sites in your alignment and the evolutionary divergence of the sequences included in the alignment, e.g., for an alignment with 970 sites of a single bird species, around 40 segregating sites is reasonable, but 200 segregating sites may indicate that something went wrong with your alignment or a species was misidentified. In addition, for diploid species a vast majority, if not all of the sites should contain one or two observed bases.


```r
library(ape)
```

```{.output}

Attaching package: 'ape'
```

```{.output}
The following object is masked from 'package:Biostrings':

    complement
```

```r
checkAlignment(ape_align, what = 1)
```

```{.error}
Error in eval(expr, envir, enclos): object 'ape_align' not found
```

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
Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'median': object 'fas_gendist' not found
```


```r
fas_gendist_pop <- lapply(fas_split, dist.dna, model = "raw", pairwise.deletion = TRUE)
```

```{.error}
Error in h(simpleError(msg, call)): error in evaluating the argument 'X' in selecting a method for function 'lapply': object 'fas_split' not found
```

```r
calc_pi <- function(x) {
    gd <- median(x[upper.tri(x)])
    return(gd)
}
    
fas_gendiv_pop <- sapply(fas_gendist_pop, calc_pi)
```

```{.error}
Error in h(simpleError(msg, call)): error in evaluating the argument 'X' in selecting a method for function 'sapply': object 'fas_gendist_pop' not found
```

```r
plot(fas_gendiv_pop)
```

```{.error}
Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'plot': object 'fas_gendiv_pop' not found
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
