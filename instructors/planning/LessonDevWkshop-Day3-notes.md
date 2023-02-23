# Collaborative Lesson Development Training
:::info
**Dates**: 5&6 + 8&9 December 2022 (part 1) & TBC (part 2)
**Time**: [13:00-17:00 UTC](https://www.timeanddate.com/worldclock/fixedtime.html?msg=Collaborative+Lesson+Development+Training&iso=20221205T13&p1=1440&ah=4)
**Zoom link**: https://carpentries.zoom.us/j/98047502268?pwd=V0E4Zmt2ZmhZajdxN3grUmF1d2hadz09
**Code of Conduct**: https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html
**Curriculum**: https://carpentries.github.io/lesson-development-training/
**Shared Timer**: https://cuckoo.team/carpentries-lessondev-training
**Day 1 Notes**: https://codimd.carpentries.org/2022-12-05-collaborative-lesson-development-training?both
**Day 2 Notes** (notes these were moved):
https://codimd.carpentries.org/2022-12-06-collaborative-lesson-development-training?both

**Trainers:**
  - [Toby Hodges](https://github.com/tobyhodges/)
  - [Sarah Stevens](https://github.com/sstevens2/)
  - [Aleksandra Nenadic](https://github.com/anenadic/)

**Helpers:**
  - Erin Becker
:::

[TOC]

## Schedule
:::spoiler
_(All timings listed in UTC and subject to change)_

### Day 1 - 5 December 2022
- 13:00-13:15: **Introduction**
- 13:15-13:25: **Lesson design / Your Lessons**
- 13:25-14:10: **Identifying your target audience**
- 14:10-14:25: **Break**
- 14:25-15:30: **Defining lesson objectives**

### Day 2 - 6 December 2022
- 13:00-14:00: **The Carpentries Workbench**
- 14:05-14:20: **Break**
- 14:20-14:55: **Defining Episode Objectives**
- 14:55-15:10: **Break**
- 15:10-16:15: **Stay on Target**
- 16:15-16:45: **Wrap-up**

### Day 3 - 8 December 2022
- 13:00-14:00: **Designing Assessments 1**
- 14:00-14:15: **Break**
- 14:15-14:50: **Designing Assessments 2**
- 14:50-15:05: **Break**
- 15:05-16:10: **Example Data and Narrative**

### Day 4 - 9 December 2022
- 13:00-14:10: **How to Write a Lesson**
- 14:10-14:25: **Break**
- 14:25-14:55: **How We Operate**
- 14:55-15:10: **Break**
- 15:10-16:15: **Preparing to Teach**
- 16:15-16:45: **Wrap-up**

---

_**Break for Trial Runs**_

---

### Day 5 - TBC*
- TBC-TBC: **Reflecting on Trial Runs**
- TBC-TBC: **Break**
- TBC-TBC: **Collaborating with Newcomers**

### Day 6 - TBC*
- TBC-TBC: **Collaborating with People You Already Know**
- TBC-TBC: **Break**
- TBC-TBC: **Wrap-up**

\* timings for part 2 have not been set yet
:::


## Attending

- Toby Hodges / he, him, his / The Carpentries / tobyhodges / tobyhodges@carpentries.org
- Sarah Stevens / she, her, hers / University of Wisconsin-Madison / sstevens2 / sarah.stevens@wisc.edu
- Aleks Nenadic / she, her, hers / Software Sustainability Institute, UK / anenadic / anenadic@manchester.ac.uk
- Isaac Overcast / he, him, his / University of Maine / isaacovercast / isaac.overcast@maine.edu :thumbsup: :sunglasses: / [Isaac's notes](https://codimd.carpentries.org/F-qhXllBSEeqDKWCfu-btQ?both)
- Rilquer Mascarenhas / he, him, his / City University of New York / rilquer / rilquermascarenhas@gmail.com
- Connor French / he, him, his / City University of New York / connor-french / french.connor.m@gmail.com :frog:
- Jacob Idec / he, him, his / University of Florida / jidec / jacob.idec@ufl.edu
- Renata Diaz / she, her, hers / University of Maine / diazrenata / renata.diaz@weecology.org 
- Andy Rominger / he, him, his / University of Maine / ajrominger / andrew.rominger@maine.edu


## Code of Conduct

[The Carpentries Code of Conduct](https://carpentries.github.io/lesson-development-training/instructor/CODE_OF_CONDUCT.html)
* Use welcoming and inclusive language
* Be respectful of different viewpoints and experiences
* Gracefully accept constructive criticism
* Focus on what is best for the community
* Show courtesy and respect towards other community members

If you believe someone is violating the Code of Conduct, we ask that you report it to The Carpentries Code of Conduct Committee completing [this form](https://goo.gl/forms/KoUfO53Za3apOuOK2), who will take the appropriate action to address the situation.


## [Day 1 Notes](https://codimd.carpentries.org/2022-12-05-collaborative-lesson-development-training?both)

## [Day 2 Notes](https://codimd.carpentries.org/2022-12-06-collaborative-lesson-development-training?both)
(notes these were moved so the urls are consistent)

## Day 3 Notes

### Stay on Target

#### Exercise: designing a diagnostic exercise (20 minutes)
Create a multiple choice question (MCQ) that could be used in your lesson, to detect the misconception you identified above. As well as the correct answer, include 1-3 answer options that are not obviously incorrect (*plausible distractors*) and have *diagnostic power* i.e. each incorrect answer helps you pinpoint the exact misconception carried by the learner.

Share your MCQ in the collaborative notes document.

Some MVC examples used for a quiz to do ahead of training to test prior knowledge:
https://carpentries-incubator.github.io/python-intermediate-development/quiz/index.html


- Connor
    - > Q: What R function is appropriate for loading abundance data into your R environment?

        >a) read.FASTA()
        >b) write.csv()
        >c) read.csv()
        >d) load.table()
        >
- Renata
    - Which summary statistic would give you the most insight into how different species in a system are partitioning abundance?
        - Species richness
        - Hill number q = 0
        - Simpson's evenness
        - Average species genetic diversity

**Isaac**
What is the best way to deal with a sparse data matrix in PCA?
* Remove all columns with missing data
* Interpolate missing values based on some heuristic
* Reduce missing data to maximize signal-to-noise ratio
* Use the full, untreated data matrix


**Rilquer**
1. Thinking of the more general misconceptions we mentioned above:
>Q: What package can you use to calculate genetic diversity (pi) from DNA sequence data?
>
>a) All below
>b) PopGenome
>c) diveRsity
>d) pegas

