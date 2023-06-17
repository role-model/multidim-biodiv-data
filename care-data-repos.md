---
title: "CARE Principles and Data Repositories"
teaching: 20
exercises: 10
---




:::::::::::::::::::::::::::::::::::::: questions 


1. What biodiversity data repositories implement CARE principles?
1. How can we use the Local Contexts Hub API to link data records with Indigenous data provenance and rights?


::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After following this episode, participants should be able to...


1. Articulate the challenges to implementing CARE in biodiversity data sharing
1. Use the Local Contexts Hub API to retrieve TK/BC Labels and Notices 


::::::::::::::::::::::::::::::::::::::::::::::::

## What biodiversity repositories utilize TK/BC Labels and Notices?

::: challenge 

Search the web and try to find some examples!

:::: solution

Not much!  Here are two:
- [GEOME](https://geome-db.org/)
- [Maine-eDNA database](https://metadata.maine-edna.org/main/localcontexts/)

::::

:::


::: discussion

What could be challenges in operationalizing TK/BC Labels and Notices?

:::

::: instructor

Guide learners toward metadata standards to transition to next section

:::

## Are existing metadata standards sufficient for housing information about Indigenous data sovereignty and governance?

::: challenge

- Look up the descriptions of Biocultural [Labels](https://localcontexts.org/labels/biocultural-labels/) and [Notices](https://localcontexts.org/notice/bc-notice/)
- Look up the fields of the [Darwin Core metadata standard](https://dwc.tdwg.org/terms/)
- Can they interoperate?

:::: solution

There is no agreed upon solution.  So the solution is really more of a conversation at this point.  One key concept to keep in mind is that Darwin Core (and other metadata standards) are built upon a settler system of data management, data provenance, and intellectual property.  That system was created to manifest the rights of settlers and to destroy the rights of Indigenous people, communities, and peoples.  So perhaps the terms can be translated, but perhaps this will not be satisfactory without rebuiling standards with both CARE and FAIR principles at heart.

::::

:::

## What can we do without institutional support from large repositories (yet)?

The Local Contexts Hub provides an API that we can use in our data workflows to ensure that Indigenous data sovereignty metadata propagate along with the data.

Let's see how we can use the Local Contexts Hub API to query information about the Maine-eDNA project we learned about.  We can find the API documentation [here](https://github.com/biocodellc/localcontexts_db/wiki/API-Documentation).



```r
library(jsonlite)
library(httr)

# the API documentation tells us this is the base URL to access the API
baseURL <- "https://localcontextshub.org/api/v1"

# to retrive project information, we add this to the base URL
projDetail <- "/projects/<PROJECT_UNIQUE_ID>/"

# we need to know the protect ID, we can find it in our LC Hub account
projID <- "6d34be51-0f60-4fc5-a699-bed4091c02e0"

# now we start to construct our query string
q <- paste0(baseURL, projDetail)
q
```

```{.output}
[1] "https://localcontextshub.org/api/v1/projects/<PROJECT_UNIQUE_ID>/"
```


```r
# we need to replace "<PROJECT_UNIQUE_ID>" with `projID`
q <- gsub("<PROJECT_UNIQUE_ID>", projID, q)
q
```

```{.output}
[1] "https://localcontextshub.org/api/v1/projects/6d34be51-0f60-4fc5-a699-bed4091c02e0/"
```


```r
# now we can use functions from jsonlite and httr to pull the info
rawRes <- GET(q)
jsonRes <- rawToChar(rawRes$content)

res <- fromJSON(jsonRes)

# have a look
res
```

```{.output}
$unique_id
[1] "6d34be51-0f60-4fc5-a699-bed4091c02e0"

$providers_id
NULL

$source_project_uuid
NULL

$project_page
[1] "https://localcontextshub.org/projects/6d34be51-0f60-4fc5-a699-bed4091c02e0/"

$title
[1] "Maine-eDNA Index Sites"

$project_privacy
[1] "Public"

$date_added
[1] "2022-06-03T14:31:52.076304Z"

$date_modified
[1] "2022-07-19T22:46:07.421725Z"

$created_by
  institution.id                 institution.institution_name researcher
1             44 Maine Center for Genetics in the Environment         NA
  community
1        NA

$notice
  notice_type                    name
1 biocultural Biocultural (BC) Notice
                                                                                                img_url
1 https://storage.googleapis.com/anth-ja77-local-contexts-8985.appspot.com/labels/notices/bc-notice.png
                                                                                                svg_url
1 https://storage.googleapis.com/anth-ja77-local-contexts-8985.appspot.com/labels/notices/bc-notice.svg
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      default_text
1 The BC (Biocultural) Notice is a visible notification that there are accompanying cultural rights and responsibilities that need further attention for any future sharing and use of this material or data. The BC Notice recognizes the rights of Indigenous peoples to permission the use of information, collections, data and digital sequence information (DSI) generated from the biodiversity or genetic resources associated with traditional lands, waters, and territories. The BC Notice may indicate that BC Labels are in development and their implementation is being negotiated.
                      created                     updated
1 2022-06-03T14:31:52.433462Z 2022-07-19T21:37:44.711129Z

$sub_projects
list()

$related_projects
list()

$project_boundary_geojson
NULL
```

There's a lot of info there! If a Notice is attached to the project, we can access it directly with `res$notice`.  Similarly, if TK and/or BC labels are associated with the project they can be accessed with `res$tk_labels` and `res$bc_labels`, respectively. 

There is an R package *enRich* under development by Jacob Golan in collaboration with [ENRICH](https://www.enrich-hub.org/) that can wrap these API calls in more familiar-looking R code.  We have to install this in-dev package from github:


```r
remotes::install_github("jacobgolan/enRich")
library(enRich)
```

Now we can re-produce the previous API call in simpler R code

```r
projID <- "6d34be51-0f60-4fc5-a699-bed4091c02e0"
meDNA <- find.projects(projID)
meDNA
```

The idea of pulling information from Local Contexts Hub via the API is that, for example, reports and manuscripts can now use calls to the API to automatically disclose Indigenous rights and interests in the data underlying the data used.

As an example, a manuscript written using RMarkdown or Quarto could include the following in the introduction

````markdown

```{r LCH-setup}
projID <- "259854f7-b261-4c8c-8556-4b153deebc18"
thisProj <- find.projects(projID)

comms <- thisProj[[1]]$bc_labels$community
```

We make use of data originating from `comms` traditional territories. 
These data thus have `comms` provenance, in spite of any settler concept 
of data ownership. To affirm the intrinsic rights of `comms` communities 
to govern the collection, use, and sharing of their data, `comms` 
applied the following Biocultural Labels to these data, specifying 
ethical protocol for the use and management of these data:

```{r bc-labels, results = 'asis'}
allBCLabels <- thisProj[[1]]$bc_labels

for(i in 1:length(allBCLabels)) {
    thisLab <- allBCLabels$label_text[i]
    
    cat(thisLab, "\n")
}
```

````

This code will render the community name and BC Labels they have applied.

As researchers we can also host our data outside of large online repositories, but still have them FAIR and CARE using webhooks to query the Local Contexts API.  This is the approach taken by the Maine-eDNA database infrastructure.

For the purpose of sharing data with Indigenous sovereignty metadata, *enRich* also provides an experimental method for attaching Local Contexts Hub IDs to sequence data.


```r
# read in a fasta file using the dedicated function from enRich
seqs <- readFASTA('https://raw.githubusercontent.com/role-model/multidim-biodiv-data/main/episodes/data/big_island_seqs.fas')

# just for demonstration purposes, set up a temporary directory
temp <- tempdir()

# write out the file
outputFASTA(
    seqs = seqs$sequence,
    seqid = seqs$name,
    uqID = projID, # the uniqe ID for the project we found above in Step 3
    filename = file.path(temp, "seqs-LCH-ID") # .fasta is automatically added
)

# read it back in and notice that the LC Hub ID is now in the fasta header
res <- readLines(file.path(temp, "seqs-LCH-ID.fasta"), n = 10)
cat(res)
```

This approach could be taken before uploading sequence data to GenBank.

::: keypoints

- Operationalizing CARE Principles requires advocacy to more data repositories will take up protocols such as hosting TK and BC information.
- While we wait for that systemic change, we can still take action ourselves by interacting directly with the API of Local Contexts Hub

:::
    
