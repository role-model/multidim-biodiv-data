---
title: "Data Importing"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do import multi-dimensional data??

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...

1. Import abundance and trait data in a CSV format into R environment
2. Import sequence alignments from FASTA files into a GENO format
3. Import phylogenetic data from Phyllip files into PHYLO format

::::::::::::::::::::::::::::::::::::::::::::::::

1. Introduction

Imagine here a lot of content about importing different formats of biological data into an R environment

::: challenge

### Exercise 1: Importing and visualizing species abundance distribution

Fill the blanks so that the code belows performs the following tasks: 1) import a CSV table names "species_records.csv"; 2) plot a histogram of the abundance distribution of the species, based on the content in the column "species"

```
data <- ______ ('species_records.csv')
hist(________)
```

:::::: solution
```
data <- ______ ('species_records.csv')
hist(________)
```
:::::::::::::::

::::::::::::::::::::::