2. A more specific question about possible misconceptions when learning to use R (might not be super useful in the context of our workshop but it was easier for me to exercise implementing diagnostic "wrong" options):

>Q: What is the appropriate syntax to read a csv file named “abundance.csv” located in your working directory, into a data.frame named “abund” in R?
>
>a) abund <- read.csv(‘abundance.csv’)
>b) read.csv(‘abundance.csv’)  #Forgetting to save it to an object
>c) abund <- read.csv(abundance.csv)  # Forgetting to use comma
>d) Abund <- read.csv(‘abundance.csv’)  # Forgetting that R is case sensitive

- Jacob 
>Q: Which of the following is a valid set of R packages for a workflow analyzing summary statistics?

>a) vegan to summarize trait data, ape to summarize pop gen structure, phytools to analyze  phylo structure, hillR to calculate Hill numbers

>b) roleR to summarize trait data, ape to summarize pop gen structure and analyze phylo structure,  hillR to calculate hill numbers

>c) vegan to summarize trait data, ape to summarize pop gen structure, phytools to analyze phylo structure, roleR to calculate Hill numbers

>d) All of the above (correct answer) 
>
#### Exercise: reviewing formative assessments (10 minutes)
**(this exercise will only work if participants have sufficient knowledge of their partner's topic)**

The Trainers will group you into pairs.

Review the MCQ designed by your partner. When providing feedback, try to answer the following questions:

- Is the question clear and easy to understand? Could the wording be improved in some way?
- Are the incorrect answers to the MCQ plausible distractors?
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?


Share your feedback in the collaborative notes document.






#### Renata's feedback


- Is the question clear and easy to understand? Could the wording be improved in some way?
    - @Rilquer's "abund.csv" question: This one is sneaky (i.e. highly diagnostic) and I like it. My one suggestion would be "What syntax would _work_" instead of "What is the appropriate syntax" just because there's always multiple appropriate syntaxes(i?) when coding and I like to reinforce that perspective in teaching. 
- Are the incorrect answers to the MCQ plausible distractors?
    - @Rilquer: :heavy_check_mark: 
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - @Rilquer: :heavy_check_mark:
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - @Rilquer: Probably, but this is a good starting point and has plenty of options already. If we were working with paths I might include some diagnostics there, because they can be tricky for learners. And I might also include something using a different function with a tempting name (e.g. `load`).


#### Andy's feedback

*@Connor's q:*

- Is the question clear and easy to understand? Could the wording be improved in some way?
    - all good
- Are the incorrect answers to the MCQ plausible distractors?
    - yes!
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - yes! 
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - i wonder if we could target some kind of misconception that people think they *have* to use specialty functions from vegan or something like that

*@Isaac's q:*

- Is the question clear and easy to understand? Could the wording be improved in some way?
    - i wonder if the "signal to noise" answer could be changed to be more simple, something like "remove rows with missing data"
- Are the incorrect answers to the MCQ plausible distractors?
    - yes!
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - yes! 
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - could maybe add an answer (or modify one) to be about removing missing rows
    - could also maybe add an answer something like "PCA cannot be accomplished with missing data" (get's very directly at misconception that data must be perfect)


*@Renata's q:*

- Is the question clear and easy to understand? Could the wording be improved in some way?
    - all good
- Are the incorrect answers to the MCQ plausible distractors?
    - yes!
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - yes! 
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - all good


*@Rilquer's q:*

- Is the question clear and easy to understand? Could the wording be improved in some way?
    - all good
- Are the incorrect answers to the MCQ plausible distractors?
    - yes!
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - yes! 
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - i feel like "all of the above" is a tricky one if not paired with "none of the above" or something

*didn't get to Jacob's!!!*


#### Jacob's feedback

@ Renata's Q

- Is the question clear and easy to understand? Could the wording be improved in some way?
    - Generally, but partitioning is somewhat hard to understand at first glance
- Are the incorrect answers to the MCQ plausible distractors?
    - Yes
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - Yes, including that Hill q 0 is different from rich or that rich has to do with partitioning 
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    - Could add a different hill number q to make students consider what different qs mean
    - Also answers with multiple stats that would work would be difficult and probably effective

#### Isaac's feedback
@ Renata's Q
- Is the question clear and easy to understand? Could the wording be improved in some way?
    - I think it's good, but I think 'partitioning' is maybe too obscure. I can't think of a better word though ;p
- Are the incorrect answers to the MCQ plausible distractors?
    - Yes, they are plausible
- Do the incorrect answers provide diagnostic power, to help an Instructor identify the misconception the learner has?
    - It seems so
- Are there any incorrect answers missing i.e. are there other misconceptions that could be detected with this MCQ?
    -  I can't think of any


**Connor's feedback**
Renata
- slight wording clarity. "how different species in a system are partitioning abundance" makes it seem like species are partitioning abundance within themselves. Reword to "...how abundance is partitioned among species in a system"
- Yes
- Yes
- No, these are all diagnostic. Maybe Pagel's lambda if she wants to throw in a phylogenetic sum stat in there

Isaac
- "best way" and "deal with" are ambiguous. A better way to phrase would be to ask a more specific question, e.g. "Which of the following approaches gives you the least biased results when performing a PCA on a sparse data matrix?"
- Based on my understanding, two of the questions could be the most appropriate approach depending on the data set (2 and 3)
- Yep!
- Not that I can think of

**Key Points**:
- The goal of lesson development is to ensure that the **attained curriculum** matches the **intended curriculum** as closely as possible.
- Assessments are a way to determine whether the objectives you defined for the lesson have been reached.
- **Formative assessment** happens *during teaching* and provides feedback both to an instructor and a learner - about progress and whether learning of new concepts occurred but also about any misunderstandings and misconceptions which can hinder further learning.
- It is important to detect misconceptions as early as possible and formative assessments (such as multiple choice questions) can help us with this.

--- 

### Designing Assessments

**Questions**:
- Why are exercises so important in a lesson?
- What are some different types of exercises, and when should they be used?
- How should exercises be presented in a lesson website?


**Objectives**:
After following this part of the training, participants should be able to...
- choose the format for an exercise based on the outcome it is intended to measure.
- display exercises and their solutions in a lesson site.

#### RESOURCES TO EXPLORE FOR MORE EXAMPLE ASSESSMENT TYPES
* [Exercise Types Chapter from Teaching Tech Together](https://teachtogether.tech/en/index.html#s:exercises)
    * Greg's whole book is a fantastic resource for anyone who wants to learn more about the lesson design concepts and approaches introduced in this training.
* [Edutopia’s 56 Examples of Formative Assessment](https://www.edutopia.org/groups/assessment/250941)
* [H5P Examples and Downloads for Interactive Content](https://h5p.org/content-types-and-applications)


#### Notes

- approx 3 exercises per approx 1 hour episode
- lean on the objectives to form exercises 
    - if using action words like "explain" then should have discussions
    - if using more coding-style action words then think about debugging code, refactoring, etc
- every objective should have an exercise 


#### Exercise: Exercise Types and When to Use Them (15 minutes)
The Trainers will assign you to pairs or small groups, and give each group an exercise type to focus on. Each group should assign a notetaker, to summarise your discussion at the end of the exercise.

Read about your given exercise type [in the *Exercise Types* chapter of *Teaching Tech Together*](https://teachtogether.tech/en/index.html#s:exercises) by following the relevant link below.

- [fill-in-the-blanks](https://teachtogether.tech/en/index.html#fill-in-the-blanks) - Room 1 - Isaac and Renata
- [Parsons problems](https://teachtogether.tech/en/index.html#parsons-problem) - Room 2 - Andy and Connor
- [minimal fix](https://teachtogether.tech/en/index.html#minimal-fix) - Room 3 - Jacob and Rilquer

Then, discuss the following questions together:

- What kind of skills would an exercise of this type assess? Try to identify some action verbs like those we used to write lesson objectives earlier in the workshop.
- Would this type of exercise be suited to a novice audience? Or is it a better fit for intermediate or advanced learners?
- Would this kind of exercise work well in an in-person workshop setting? Would it be better suited to self-directed learning and/or a virtual workshop?

Share the major points of your discussion in the collaborative notes document.


**Fill in the blanks**

- What kind of skills would an exercise of this type assess? Try to identify some action verbs like those we used to write lesson objectives earlier in the workshop.
    - They seem most useful for checking the ability to *use* specific tools correctly. Not too much describing of nuance, lots of checking actual facility with the nuts and bolts. 
    - If you strung them together in increasing difficulty, you could call on the ability to transfer concepts to new problems/contexts.
    - Recalling a specific piece of knowledge, recognizing the whole is less important 
- Would this type of exercise be suited to a novice audience? Or is it a better fit for intermediate or advanced learners?
    - yes, this is good for novices, it gives a 'plug and chug' approach, and allows for experimentation within a constrained environment. 
    - it saturates pretty quickly with skill - intermediate/advanced learners might be bored
    - easy ones like the shown would be good for novices, but could be made intermediate 
- Would this kind of exercise work well in an in-person workshop setting? Would it be better suited to self-directed learning and/or a virtual workshop?
    - It could work in either setting. FITB questions are kind of like open-ended multiple choice in this way, so they can be quick and assessment like.
    - They're good for immediate temperature checks in synchronous learning
    - And for self-practice independently :) 


**Parsons problems**

- What kind of skills would an exercise of this type assess? Try to identify some action verbs like those we used to write lesson objectives earlier in the workshop.
    - skills
        - coding 
        - analytical workflows
        - debugging
        - identify I/O
        - understand language-specific syntax
        - good style
    - action words
        - rearrange
        - debug
        - interpret workflow
        - interpret output
        - identify I/O
- Would this type of exercise be suited to a novice audience? Or is it a better fit for intermediate or advanced learners?
    - not for pure *pure* **pure** novice
    - reasoning through analytical workflows could work for novice trending toward intermediate
    - generally good for intermediate and above
- Would this kind of exercise work well in an in-person workshop setting? Would it be better suited to self-directed learning and/or a virtual workshop?
    - could work in all settings
    - might be particularely well suited (compared to other assesments) to virtual and self-directed
    - not to say it's *bad* for in person, just that it could be really good for self-directed/virtual


**Minimal fix**
- What kind of skills would an exercise of this type assess? Try to identify some action verbs like those we used to write lesson objectives earlier in the workshop.
	- reading code line by line
	- identifying places in syntax where a small change makes a big difference - creating a mental model "heuristic" to do so 
	- identifying mistakes and debugging
	- could help with syntax if the error is there
	- minimum is interesting - could be many ways you can fix, but what is the simplest? 
- Would this type of exercise be suited to a novice audience? Or is it a better fit for intermediate or advanced learners?
	- Intermediate to advanced -  requires connecting concepts more so than fill in but less so than parsons - "minimum" requirement  is more difficult for novices 
	- However you could highlight multiple places where a fix can occur to make it more novice suitable
	- simple mistakes like colon missing with clear debug response can be good for novices 
- Would this kind of exercise work well in an in-person workshop setting? Would it be better suited to self-directed learning and/or a virtual workshop?
	- Would work well in any setting I think, no computer required, could be assessed automatically in a virtual setting 
	- Students and instructor can discuss wrong answers and what the wrong answers would do differently than the target 


#### Exercise: Assessing an Objective (30 minutes)
Using one of the exercise formats you have learned about so far, design an exercise that will require learners to perform one of the actions described in the objectives you wrote for your lesson, and that assesses their ability to do so.




**Renata - minimal fix for diversity metrics**

> Modify this code so it calculates Simpson evenness on the vector called `species_abundances`:
    > `library(vegan)`
    > `diversity(species_abundances)`
    > 
> Hint: As written it will calculate Shannon's index.
> Hint 2: This code is synonymous with the line as written:
    > `diversity(species_abundances, index = "shannon"`
> Answer:
    > `diversity(species_abundances, index = "simpson")`
> Rationale: `diversity` defaults to Shannon. In the context of this lesson, we'll (probably) have mentioned this already. In programming more generally, fixing this involves understanding function defaults, how to look up what a function is defaulting to, and how to change it. 

**Jacob - fill in the blank for the diversity metrics objective "Use hillR to calculate Hill numbers for each data type"**

> A. Fill in the blanks so that the code below creates a vector of Hill numbers for community taxonomic richness as the 'hn' object.
> 
> `comm <- FD::dummy$abun`
> `traits <- FD::dummy$trait`
> `hn <- hillR::hill_taxa(__,q=__)`
> 
> Blank 1 = `comm`
> Blank 2 = `0`
> 
> Addresses that community abundance data only is required for richness, and than richness is the same as q=0
> Could expand to multiple ABC with different answers for the blanks, i.e. taxonomic alpha diversity (which would be the same), trait beta diversity (B1 = comm, additional B2 = traits, B3 = 1)

** Rilquer - fill in blanks for importing data **

Objective 3: Reading phylogenetic data from Nexus files into Phylo format.

> Fill in the blanks so that the code below reads the tree file “birds.nex” into an object named bird.tree, and then visualizes the tree.
> 
> `\____ <- \____ ('birds.nex')`
> `plot( \____ )`
> 

Rationale: Checking basic syntax for importing the data and visualizing the data. One mistake I can see an R beginner doing here is misusing quotes (might not happen in our workshop though, considering we expect some basic knowledge of R).

**Andy** 

Parsons

```
# # run to make a pretend dataset
# sppList <- c('Trimerotropis maritima', 'Chortophaga viridifasciata',
#              'Dissosteira carolina', 'Arphia sulphurea',
#              'Arphia sulphure', 'Disosteira carolina')
# abund <- data.frame(sp = rep(sppList, each = 2), n = 1)


cleanTax <- gnr_resolve(abund$sp, 
                        best_match_only = TRUE)

cleanTax <- cleanTax[, c('user_supplied_name', 'matched_name')]

cleanTax$matched_name <- gsub(' \\(.*', '', cleanTax$matched_name)


abund <- read.csv('data/abund.csv')

names(cleanTax) <- c('sp', 'clean_name')


abund <- aggregate(list(abund = abund$n), list(sp = abund$clean_name), sum)

abund <- merge(abund, cleanTax)

library(taxize)
```

**Connor**

**Minimal fix**
Q1
> Now that you have read in `trait.csv` as the R object `traits`, you tried to visualize the distribution of your data, but ran into a problem. Correct your code so you can see the distribution of your trait! *Note*: your data has a single column named `trait`  
> Your code:  
> `histogram(traits$trait)`

Answer: `hist(traits$trait)`

Q2. 
> You want to make your histogram more aesthetically pleasing by changing the color of the bars, but something isn't working. Fix your code so your plot is a beautiful shade of green.
> Your code:  
> `hist(traits$trait, color = "green")`
> 

Answer: `hist(traits$trait, col = "green")`

Q3 
>You are interested in how the wing length phenotypic variable you measured maps onto the phylogeny. You decided to color the tips according to wing length using a continuous scale. However, you get wonky results when you run your code. How do you fix it to correctly map the colors?  
> Your code:  
```
wing_color <- colorRampPalette(c("blue", "red"))(length(birds$edge))
plot(birds, tip.color = wing_color)
```

Answer:  
```
wing_color <- colorRampPalette(c("blue", "red"))(length(birds$wing.length))
plot(birds, tip.color = wing_color)
```



----
some formative assessment ideas

- write down one thing clear, one thing not clear
- draw a conceptual diagram
- have a pre-drawn diagram and have learners label it



#### Exercise: Formatting Exercises in a Lesson Site (15 minutes)
Using the approach demonstrated by the Trainers, format the multiple-choice question or another exercise you designed previously as an exercise in your lesson site.

```markdown
::: challenge
### Exercise Title (can be any heading level)
How do you write the solution as a nested fenced div?

:::::: solution

This is how you write the solution as a nested fenced div.

:::::::::::::::

::::::::::::
```

The [Carpentries workbench component guide](https://carpentries.github.io/sandpaper-docs/component-guide.html) lists the other fensed divs possible.
You can also add [code blocks](https://carpentries.github.io/sandpaper-docs/episodes.html#code-blocks-with-syntax-highlighting) into exercises or other areas of the lesson. This is more for the md format.  You can use the include/message/echo/etc options for Rmd for code chunks using the Rmd option.

**Key Points**:
- Exercises are important for learners to move what they've learned to long-term memory.
- Some types of exercises are better for particular audiences and to address certain objectives.
- Exercises (and solutions) go in blocks using fenced divs in the lesson.

---

### Example Data and Narrative

**Questions**:
- Why should a lesson tell a story?
- What considerations are there when choosing an example dataset for a lesson?
- Where can I find openly-licensed, published data to use in a lesson?


**Objectives**:
After following this part of the training, participants should be able to...
- find candidate datasets to use in a lesson.
- evaluate the suitability of a dataset to be used in a lesson.
- choose examples that will prepare learners for formative assessments in the lesson.
- develop a story.

License compatability table: https://creativecommons.org/faq/#can-i-combine-material-under-different-creative-commons-licenses-in-my-work
Commentary about different licenses for free software: https://www.gnu.org/licenses/license-list.en.html

an example of a data dictionary: https://datacarpentry.org/socialsci-workshop/data/

read more about why CC-BY is not a good fit for data: https://osc.universityofcalifornia.edu/2016/09/cc-by-and-data-not-always-a-good-fit/

Portal project database: https://figshare.com/articles/dataset/Portal_Project_Teaching_Database/1314459

CARE Principles for Data Governance: https://doi.org/10.5334/dsj-2020-043

#### Dataset considerations
- Ethical use (see prompts below)
- License - CC0 Recommended
- Complexity - _Is it easy to understand?_ _Is it sufficiuently authentic?_
- Number and types of variables

#### Questions about Ethical Use of Datasets
- Does the data contain personally identifiable information?
- Was the data collected without permission from the groups or individuals included?
- Will the data be upsetting to learners in the workshop?

[CARE Principles for Indigenous Data Governance](https://doi.org/10.5334/dsj-2020-043) - Collective Benefit, Authority to Control, Responsibility, and Ethics


#### Examples of Public Repositories
- [Dryad](https://datadryad.org/)
- [The Data Cuartion Network’s datasets](https://datacurationnetwork.org/datasets/)
- [The Offical Portal for European Data](https://data.europa.eu/)
- [DataONE](https://www.dataone.org/)
- [The Official Portal for Argentina Data](https://www.datos.gob.ar/) - In Spanish

FAIR data sharing: https://www.nature.com/articles/sdata201618
FAIR data principles: https://www.go-fair.org/fair-principles/

Finding data:
focussing on simulated data, have a good sense of how we will generate that
any real data would come from within our group or close collaborators

Let Them Eat Cake (First), by Mine Çetinkaya-Rundel, Associate Professor, Department of Statistical Science, Duke University & Professional Educator at RStudio: https://www.youtube.com/watch?v=fQ4t7p6ZXDg

**Key Points**:
- Using a narrative throughout a lesson helps reduce learner cognitive load
- Choosing a lesson includes considering data license and ethical considerations.
- Openly-licensed datasets can be found in subject area repositories or general data repositories.

**Please give us feedback**: https://forms.gle/Af7rk8NN4v6L25C77

## [Day 4 Notes](https://codimd.carpentries.org/2022-12-09-collaborative-lesson-development-training?both)