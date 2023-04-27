---
title: "Abundance Data"
teaching: 10
exercises: 2
editor_options: 
  markdown: 
    wrap: 50
---



::: questions 

- How is organismal abundance data typically stored?
- How is the species abundance distribution used to compare abundance data from differing systems?
- How do we use summary statistics - including Hill numbers - to quantitatively compare species abundance distributions?

:::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...


1. Import and examine organismal abundance data from .csv files
1. Clean taxonomic names
2. Manipulate abundance data into different formats
2. Generate species abundance distribution plots from abundance data
3. Summarize species abundance data using Hill numbers
4. Interpret how different Hill numbers correspond to different patterns in species diversity




::::::::::::::::::::::::::::::::::::::::::::::::


# Setup

For this episode, we'll be working with a couple of specialized packages for biological data. 


```r
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
library(taxize)
library(hillR)
library(vegan)
```

```{.output}
Loading required package: permute
```

```{.output}
Loading required package: lattice
```

```{.output}
This is vegan 2.6-4
```

```r
library(tidyr)
```

# Data import and cleaning

## Loading data

We'll be working with ecological species abundance data stored in `.csv` files. For help working with other storage formats, [the Carpentries' Ecological Data lesson materials on databases](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html) are a great place to start!

Let's load the data:




```r
abundances <- read.csv("http://bit.ly/3INNA9V")
```

And look at what we've got:



```r
head(abundances)
```

```{.output}
  island     site               GenSp
1  Kauai Kauai_01 Xyleborus perforans
2  Kauai Kauai_01 Xyleborus perforans
3  Kauai Kauai_01 Xyleborus perforans
4  Kauai Kauai_01 Xyleborus perforans
5  Kauai Kauai_01 Xyleborus perforans
6  Kauai Kauai_01 Xyleborus perforans
```

`abundances` is a data frame with columns for `island`, `site`, and `GenSp`. These data are in a common format in which each row represents a single individual observed. 

## Cleaning taxonomic names

The first thing we'll want to do is check for human error wherever we can, in this case in the form of typos in data entry.

The `taxize` R package can help identify and resolve simple typos in taxonomic names. 


```r
species_list <- unique(abundances$GenSp)

name_resolve <- gnr_resolve(species_list, best_match_only = TRUE, 
                            canonical = TRUE) # returns only name, not authority
```



```r
head(name_resolve)
```

```{.output}
# A tibble: 6 × 5
  user_supplied_name        submitted_name data_source_title score matched_name2
  <chr>                     <chr>          <chr>             <dbl> <chr>        
1 Xyleborus perforans       Xyleborus per… National Center … 0.988 Xyleborus pe…
2 Agrotis chersotoides      Agrotis chers… Catalogue of Lif… 0.75  Agrotis      
3 Oligotoma saundersii      Oligotoma sau… Wikispecies       0.988 Oligotoma sa…
4 Drosophila humeralis      Drosophila hu… Wikispecies       0.988 Drosophila h…
5 Entomobrya griseoolivata  Entomobrya gr… National Center … 0.988 Entomobrya g…
6 Pseudosinella kalalauens… Pseudosinella… Encyclopedia of … 0.988 Pseudosinell…
```


```r
mismatches <- name_resolve[ name_resolve$matched_name2 != name_resolve$user_supplied_name, ]

mismatches[, c("user_supplied_name", "matched_name2")]
```

```{.output}
# A tibble: 5 × 2
  user_supplied_name     matched_name2       
  <chr>                  <chr>               
1 Agrotis chersotoides   Agrotis             
2 Trigonidium flelectens Trigonidium flectens
3 Schrankia simplllex    Schrankia simplex   
4 Holcobius insignigis   Holcobius insignis  
5 Carposina mauiii       Carposina mauii     
```

Four of these are just typos. But `Agrotis chersotoides` in our data is resolved only to Agrotis. What's up there?

::: discussion

Agrotis taxonomic resolution

:::



```r
name_resolve$matched_name2[name_resolve$user_supplied_name == "Agrotis chersotoides"] <- "Peridroma chersotoides"
```



Now we need to add the newly-resolved names to our `abundnaces` data:



