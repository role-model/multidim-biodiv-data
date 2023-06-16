---
title: Setup
---

## Learner expectations
We expect learners to have some familiarity with R, including a few basic concepts:

- what a function is and how to assign output of a function to an object, e.g. `object <- function(x)`
- read in tabular data, e.g. `read.csv()` for comma-separated values files
- bracket indexing, e.g. understanding that `data[,3]` returns the third column of the `data` dataframe.
- install and load packages, e.g. `install.packages()` and `library()`

If you need a bit of catching up, no worries! The Software Data Carpentries has a nice [Introduction to R and RStudio workshop](https://swcarpentry.github.io/r-novice-gapminder/) availible online that will get you up to speed. The episodes up to and including "Subsetting Data" will get you where you need to be for this workshop. 



## Software Setup

::::::::::::::::::::::::::::::::::::::: checklist

1. For this workshop, we prepared a virtual image containing all the necessary software, packages and settings we will need. To clone this image into your machine, you first need to download and install **Docker Desktop** from [this link](https://www.docker.com/products/docker-desktop/). Make sure to choose the right version for your computer (Windows, Linux, MacOS Intel Chip or MacOS Apple Chip).
2. Once installed, open Docker and use the search bar on the top to look for **iovercast/mess**. This is where the image is stored.
![](https://github.com/role-model/multidim-biodiv-data/blob/main/learners/setup-images/docker-setup-01.png)
3. Once the image is found (the name **iovercast/mess** will show up in the drop-down list), you need to choose the processor type for your computer. If you are using a M1/M2 MacBook, in the *tag* drop-down menu, choose `mac-m1`. For any other architecture (Windows, Linux and non-M1/M2 MacBooks), choose `intel`. Then click on `Pull`.
![](setup-images/docker-setup-02.png)
4. Once the pull is done, click on the **Images** option in the menu to the left. You should be able to see the new **iovercast/mess** image listed there. To get it running, click on the `Play` icon under **Actions**.
![](setup-images/docker-setup-03.png)
5. **Make sure to add a port for the image.** When prompted for Optional settings, click on the arrow to open the drop-down options and type 8787 in the `Host port` option. Then click on Run.
![](setup-images/docker-setup-04.png)
6. In the new screen, click on the `8787:8787` link below the image name.
![](setup-images/docker-setup-05.png)
7. A page for `rstudio-server` will open on your internet browser, prompting you for the username and password. Type `rstudio` for both username and password.
![](setup-images/docker-setup-06.png)
7. If an RStudio screen opens on your brower, you are ready to start working.

:::::::::::::::::::::::::::::::::::::::::::::::::::

## Data Sets

::::::::::::::::::::::::::::::::::::::: checklist


1. Throughout the workshop, we will be working with some simulated datasets stored online. They will be downloaded as we go through each lesson, following URLs that will be provided in the moment.

:::::

## Troubleshooting

::::: callout

If you have any difficulties with these installations prior to the workshop, please reach out to the instruction team at `biodataworkshop2023@gmail.com` and we will be delighted to help figure things out!

:::::::
