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

How is this genetic diversity generated? At a proximal level, genetic diversity is generated through the processes of recombination and mutation. These two mechanisms lay the foundation for evolutionary forces like genetic drift, natural selection, and gene flow to shape the distribution of genetic diversity within populations and across communities.

Perhaps one of the most elegant theoretical frameworks for modeling genetic diversity is coalescent theory. Coalescent theory is a model of how alleles sampled from a population may have originated from a common ancestor. Under the assumptions of no recombination, no natural selection, no gene flow, and no population structure, i.e. neutrality, it estimates the time to the most recent common ancestor (TMRCA) between two sampled alleles and the variance of this estimate. When a population is especially large (i.e. many breeding individuals), the TMRCA of two randomly sampled alleles is large. This is because the per-generation probability of two alleles coalescing is `1 / 2Ne`, where `Ne`, the effective population size, is the number of breeding individuals in an idealized population that follows the assumptions stated above. In most, if not all, natural environments conditions are not ideal and `Ne` does not perfectly represent the census size of a population (see [Lewontin's paradox](https://www.biorxiv.org/content/10.1101/2021.02.03.429633v2)). While the relationship between `Ne` and census population size is not perfect, in most cases `Ne` increases as population size increases and can be used to understand the relative sizes of populations or size changes over time. The intuition is best understood through visualization.

For a population of 10 diploid individuals (20 allele copies), the probability of two randomly sampled allele coalescing each generation is 1 / (2 \* 10), or 1/20. In this single simulation (conducted using [Graham Coop's code](https://github.com/cooplab/popgen-notes/blob/master/Rcode/track_alleles.R)) , the two sampled alleles, whose genealogy is traced in blue and red, coalesce 16 generations in the past.

![](http://127.0.0.1:26201/graphics/10d9d9fc-fe25-474e-8d09-ff197b99e224.png)

However, when the population is smaller (5 individuals, 10 allele copies), the probability of coalescence each generation is 1 / (2 \* 5) or 1/10. In this simulation, two randomly sampled alleles coalesce after 6 generations.

![![](http://127.0.0.1:26201/graphics/21826093-5257-4379-a9df-aba895384e41.png)](http://127.0.0.1:26201/graphics/21826093-5257-4379-a9df-aba895384e41.png)

The TMRCA of the two sampled alleles corresponds with the smaller `Ne` of this idealized population.

Visualizing this path of ancestry as a tree would look something like this for 5 sampled allele copies.

[![](images/gene%20tree%20no%20mutations.png)](https://cdmuir.shinyapps.io/genetree-to-phylogeny/)

Overlaying mutations on the genealogy results in generally more mutations occurring on longer branches, although because this is a stochastic process, the relationship isn't always perfect (note- this is a tree from a different simulation to the one above).

[![This represents a genealogy of 5 sampled allele copies from a population, with mutations represented as red boxes. Multiple numbers inside the boxes indicate more mutations.](images/genetree%20with%20mutations-01.png)](https://cdmuir.shinyapps.io/genetree-to-phylogeny/)

As empirical biologists, what we have to work with are sequence data. The accumulation of mutations along a sequence enables us to estimate the TMRCA of a sample of alleles, leading to an estimate of the `Ne` of the population.

One of the simplest and most widespread estimators of `Ne` is the average number of pairwise differences between sequences sampled from a population (𝞹, nucleotide diversity, [Nei and Li 1979](https://www.pnas.org/doi/abs/10.1073/pnas.76.10.5269)). The basic idea underlying 𝞹 is that more sequence differences among a sample of sequences results from longer branch lengths in the genealogy of the sample, leading to a longer TMRCA and larger `Ne`. Given its simplicity and ubiquity, we will cover how to calculate the average number of pairwise differences between sequences and summarize this value across assemblages.

#### Resources for understanding the coalescent

-   [Graham Coop's popgen notes](http://cooplab.github.io/popgen-notes/)   
    -   awesome resource for population genetics in general
-   [learnPopGen app](https://phytools.shinyapps.io/coalescent-plot/)
    -   visualize coalescent genealogies with different numbers of individuals in a population and different numbers of generations
-   [coaltrace app](https://bedford.io/projects/coaltrace/)    
    -   a dynamic and interactive visualization of coalescent genealogies with the ability to change parameters on the fly
-   [Bedford lab slides](https://bedford.io/projects/phylodynamics-lecture/coalescent.html#/)
    -   a great set of slides that explains the coalescent in a complementary way to Graham Coop's notes
-   [cdmuir app](https://cdmuir.shinyapps.io/genetree-to-phylogeny/)
    -   uses the coalescent to simulate gene trees and mutations along sequences

## What does genetic diversity say about community assembly?

Under neutrality and stable demographic histories, variation in genetic diversity across a community reflects differences in long-term population sizes across the community. Rather than a snapshot of present-day abundance, this can be thought of as an average abundance across generations.

In much the same way as a community with a few, highly abundant species and many low abundance species may indicate a non-neutral community assembly process like environmental filtering, a community that contains a few species with high genetic diversity and many species with low genetic diversity may indicate similar non-neutral community assembly processes over a longer timescale.

In addition, genetic diversity is impacted by demographic events and natural selection. Populations that have undergone a demographic expansion or contraction in the recent past will have distinct coalescent genealogies and therefore different genetic diversities. For instance, a population that has experienced a recent demographic expansion will have a TMRCA more recent than a population with the same population size that has remained stable through the same time period, illustrated below.

[![Image of coalescent genealogies traced from stable and growing populations. From the Bedford Lab coalescent slides.](images/changing_pop_size_1.png)](https://bedford.io/projects/phylodynamics-lecture/coalescent.html#/20)

Distinguishing a small, constant-sized population from a large population that's grown dramatically in the recent past is difficult with single-locus data typical of large-scale biodiversity studies. However, when paired with other data like traits and abundances, we can make more refined interpretations of the shape of genetic diversity across the community. For instance, the interpretation of a community with a few highly diverse species paired with many species with low genetic diversity may reflect a community with a few species that were not impacted by a historical environmental disturbance alongside many species that had their populations dramatically reduced, but have rapidly grown to larger modern population sizes.

# Summarizing genetic diversity across species

### Genetic diversity distributions

{{pi across species neutral viz}}

{{pi across species non-neutral viz}}

### Hill numbers of genetic diversity across species

In the context of summarizing species abundances, Hill numbers are the effective number of species in a community, where each exponent (q-value) increasingly weights rare species more heavily. The interpretation is similar when summarizing genetic diversity. Hill numbers are the effective number of species in a community, where each q-value increasingly weights species with lower genetic diversity more heavily. Rather than measuring an effective diversity of abundances, this is an effective diversity of genetic diversities.

# Work with pop gen data

## Sequences

### FASTA

A FASTA file contains one or more DNA sequences, where the DNA sequence is preceded by a line with a carat ("&gt;") followed by an unique sequence ID:

```         
>seq0010
GATCCCCAATTGGGG
```

This is perhaps the most common way to store sequence information as it is simple and has historical inertia. For more information, see the [the NCBI page](https://www.ncbi.nlm.nih.gov/genbank/fastaformat/#:~:text=In%20FASTA%20format%20the%20line,should%20not%20contain%20any%20spaces.).

### Alignment

Prior to analysis, sequence data must be aligned if they haven't been already. A sequence alignment is necessary to identify regions of DNA that are similar or that vary. There are [many pieces of software to perform alignments](https://en.wikipedia.org/wiki/List_of_sequence_alignment_software) and all have their advantages and disadvantages, but we will choose a single program, [Clustal Omega](https://www.ebi.ac.uk/Tools/msa/clustalo/), which is fast and robust for short sequence alignments. While Clustal Omega can be run from the command line, we will use the R package [msa](https://bioconductor.org/packages/release/bioc/html/msa.html) to keep everything in the R environment.

First, a FASTA file containing the sequences needs to be read in using the `readDNAStringSet()` function.


```r
library(msa)

seq_path <- "/Users/connorfrench/Dropbox/Old_Mac/School_Stuff/CUNY/Courses/Spring-2019/Machine-Learning/project/fasta/hypsiboas_seqs_aligned.fas"

seqs <- readDNAStringSet(seq_path)

seqs
```

To align the sequences using Clustal Omega, we use the `msa` function and specify the `method` as "ClustalOmega". There are more arguments that you can use to fine-tune the alignment, but these are not necessary for the vast majority of scenarios.


```r
alignment <- msa(seqs, method = "ClustalOmega")

alignment
```

If after you perform your alignment you find that an individual does not belong or is negatively impacting the alignment, you have to manipulate your unaligned sequence data and then re-align the sequences. For instance, say you didn't want to include the individual `ind_name` in the alignment. First, remove the individual from the `seqs` object.


```r
# remove individual
seqs_filt <- seqs[!(names(seqs) %in% "Itar128")]

seqs_filt
```

This nifty filtering approach takes advantage of the powerful `%in%` function. In English, this function takes the vector on the left side of the `%in%` and checks if each element matches any of the elements on the right side. The left side contains the elements in the data you want to check, while the right side contains what you want to compare them against. So in this case,

`names(seqs) %in% "Itar128"`

checks to see if "Itar128" is present in any of the sequence names, returns `TRUE` if so and `FALSE` if not. Since we want to remove the "Itar128" sequence, we want the opposite of this result. To do this, we wrap this expression with the bang (`!`) operator, which negates the result of a boolean expression. So, the following expression returns `TRUE` for all sequence names that are not "Itar128" and `FALSE` otherwise.

`!(names(seqs) %in% "Itar128"`

Using bracket indexing, you then return all sequences that do not have the name "Itar128".

`seqs[!(names(seqs) %in% "Itar128"`

Following the filtering, you need to realign the new set of sequences.


```r
alignment <- msa(seqs_filt, method = "ClustalOmega")

alignment
```

There are quite a few packages in R to work with sequence data, for example [seqinr](https://cran.r-project.org/web/packages/seqinr/index.html), [phangorn](https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html), and [ape](https://cran.r-project.org/web/packages/ape/index.html). `ape` is the most versatile of these. But before we can use `ape`, the alignment must be converted to the `ape::DNAbin` format.


```r
ape_align <- msaConvert(alignment, type = "ape::DNAbin")

ape_align
```

Although not necessary for this workshop, it's generally advisable to write your DNA alignment to a new file to use later or with other programs.


```r
ape::write.FASTA(ape_align, "path/to/alignment.fas")
```

### ape

#### Check alignment

`ape` has a useful utility that allows you perform a series of diagnostics on your alignment to make sure nothing is fishy. The function can output multiple plots, but let's just visualize the alignment plot. If the colors seem jumbled in a region, this indicates that an alignment error may have occurred and to inspect your sequences for any problems.

In addition, the function outputs a series of helpful statistics to your console. Ideally, your alignment should have few gaps and a number of segregating sites that is reasonable for the number of sites in your alignment and the evolutionary divergence of the sequences included in the alignment, e.g., for an alignment with 970 sites of a single bird species, around 40 segregating sites is reasonable, but 200 segregating sites may indicate that something went wrong with your alignment or a species was misidentified. In addition, for diploid species a vast majority, if not all of the sites should contain one or two observed bases.


```r
library(ape)

checkAlignment(ape_align, what = 1)
```

#### Calculate genetic diversity

Now we're going to calculate the average number of pairwise genetic differences among these sequences. `ape` has the `dist.dna()` function to calculate various genetic distance metrics for an alignment.

You use the argument `model = "raw"` to specify that you want to use the average number of pairwise differences as your metric. When calculating the number of pairwise genetic differences, you have to choose whether you want missing data to be deleted across the entire alignment (`pairwise.deletion = FALSE`) or only between the two sequences being compared (`pairwise.deletion = TRUE`). Since we want to take advantage of as much data as possible when computing 𝜋, we'll set `pairwise.deletion = TRUE`.


```r
fas_gendist <- dist.dna(ape_align, model = "raw", pairwise.deletion = TRUE)

fas_gendist
```

The function returns a distance matrix containing the pairwise differences among all sequences in the data set. To take a quick peak at their distribution, we can use the `hist()` function on the distance matrix.


```r
hist(fas_gendist)
```

Since we want the average of these differences, we need to take their average. However, you may have noticed the distribution of genetic distances is non-normal, with mostly low genetic diversities. This is the case with most genetic data sets. So, instead of taking the mean, the `median()` will provide a better estimate of the center of the distribution.


```r
fas_gendiv <- median(fas_gendist)

fas_gendiv
```

To calculate this for multiple populations...

read in fasta alignments...

`lapply` explanation...


```r
fas_paths <- list.files("...", full.names = TRUE)

fas_alignments <- lapply(fas_paths, read.dna)
```

Now we can use `lapply` to calculate the pairwise genetic distances for each species\...

`sapply` is similar to `lapply`, except it returns a vector instead of a list. This is useful when you know the function is returning the same data type, like in our case where a number is being returned.


```r
fas_gendist_pop <- lapply(fas_alignments, dist.dna, model = "raw", pairwise.deletion = TRUE)
    
fas_gendiv_pop <- sapply(fas_gendist_pop, median)

plot(fas_gendiv_pop)
```

### Hill numbers

**How are we calculating genetic Hill numbers?**

## ASVs and Metabarcoding

Metabarcoding is rapidly growing DNA sequencing method used for biodiversity assessment. It involves sequencing a short, variable region of DNA sequence across a sample that may contain many taxa. This can be used to rapidly assess the diversity of a particular sampling site with low sampling effort. Some common applications include [microbiome diversity assessments, environmental DNA, and community DNA](https://en.wikipedia.org/wiki/Metabarcoding). In many applications where a data base of species identities for sequence variants is not available or desired, the diversity of sequences is inferred, rather than the diversity of species. Additionally, while [there are caveats](https://onlinelibrary-wiley-com.ezproxy.gc.cuny.edu/doi/full/10.1111/1755-0998.12902), the relative abundance of sequences can be considered analogous to the relative abundance of species across a community.

The basic unit of diversity used in most studies is the [amplicon sequence variant (ASV)](https://en.wikipedia.org/wiki/Amplicon_sequence_variant). An ASV is any one of the sequences inferred from a high-throughput sequencing experiment. These sequences are free from errors and may diverge by as little as a single base pair from each other. They are considered a substitute for operational taxonomic units (OTUs) for evaluating ecological diversity given their higher resolution, reproducibility, and no need for a reference database.

### Sequence table

The basic unit of analysis used for metabarcoding studies is the sequence table. It is a matrix with named rows corresponding to the samples and named columns corresponding to the ASVs. Each cell contains the count of each variant in each sample. Here's an example with 5 samples and 4 sequence variants:

|          | asv_1 | asv_2 | asv_3 | asv_4 |
|----------|-------|-------|-------|-------|
| sample_1 | 0     | 276   | 200   | 10    |
| sample_2 | 10    | 1009  | 0     | 0     |
| sample_3 | 0     | 0     | 234   | 15    |
| sample_4 | 129   | 1992  | 0     | 485   |
| sample_5 | 1001  | 10    | 1847  | 178   |

sample_1 may correspond to a soil sample collected in a forest, while the variants represent different ASVs, which could look like this:

asv_1: GTTCA

asv_2: GTACA

asv_3: GATCA

asv_4: CTTCA

This looks similiar to a site-species matrix, where the rows are a sampling locality, the columns are the species, and the cell values are the abundance of a species at a particular site.

While for this workshop we will focus on the analysis of a sequence table, we'll briefly go over how the data makes its way from raw sequencing data to the sequence table.

### FASTQ

The FASTQ file format is similar to the FASTA format introduced earlier, but includes additional data about the contained sequences. This enables more flexible data manipulation and filtering capabilities, and is popular with high-throughput sequencing technologies. When working with ASVs, this is the most common file format you will encounter.

A FASTA formatted sequence may look like this,

```         
>seq1
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
```

while a FASTQ version of the same sequence may look like this:

```         
@seq1
GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
+
!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
```

If your eyes glaze over at the seemingly random numbers below the sequence, don't fret! They mean something, but usually your machine does the interpreting for you. A FASTQ file is formatted as follows:

1.  An '&#x0040;' symbol followed by a sequence identifier and an optional description

2.  The raw sequence letters

3.  A '+' character that is optionally followed by the sequence identifier and more description

4.  Quality encodings for the raw sequence letters in field 2. There must be the same number of encoding symbols as there are sequence letters.

The symbols are bytes representing quality, ranging from 0x21 (lowest quality; '!' in ASCII) to 0x7e (highest quality; '\~' in ASCII). Here, they're arranged in order of quality from lowest on the left to highest on the right:

```         
!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
```

Fortunately, whatever bioinformatic program you use will generally do the interpreting for you.

Different sequencing technologies (e.g. Illumina) have standardized description strings which contain more information about the sequences and can be useful when filtering sequences or performing QC. For examples, see [the Wikipedia page](https://en.wikipedia.org/wiki/FASTQ_format).

### DADA2

[DADA2](https://benjjneb.github.io/dada2/index.html) is one of the most powerful and commonly used software packages for processing raw ASV sequencing data to turn it into a table of ASVs for each sample. This workshop assumes you are using the output from this workflow for further analysis, but for clarity the steps to the workflow include:

1.  read quality assessment
2.  filtering and trimming FASTQ files
3.  learning sequencing error rates, so the algorithm can correct for them
4.  infer the sequence variants
5.  merging paired reads (if sequencing was done with forward and reverse read pairs)
6.  constructing a sequence table

There are more available to further assess the quality of the data and map the data to taxonomic databases, but the core output of DADA2 and similar software pipelines is the sequence table.

### Hill numbers

I assume we're calculating Hill numbers using hillR::hill_taxa, but is that correct?

# Extra

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

Nei's genetic distance...


```r
snps_genpop <- genind2genpop(snps_genind)

snps_gendist_pop <- dist.genpop(snps_genpop, method = 1)
```

FST...


```r
library(hierfstat)
snps_hierfstat <- genind2hierfstat(snps_genind)

snps_fst <- pairwise.fst(snps_hierfstat, diploid = TRUE)

hist(snps_fst[upper.tri(snps_fst)])
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

## Within-species

### SFS visualization

The site frequency spectrum (SFS) is a summary of genetic variants across a population, similar to how abundances are summarized across a community. Specifically, it is the distribution of the allele frequencies of a given set of loci (generally single nucleotide polymorphisms, SNPs), in a population or sample. The best way to gain an intuition for what the SFS is, is to visualize it.



The first bar of this plot indicates derived alleles (i.e. not ancestral) that appear once across the population. Approximately 35% of the sampled SNPs in the genome alignment are these "singletons". The second bar indicates derived alleles that appear twice across the population, where \~18% of the sampled SNPs are these "doubletons" and so forth.

The shape of the SFS can tell us important information about the demographic history of a population and their history of selection. The above plot corresponds with a population that has experienced demographic stability. A couple other examples of the impact of demographic history on the SFS include:



There are a variety of summary statistics that describe the shape of the SFS. The average number of pairwise nucleotide differences, a.k.a. Tajima's/Nei's $\pi$, where a high value indicates a higher level of genetic diversity in the population, describes the average of the distribution. However, as you've seen above, the shape of the distribution contains important information about the population's history!

### Hill numbers of the SFS

In the context of summarizing species abundances, Hill numbers are the effective number of species in a community, where each exponent (q-value) increasingly weights rare species more heavily. The interpretation is similar when summarizing within-population genetic diversity. Hill numbers of within-population allele frequencies convey the *effective number of alleles* in a population, where each q-value increasingly weights rarer alleles more heavily.

*Something about when we'd use* *pi vs Hill*

## 