```r
abundances <- left_join(abundances, name_resolve, by = c("GenSp" = "user_supplied_name"))

abundances$final_name <- abundances$matched_name2
```


## Wrangling abundance data

The data we have have one record per individual, but we'd like to have the _total_ number of individuals of each species in our data. 



```r
abundance_tallies <- group_by(abundances, site, island, final_name)
abundance_tallies <- summarize(abundance_tallies, abundance = n())
```

```{.output}
`summarise()` has grouped output by 'site', 'island'. You can override using
the `.groups` argument.
```

```r
head(abundance_tallies)
```

```{.output}
# A tibble: 6 × 4
# Groups:   site, island [1]
  site            island       final_name                         abundance
  <chr>           <chr>        <chr>                                  <int>
1 HawaiiIsland_01 HawaiiIsland Acanthia procellaris                       3
2 HawaiiIsland_01 HawaiiIsland Actia eucosmae                             4
3 HawaiiIsland_01 HawaiiIsland Anomalochrysa fulvescens rhododora         2
4 HawaiiIsland_01 HawaiiIsland Anoplolepis gracilipes                     5
5 HawaiiIsland_01 HawaiiIsland Anurophorus lohi                           2
6 HawaiiIsland_01 HawaiiIsland Aphis citricola                            3
```

Write out the tallied data for later use:


```r
write.csv(abundance_tallies,  "abundance_tallies.csv", row.names = FALSE)
```


## Site-by-species matrix

Often we'll want to work with a _site by species matrix_, which has sites as rows and species as columns. We can get there using the `pivot_wider` function from the package `tidyr`:


```r
abundance_wide <- pivot_wider(abundance_tallies, id_cols = site,
                              names_from = final_name,
                              values_from = abundance, 
                              values_fill = 0)

head(abundance_wide[,1:10])
```

```{.output}
# A tibble: 3 × 10
# Groups:   site [3]
  site            `Acanthia procellaris` `Actia eucosmae` Anomalochrysa fulves…¹
  <chr>                            <int>            <int>                  <int>
1 HawaiiIsland_01                      3                4                      2
2 Kauai_01                             0                0                      0
3 Maui_01                              0                0                      0
# ℹ abbreviated name: ¹​`Anomalochrysa fulvescens rhododora`
# ℹ 6 more variables: `Anoplolepis gracilipes` <int>, `Anurophorus lohi` <int>,
#   `Aphis citricola` <int>, `Carphuroides pectinatus` <int>,
#   `Carposina achroana` <int>, `Carulaspis minima` <int>
```

We'll want this data to have _row names_ based on the sites, so we'll need some more steps:


```r
abundance_wide <- as.data.frame(abundance_wide)

row.names(abundance_wide) <- abundance_wide$site

abundance_wide <- abundance_wide[, -1]

head(abundance_wide)
```

