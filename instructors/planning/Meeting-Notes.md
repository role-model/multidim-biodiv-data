# Carpentries Meeting Notes
## Feb 14, 2023

#### Hour 1

* There was a discussion on whether the episodes would be data-type (abundance, GD, etc.) oriented or task oriented. Data-type oriented might be the way to go. For each data, we show how to import, clean, summarize and visualize. Different packages will be used for different data types; but doing this way also allows for some practice in repeating the same task for different times (e.g., data wrangling and visualization).

* One challenge is how to emphasize the integration. Have one or two episodes about that? **Renata**: What are the data types? Abundance, traits, phylogeny, Genetic Data. One hour on each. Then in the afternoon: one episode on examples on how integrating datasets and joint visualization

* What are the content of the first part vs the second part?
 * **Andy**: first part would be 1) import, wrangling and visualization of the four primary data types; 2) summary statistics of the four data types. Treating some SS as a way to integrate them, also joint distribution for visualization. Then, public repositories and data ethics. The second part would be more like: okay, you know all that summary and visualization stuff now, but this only gets you so far in terms of inference. Here is how to actually do inference, machine learning stuff.

* Renata's idea (going over the structure on the google sheets). In the morning we over each data type, afternoon we import a dataset that has all data types, and visualization and interpretation. A  logical next time would be to move to a more messy dataset and practice cleaning, but people might be exhausted. We can try first and the trial-run and see how it feels: would we feel like we can add the messy version of the data?

* Thinking about time: 3 hours chunk, 6 hours a day. For the trial run, it would make sense to do the first three hours, three episodes. In the real workshop, should we try to put all the four data types (four episodes) in the 3-hour chunk in the morning? Maybe a little ambitious, especially if we consider breaks and intros.

 * How do we want people to introduce themselves? Short introduction, kind of like an ice-breaker. 

 * Final thoughts on time for the first 3-hour chunk: 1 hour intro with introducing the workshop, people introducing themselves and a cool narrative to set the stage Then two episodes (two data-types), one hour each.

 * __Andy__: finding and contributing multi-dimensional data could be cut out if time is needed

 * First day will be the four data types plus integrating them. First day might spill over a little bit. Second day will be finding and contributing multi-dimensional data, and incorporating CARE principles by connecting data to local context hub. Second day maybe should start with the integration, actually. Leaving the first day only to introduce different data types. Then, second day first thing would be to show how to integrate, maybe use the same packages/commands from the previous day, would be like a review, might not take that long.

* What data do we have in mind? It is gonna be simulated data. How simulated? D&D?
 * __Andy__: We need to teach people taxonomic cleaning. We have to use real names. Use real creatures and come up with their community ecology. Where do those creatures live? Real data use when we are talking about local context and indigenous data at the end of the workshop. Also issue about teaching people to submit data when it is fake data.
 * __Renata__: we can highlight that is a toy dataset. Use real species names, from Hawaii for instance, but create simulated data for them. Simulate fictional island chain, different history from what Hawaii stuff, so we can have some scenarios we can play out with but it is not actual Hawaii. This is for teaching, but for publishing we would not submit it, since it is fictional data.
 * __Andy__: Yeah, agreed, we can just address the nuance. We could even use the place we are in during the workshop. Using simulated data but from some place in the real world. Using the real world helps with addressing the use of indigenous knowledge. Using simulated data helps us controlling the actual scenario we wanna show pedagogically. Then we can finish the first part of the workshop showing how our integration of data and their visualization and SSs suggest a specific scenario. And then the second part will go over this inference: we will simulate data under that scenario, but also under other competing scenarios, to test it out.

#### Hour 2

* We need lesson plans.
    * Intro
    * Abundance data
    * Trait data
    * PopGen
    * Phylo

* We need to write a system requirements episode at some point (Andy will start on that)

* Tasks:
    1. Writing the intro episode - Renata and Jacob
    2. Reviewing and finalizing the abundance episode - Renata
    3. Writing the trait episode - Rilquer
    4. Creating the data that can be used in the episode - Andy

    - Jacob also as overall reviewer
    
    - Deadline: next week, __Feb 21-2023__

* What is an exciting type of narrative? __Andy__: macro-scales feedback, interaction between processes
* Have a conversation about the questions and objectives of each episode, to make sure the simulated data for each episode can address those questions/objectives

* Do we want to simulate right away data that have all four components? Might be getting a little ahead of ourselves for the trial-run. Will we have that for the actual workshop?

* It is important to frame part 1 as a hypotheses generation part. The data we are summarizing and visualizing is to give insights about ideas. The inference part would come in the second part.

* What kinds of visualizations we want at the end of each episode? How do they connect with the "interesting" narrative we wanna show?
    * __Renata__: Body size and abundance is an interesting thing to visualize. The idea of alpha and beta diversity and how that can change being taxonomic or functional (trait) diversity. Overdispersion of traits vs filtering is another idea - a little bit more tricky.
    * Possible stories/datasets to think about:
        * New Mexico mice and hutchinson's ratio
        * Size, color and thermoregulation

## Feb 21, 2023

* Andy simulated some data: trait (body size) and abundance for arthropods, with some real taxonomy.

* Abundance and trait data are moving forward.

* Do we want taxonomy cleaning and Hill numbers to be done every episode? Or more towards the end? The repetition would be good. And then have one integration episode

* **Isaac**: Simulating genetic data. Function to replicate sampling artifacts

* Going over the episodes:
    * Objectives look good. We need to start writing some examples now. What kind of examples would be interesting to show?
    * Taxsize is giving some problems, we need to talk about taxonomy. We can let people know as of now we have some packages to help with that, but doing it manually might be the safest way in some cases.