```{.output}
                Acanthia procellaris Actia eucosmae
HawaiiIsland_01                    3              4
Kauai_01                           0              0
Maui_01                            0              0
                Anomalochrysa fulvescens rhododora Anoplolepis gracilipes
HawaiiIsland_01                                  2                      5
Kauai_01                                         0                      0
Maui_01                                          0                      0
                Anurophorus lohi Aphis citricola Carphuroides pectinatus
HawaiiIsland_01                2               3                       7
Kauai_01                       0               0                       0
Maui_01                        0               0                       0
                Carposina achroana Carulaspis minima Chlorichaeta albipennis
HawaiiIsland_01                  1                 1                       2
Kauai_01                         0                 0                       0
Maui_01                          0                 0                       0
                Cillaeopeplus dubius Cis insulicola Cis nudipennis
HawaiiIsland_01                    2              1              2
Kauai_01                           0              0              0
Maui_01                            0              0              0
                Cydia obliqua Dicranomyia hawaiiensis Drosophila lepidobregma
HawaiiIsland_01             3                       1                       3
Kauai_01                    0                       0                       0
Maui_01                     0                       0                       0
                Drosophila perkinsi Echthromorpha fuscator Elenchus melanias
HawaiiIsland_01                   4                      4                 1
Kauai_01                          0                      0                 0
Maui_01                           0                      0                 0
                Epiphanis tristis Eupelmus paraleucothrix Eupodes sigmoidensis
HawaiiIsland_01                 1                      20                    8
Kauai_01                        0                       0                    0
Maui_01                         0                       0                    0
                Fannia canicularis Hedylepta blackburni Heteropsylla cubana
HawaiiIsland_01                  1                    5                   2
Kauai_01                         0                    0                   0
Maui_01                         10                    0                   0
                Hypogastrura pahiku Ilburnia coprosmicola Laupala nigra
HawaiiIsland_01                   4                     1             2
Kauai_01                          0                     0             0
Maui_01                           0                     0             0
                Lispocephala fuscobrunnea Listroderes costirostris
HawaiiIsland_01                         2                       13
Kauai_01                                0                        0
Maui_01                                 0                        0
                Mecyclothorax purpuripennis Mestolobes droseropa
HawaiiIsland_01                           7                    2
Kauai_01                                  0                    0
Maui_01                                   0                    0
                Metaphycus anneckei Myllaena pacifica Neoscona theisi
HawaiiIsland_01                   1                 1               5
Kauai_01                          0                 0               0
Maui_01                           0                 0               0
                Nesogonia blackburni Nesomimesa hawaiiensis Notiphila insularis
HawaiiIsland_01                   19                      1                   1
Kauai_01                           0                      0                   0
Maui_01                            0                      0                   0
                Notoedres cati Nysius montivagus Omiodes anastrepta
HawaiiIsland_01              9                10                 10
Kauai_01                     0                 0                  0
Maui_01                      0                 0                  0
                Ophiusa disjungens Orthoea vincta Paratrechina bourbonica
HawaiiIsland_01                  2              3                       6
Kauai_01                         0              0                       0
Maui_01                          0              0                       0
                Pauahiana lineata Pediobius wilderi Pedronia cibotii
HawaiiIsland_01                 1                 6                4
Kauai_01                        0                 0                0
Maui_01                         0                 0                0
                Phytoseius hawaiiensis Pilorhagidia hirsuta Piophila casei
HawaiiIsland_01                      2                    1              1
Kauai_01                             0                    0              0
Maui_01                              0                    0              0
                Plagithmysus laticollis Projectothrips trespinus Psilopa olga
HawaiiIsland_01                       1                        1            3
Kauai_01                              0                        0            0
Maui_01                               0                        0            0
                Scaptomyza adunca Syrphophagus aphidivorus Tegonotus hibiscella
HawaiiIsland_01                20                        1                    1
Kauai_01                        0                        0                    0
Maui_01                         0                        0                    0
                Trigonidium kona Tympanococcus tympanistus Xyleborus vulcanus
HawaiiIsland_01               16                         1                  1
Kauai_01                       0                         0                 12
Maui_01                        0                         0                  0
                Aedes nocturnus Agrotis xiphias Aleurothrixus floccosus
HawaiiIsland_01               0               0                       0
Kauai_01                      1              23                       3
Maui_01                       0               0                       6
                Bembidion munroi brevicolle Brontolaemus nudicornis
HawaiiIsland_01                           0                       0
Kauai_01                                  8                       5
Maui_01                                   0                       0
                Campsicnemus penicillatus Cardiocondyla venustula
HawaiiIsland_01                         0                       0
Kauai_01                                7                      12
Maui_01                                 0                       0
                Cardiocondyla wroughtonii Carposina olivaceonitens
HawaiiIsland_01                         0                        0
Kauai_01                               19                       13
Maui_01                                 7                        0
                Carposina viridis Carulaspis giffardi Cheyletus eruditus
HawaiiIsland_01                 0                   0                  0
Kauai_01                        6                   4                 23
Maui_01                         0                   0                  0
                Chrysomphalus dictyospermi Chrysoperla comanche
HawaiiIsland_01                          0                    0
Kauai_01                                 3                    5
Maui_01                                  0                    0
                Cligenes marianensis Clunio vagans Coccygomimus punicipes
HawaiiIsland_01                    0             0                      0
Kauai_01                          15            14                      2
Maui_01                            0             0                      0
                Conioscinella formosa Contarinia sorghicola
HawaiiIsland_01                     0                     0
Kauai_01                            1                     4
Maui_01                             0                     0
                Cryptophlebia ombrodelta Dacnitus currax
HawaiiIsland_01                        0               0
Kauai_01                               5              14
Maui_01                                0               0
                Decadarchis penicillata Dialeurodes kirkaldyi
HawaiiIsland_01                       0                     0
Kauai_01                              6                     8
Maui_01                               0                     0
                Diplonevra peregrina Disenochus erythropus Drosophila humeralis
HawaiiIsland_01                    0                     0                    0
Kauai_01                          19                    15                   18
Maui_01                            0                     0                    0
                Drosophila ornata Drosophila papaalai Dyscritomyia fulgens
HawaiiIsland_01                 0                   0                    0
Kauai_01                        5                  12                    4
Maui_01                         0                   0                    0
                Entomobrya griseoolivata Epiphyas postvittana Evaza javanensis
HawaiiIsland_01                        0                    0                0
Kauai_01                              22                   13                7
Maui_01                                0                    0                0
                Friesea oleia Hawaiodillo sharpi Hemiberlesia rapax
HawaiiIsland_01             0                  0                  0
Kauai_01                   11                 11                  8
Maui_01                     0                  0                  0
                Heterocrossa plumbeonitida Holcobius frater Holcobius insignis
HawaiiIsland_01                          0                0                  0
Kauai_01                                33                4                 18
Maui_01                                  0                0                  0
                Hypocala deflorata Hyposmocoma centralis Hyposmocoma divisa
HawaiiIsland_01                  0                     0                  0
Kauai_01                         4                    11                  4
Maui_01                          0                     0                  0
                Hyposmocoma palmivora Hyposmocoma petroptilota
HawaiiIsland_01                     0                        0
Kauai_01                           12                        7
Maui_01                             0                        0
                Hyposmocoma sordidella Laupala kanaele Laupala wailua
HawaiiIsland_01                      0               0              0
Kauai_01                             7              10              9
Maui_01                              0               0              0
                Lycaena boetica Mesothriscus optimus Mesovelia mulsanti
HawaiiIsland_01               0                    0                  0
Kauai_01                     15                    3                 11
Maui_01                       0                    0                  0
                Nabis blackburni Nabis lolupe Necrobia ruficollis
HawaiiIsland_01                0            0                   0
Kauai_01                      18           10                   8
Maui_01                        0            0                   0
                Neelus minutus Nesiomiris seminotatus Nesodynerus sandwichensis
HawaiiIsland_01              0                      0                         0
Kauai_01                     7                     19                         6
Maui_01                      0                      0                         0
                Nipponorthezia guadalcanalia Oceanides humeralis
HawaiiIsland_01                            0                   0
Kauai_01                                   8                   3
Maui_01                                    0                   0
                Oliarus kauaiensis Oligota kauaiensis Oligotoma saundersii
HawaiiIsland_01                  0                  0                    0
Kauai_01                         8                 18                    8
Maui_01                          0                  0                    0
                Onychiurus folsomi Orthellia caesarion Oxytelus advena
HawaiiIsland_01                  0                   0               0
Kauai_01                        12                  14               6
Maui_01                          0                   0               0
                Paralabella curvicauda Pararrhaptica dermatopa
HawaiiIsland_01                      0                       0
Kauai_01                             3                      15
Maui_01                              0                       0
                Peridroma chersotoides Peridroma coniotis Phidippus audax
HawaiiIsland_01                      0                  0               0
Kauai_01                            15                  3              29
Maui_01                              0                  0               0
                Plagithmysus sugawai Polypedilum nubiferum Proterhinus setiger
HawaiiIsland_01                    0                     0                   0
Kauai_01                           8                    19                  15
Maui_01                            0                     0                   0
                Psammoechus insularis Pseudopterocheilus relictus
HawaiiIsland_01                     0                           0
Kauai_01                           12                           8
Maui_01                             0                           0
                Pseudosinella kalalauensis Quadristruma emmae Scaptomyza hardyi
HawaiiIsland_01                          0                  0                 0
Kauai_01                                 2                 10                 8
Maui_01                                  0                  0                 0
                Scholastes bimaculatus Schrankia altivolans Schrankia simplex
HawaiiIsland_01                      0                    0                 0
Kauai_01                             5                    7                 6
Maui_01                              0                    0                 0
                Scotorythra arboricolans Spolas delicata
HawaiiIsland_01                        0               0
Kauai_01                              10               2
Maui_01                                0               0
                Syntormon distortitarsis Tempyra biguttula
HawaiiIsland_01                        0                 0
Kauai_01                              12                17
Maui_01                                3                 0
                Tenuipalpus pacificus Thrips hawaiiensis Thyrocopa brevipalpis
HawaiiIsland_01                     0                  0                     0
Kauai_01                           15                  8                     5
Maui_01                             0                  0                     0
                Thyrocopa usitata Tinostoma smaragditis Trigonidium flectens
HawaiiIsland_01                 0                     0                    0
Kauai_01                        9                    15                   24
Maui_01                         0                     0                    0
                Trigonidium novena Trigonidium octonalis Udea calliastra
HawaiiIsland_01                  0                     0               0
Kauai_01                        10                     5               8
Maui_01                          0                     0               0
                Xyleborus perforans Abanchogastra debilis
HawaiiIsland_01                   0                     0
Kauai_01                          6                     0
Maui_01                           0                     4
                Adelencyrtus odonaspidis Aedes albopictus Agrotis tephrias
HawaiiIsland_01                        0                0                0
Kauai_01                               0                0                0
Maui_01                                2                8                4
                Amblyseius largoensis Anax strenuus Anisolabis eteronoma
HawaiiIsland_01                     0             0                    0
Kauai_01                            0             0                    0
Maui_01                            10             2                    1
                Aphidius obscuripes Araecerus fasciculatus Araecerus vieillardi
HawaiiIsland_01                   0                      0                    0
Kauai_01                          0                      0                    0
Maui_01                           5                      2                    1
                Atelothrus limbatus Athesapeuta cyperi Atheta coriaria
HawaiiIsland_01                   0                  0               0
Kauai_01                          0                  0               0
Maui_01                           3                  8               1
                Athetis thoracica Balclutha timberlakei
HawaiiIsland_01                 0                     0
Kauai_01                        0                     0
Maui_01                         2                    10
                Barypristus incendiarius Batrachedrodes supercincta
HawaiiIsland_01                        0                          0
Kauai_01                               0                          0
Maui_01                                5                          5
                Brontolaemus currax mauiensis Buenoa pallipes
HawaiiIsland_01                             0               0
Kauai_01                                    0               0
Maui_01                                     4              11
                Campsicnemus ephydrus Campsicnemus macula
HawaiiIsland_01                     0                   0
Kauai_01                            0                   0
Maui_01                             1                   5
                Campsicnemus philohydratus Canaceoides angulatus
HawaiiIsland_01                          0                     0
Kauai_01                                 0                     0
Maui_01                                  3                     5
                Carpophilus maculatus Carposina mauii Caryedon serratus
HawaiiIsland_01                     0               0                 0
Kauai_01                            0               0                 0
Maui_01                             4              12                 2
                Cephalops titanus Cheiracanthium diversum
HawaiiIsland_01                 0                       0
Kauai_01                        0                       0
Maui_01                         9                       6
                Chlorococcus straussiae Circulifer tenellus Cis immaturus
HawaiiIsland_01                       0                   0             0
Kauai_01                              0                   0             0
Maui_01                               3                   3             7
                Colpodiscus lucipetens Cremastus flavoorbitalis Cydia plicata
HawaiiIsland_01                      0                        0             0
Kauai_01                             0                        0             0
Maui_01                              3                        5             4
                Diestota occidentalis Drosophila disticha Drosophila kikkawai
HawaiiIsland_01                     0                   0                   0
Kauai_01                            0                   0                   0
Maui_01                             5                   2                  13
                Drosophila lemniscata Drosophila mediana Drosophila spectabilis
HawaiiIsland_01                     0                  0                      0
Kauai_01                            0                  0                      0
Maui_01                             2                  3                      2
                Drosophila truncipenna Drosophila virilis
HawaiiIsland_01                      0                  0
Kauai_01                             0                  0
Maui_01                              3                  4
                Dyscritomyia grimshawi Emperoptera zimmermani
HawaiiIsland_01                      0                      0
Kauai_01                             0                      0
Maui_01                              4                      4
                Entomobrya albocincta Ephydra millbrae Eupetinus laevigatus
HawaiiIsland_01                     0                0                    0
Kauai_01                            0                0                    0
Maui_01                             4               12                    2
                Eupetinus latimargo Eurynogaster spiniger
HawaiiIsland_01                   0                     0
Kauai_01                          0                     0
Maui_01                           4                     3
                Eurynogaster variabilis Forcipomyia hardyi Forcipomyia ingrami
HawaiiIsland_01                       0                  0                   0
Kauai_01                              0                  0                   0
Maui_01                               4                  5                   1
                Fornax longicornis Gymnochiromyia hawaiiensis
HawaiiIsland_01                  0                          0
Kauai_01                         0                          0
Maui_01                         11                          4
                Heterocrossa atronotata Hierodula patellifera
HawaiiIsland_01                       0                     0
Kauai_01                              0                     0
Maui_01                               2                     3
                Hofmannophila pseudospretella Hylaeus facilis
HawaiiIsland_01                             0               0
Kauai_01                                    0               0
Maui_01                                     5              15
                Hyposmocoma bitincta Hyposmocoma diffusa
HawaiiIsland_01                    0                   0
Kauai_01                           0                   0
Maui_01                            5                   3
                Hyposmocoma scepticella Leialoha mauiensis Leucania striata
HawaiiIsland_01                       0                  0                0
Kauai_01                              0                  0                0
Maui_01                               2                 13               16
                Liancalus metallicus Lispinodes mauiensis Lispocephala ascita
HawaiiIsland_01                    0                    0                   0
Kauai_01                           0                    0                   0
Maui_01                            6                    6                   3
                Lispocephala deceptiva Lispocephala pollinosa
HawaiiIsland_01                      0                      0
Kauai_01                             0                      0
Maui_01                              3                      2
                Lispocephala subseminigra Lispocephala xanthopleura
HawaiiIsland_01                         0                         0
Kauai_01                                0                         0
Maui_01                                 3                         6
                Macrosiphum solanifolii Mecaphesa hiatus Mecyclothorax rusticus
HawaiiIsland_01                       0                0                      0
Kauai_01                              0                0                      0
Maui_01                               2                2                      5
                Mecyclothorax unctus Metaphycus lounsburyi Myllaena vicina
HawaiiIsland_01                    0                     0               0
Kauai_01                           0                     0               0
Maui_01                            2                     7               1
                Nabis koelensis Neoclytarlus railliardiae
HawaiiIsland_01               0                         0
Kauai_01                      0                         0
Maui_01                       2                         1
                Neoscatella hawaiiensis Neseis ampliata Neseis haleakalae
HawaiiIsland_01                       0               0                 0
Kauai_01                              0               0                 0
Maui_01                               2               3                 2
                Nesiomiris cheliferus Nesomicromus brunnescens
HawaiiIsland_01                     0                        0
Kauai_01                            0                        0
Maui_01                             4                       12
                Nesosydne blackburni Nysius beardsleyi Nysius kinbergi
HawaiiIsland_01                    0                 0               0
Kauai_01                           0                 0               0
Maui_01                            6                 5               1
                Nysius longicollis Odynerus erythrostactes Odynerus nigripennis
HawaiiIsland_01                  0                       0                    0
Kauai_01                         0                       0                    0
Maui_01                          2                       2                    4
                Oeobia heterodoxa Oligota glabra Omiodes blackburni
HawaiiIsland_01                 0              0                  0
Kauai_01                        0              0                  0
Maui_01                         1              1                  2
                Orthezia insignis Pachodynerus nasidens Pagiopalus atomarius
HawaiiIsland_01                 0                     0                    0
Kauai_01                        0                     0                    0
Maui_01                         3                     2                    6
                Pararrhaptica perkinsana Pectinophora gossypiella
HawaiiIsland_01                        0                        0
Kauai_01                               0                        0
Maui_01                                9                        8
                Pentamerismus oregonensis Phaeogramma vittipennis
HawaiiIsland_01                         0                       0
Kauai_01                                0                       0
Maui_01                                 8                       3
                Phenacoccus madeirensis Philodoria dubauticola
HawaiiIsland_01                       0                      0
Kauai_01                              0                      0
Maui_01                               9                      9
                Phlyctaenia liopis Plagithmysus medeirosi
HawaiiIsland_01                  0                      0
Kauai_01                         0                      0
Maui_01                          1                      4
                Plagithmysus simillimus Plagithmysus smilacis
HawaiiIsland_01                       0                     0
Kauai_01                              0                     0
Maui_01                               3                     6
                Prognathogryllus kukui Proterhinus comes Proterhinus haleakalae
HawaiiIsland_01                      0                 0                      0
Kauai_01                             0                 0                      0
Maui_01                              5                 3                     16
                Proterhinus ruficollis Proterhinus tuberculiceps Psallus luteus
HawaiiIsland_01                      0                         0              0
Kauai_01                             0                         0              0
Maui_01                              5                         3              1
                Remaudiereana nigriceps Scaptomyza exigua Scaptomyza nasalis
HawaiiIsland_01                       0                 0                  0
Kauai_01                              0                 0                  0
Maui_01                               5                 3                  3
                Scaptomyza pallifrons Scatella femoralis Scotorythra brunnea
HawaiiIsland_01                     0                  0                   0
Kauai_01                            0                  0                   0
Maui_01                            10                  2                   3
                Sierola mauiensis Sigmatineurum nigrum Sinella kukae
HawaiiIsland_01                 0                    0             0
Kauai_01                        0                    0             0
Maui_01                         2                    1             2
                Stoeberhinus testaceus Tetragnatha acuta Tetragnatha hawaiensis
HawaiiIsland_01                      0                 0                      0
Kauai_01                             0                 0                      0
Maui_01                              4                 3                      3
                Tetragnatha macracantha Tetragnatha quasimodo
HawaiiIsland_01                       0                     0
Kauai_01                              0                     0
Maui_01                               4                     2
                Tetramorium tonganum Trigonidium pseudokua Trigonidium wahoi
HawaiiIsland_01                    0                     0                 0
Kauai_01                           0                     0                 0
Maui_01                            2                     2                 6
                Udea heterodoxa Vanessa tameamea Vespula pensylvanica
HawaiiIsland_01               0                0                    0
Kauai_01                      0                0                    0
Maui_01                       7                1                   10
                Xyleborinus saxeseni
HawaiiIsland_01                    0
Kauai_01                           0
Maui_01                            1
```

<!-- ```{r or base r} -->
<!-- x <- aggregate(abundances[, 'final_name', drop = FALSE], abundances[, c('final_name', 'site')],  -->
<!--                length) -->

<!-- head(x) #is identical -->
<!-- ``` -->

# Visualization via the species abundance distribution

## Separating the islands


```r
kauai_abund <- abundance_tallies[ abundance_tallies$island == "Kauai", ]
maui_abund <- abundance_tallies[ abundance_tallies$island == "Maui", ]
hawaiiisland_abund <- abundance_tallies[ abundance_tallies$island == "HawaiiIsland", ]
```

## Plotting SADs


```r
plot(sort(hawaiiisland_abund$abundance, TRUE))
```

<img src="fig/abundance-data-rendered-hawaii sad plot-1.png" style="display: block; margin: auto;" />


::: challenge

Plot the rank-abundance distributions for the remaining islands.

:::


::: solution



```r
plot(sort(kauai_abund$abundance, TRUE))
```

<img src="fig/abundance-data-rendered-kauai sad plot-1.png" style="display: block; margin: auto;" />



```r
plot(sort(maui_abund$abundance, TRUE))
```

<img src="fig/abundance-data-rendered-maui sad plot-1.png" style="display: block; margin: auto;" />

:::



# Summary statistics

## Diversity indices

The `vegan` package is a widely-used toolset for calculating diversity indices on ecological abundance data. 

### Species richness



```r
richness <- specnumber(abundance_wide)

richness
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
             59              94             136 
```

### Shannon's index


```r
shannon <- diversity(abundance_wide, index = "shannon")

shannon
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
       3.600169        4.361321        4.677393 
```



```r
exp_shannon <- exp(shannon)


exp_shannon
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
       36.60441        78.36057       107.48945 
```

### Simpson's evenness



```r
simpson <- diversity(abundance_wide, index = "simpson")
simpson
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
      0.9610713       0.9853324       0.9886889 
```

::: challenge

Compute the *inverse* Simpson index.

(Hint: use `?diversity` to get more information about the `diversity` function).

:::


::: solution


```r
invsimpson <- diversity(abundance_wide, index = "invsimpson")

invsimpson
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
       25.68800        68.17769        88.40846 
```

:::


### Combining values into a dataframe


```r
diversity_metrics <- rbind(exp_shannon, 
                           invsimpson,
                           richness)

diversity_metrics
```

```{.output}
            HawaiiIsland_01 Kauai_01   Maui_01
exp_shannon        36.60441 78.36057 107.48945
invsimpson         25.68800 68.17769  88.40846
richness           59.00000 94.00000 136.00000
```

## Hill numbers

::: discussion

Hill numbers are a unifying framework.

:::

### Calculating Hill numbers

The `hillR` package allows us to calculate Hill numbers in much the same way we calculate diversity indices in `vegan`.


```r
hill_0 <- hill_taxa(abundance_wide, q = 0 )

hill_0
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
             59              94             136 
```


```r
hill_1 <- hill_taxa(abundance_wide, q = 1)

hill_1
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
       36.60441        78.36057       107.48945 
```


::: challenge

Calculate the hill numbers for q = 2.

:::

::: solution


```r
hill_2 <- hill_taxa(abundance_wide, q = 2)

hill_2
```

```{.output}
HawaiiIsland_01        Kauai_01         Maui_01 
       25.68800        68.17769        88.40846 
```

:::


### Combining and plotting Hill numbers


```r
hill_numbers <- rbind(hill_0, hill_1, hill_2)
hill_numbers
```

```{.output}
       HawaiiIsland_01 Kauai_01   Maui_01
hill_0        59.00000 94.00000 136.00000
hill_1        36.60441 78.36057 107.48945
hill_2        25.68800 68.17769  88.40846
```

::: discussion

Compare the values for the Hill numbers to the values we generated earlier for richness,  Shannon's index, and the inverse Simpson.

The following may help:


```r
diversity_metrics
```

```{.output}
            HawaiiIsland_01 Kauai_01   Maui_01
exp_shannon        36.60441 78.36057 107.48945
invsimpson         25.68800 68.17769  88.40846
richness           59.00000 94.00000 136.00000
```



```r
hill_numbers
```

```{.output}
       HawaiiIsland_01 Kauai_01   Maui_01
hill_0        59.00000 94.00000 136.00000
hill_1        36.60441 78.36057 107.48945
hill_2        25.68800 68.17769  88.40846
```


:::


## Relating Hill numbers to patterns in diversity

Let's revisit the SAD plots we generated before, and think about these in terms of Hill numbers. 


```r
par(mfrow = c(3,1))
plot(sort(hawaiiisland_abund$abundance, TRUE))
plot(sort(kauai_abund$abundance, TRUE))
plot(sort(maui_abund$abundance, TRUE))
```

<img src="fig/abundance-data-rendered-sad again plots-1.png" style="display: block; margin: auto;" />



```r
hill_numbers
```

```{.output}
       HawaiiIsland_01 Kauai_01   Maui_01
hill_0        59.00000 94.00000 136.00000
hill_1        36.60441 78.36057 107.48945
hill_2        25.68800 68.17769  88.40846
```



# Recap

::: keypoints

- Organismal abundance data are a fundamental data type for population and community ecology.
- The `taxise` package can help with data cleaning, but quality checks are often ultimately dataset-specific. 
- The species abundance distribution (SAD) summarizes site-specific abundance information to facilitate cross-site or over-time comparisons.
- We can quantify the shape of the SAD using *summary statistics*. Specifically, *Hill numbers* provide a unified framework for describing the diversity of a system.

:::
    
