# Collaborative Lesson Development Training
:::info
**Dates**: 5&6 + 8&9 December 2022 (part 1) & TBC (part 2)
**Time**: [13:00-17:00 UTC](https://www.timeanddate.com/worldclock/fixedtime.html?msg=Collaborative+Lesson+Development+Training&iso=20221205T13&p1=1440&ah=4)
**Zoom link**: https://carpentries.zoom.us/j/98047502268?pwd=V0E4Zmt2ZmhZajdxN3grUmF1d2hadz09
**Code of Conduct**: https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html
**Curriculum**: https://carpentries.github.io/lesson-development-training/
**Shared Timer**: https://cuckoo.team/carpentries-lessondev-training
**Day 1 Notes**: https://codimd.carpentries.org/2022-12-05-collaborative-lesson-development-training?both

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

## Day 2 Notes

### The Carpentries Workbench

**Questions**:
- How is a lesson site set up and published with GitHub?
- What are the essential configuration steps for a new lesson?
- How do you create and modify the pages in a lesson?

**Objectives**:
After following this part of the training, participants should be able to...
- identify the key tools used in The Carpentries lesson infrastructure.
- complete the fundamental setup steps for a new lesson repository.
- edit Markdown files using the GitHub web interface.

[The Workbench markdown Template](https://github.com/carpentries/workbench-template-md/generate)
[The Workbench RMarkdown Template](https://github.com/carpentries/workbench-template-rmd/generate)

Shared repository for the cohort: https://github.com/role-model/multidim-biodiv-data 

Rendered lesson: https://role-model.github.io/multidim-biodiv-data/

Workflow notes:
- Work or merge to main
- Changes in main will get auto-populated to gh-pages branch.
- Changes to the gh-pages branch would get overwritten with the content of main on build.
- Part of the website landing page is rendered from index.md (e.g. prerequisite skills); followed by the contents of learners/setup.md
- Workbench is in beta, including documentation. Open to issues flagging spaces for community improvements to docs.
- 


#### Exercise: Practice with `config.yaml` (5 minutes) - Homework for 1 person
Complete the configuration of your lesson by adjusting the following fields in config.yaml:

* `email`: add an email address people can contact with questions about the lesson/project.
* `created`: the date the lesson was created (today’s date) in YYYY-MM-DD format.
* `keywords`: a (short) list of keywords for the lesson, which can help people find your lesson when searching for resources online.
* `source`: change this to the URL for your lesson repository.

We will revisit the `life_cycle` and `carpentry` fields in `config.yaml` later in this training.


#### Exercise: Improving the `README.md` (5 minutes) - Homework for 1 person
The `README.md` file is the "front page" of your lesson repository on GitHub, and is written in Markdown. You should use it to provide basic information about the project, for anyone who finds their way to the source files for your lesson. Take a few minutes to update it with some basic information about the project:

- the lesson title
- a short description of the lesson
- a list of the names of the authors, optionally linked to their GitHub profile

Workbench documentation: https://carpentries.github.io/sandpaper-docs/
This episode of this training: https://carpentries.github.io/lesson-development-training/07-infrastructure.html

### lesson repo set-up to-do

- [ ] update README
- [ ] update config.yaml
- [ ] write setup in setup.md
- [ ] update index.md with skills from day 1 



**Please give us feedback on what is working and what could be improved, _especially_ in the documentation!**


#### Episode filenames
- renatas-episode.Rmd 
- connor-episode.Rmd
- jacobs-episode.Rmd
- isaac-sandbox-episode.Rmd
- rilquer-episode.Rmd
- andys-laser-cat.Rmd


### Defining Episode Objectives

**Questions**:
- How should objectives be written for a smaller part of a whole lesson?
- How are objectives added to an episode page?


**Objectives**:
After following this part of the training, participants should be able to...
- define learning objectives for a section of a lesson.
- format objectives in the individual pages of a lesson website.

### Defining Episode Objectives

**Questions**:
- How should objectives be written for a smaller part of a whole lesson?
- How are objectives added to an episode page?


**Objectives**:
After following this part of the training, participants should be able to...
- define learning objectives for a section of a lesson.
- format objectives in the individual pages of a lesson website.

Group options for epsiodes to work with -

- **Importing data** - Rilquer and Andy
    - https://github.com/role-model/multidim-biodiv-data/blob/main/episodes/rilquer-episode.Rmd
- Framing hypotheses
- **Summary statistics** - Jacob and Renata
    - https://github.com/role-model/multidim-biodiv-data/blob/main/episodes/summary-statistics.Rmd
    - https://role-model.github.io/multidim-biodiv-data/summary-statistics.html 
- **Visualization** - Connor and Isaac
    - https://github.com/role-model/multidim-biodiv-data/blob/main/episodes/connor-episode.Rmd
- Synthesizing/joining data
- 

data types: abundance, population genetics,  phylogenetics, traits

#### Exercise: Define Objectives For Your Episode (30 minutes)
1. Using the same approach as you did for your whole-lesson objectives, define a set of SMART objectives for your chosen episode. (15 minutes)
1. Add this list of objectives to replace the `TODO` in the `objectives` fenced div of your episode file (5 minutes)
- Come back together
3. Compare your list with those created by your collaborators on the lesson:
    - are there any gaps in these objectives, i.e. anything that should be covered in these episodes but is not captured in the objectives?
    - are there any overlaps, i.e. anything that looks like it will be covered more than once?
4. As a group, discuss how you will address any problems identified in the previous step, and edit your objectives accordingly.
    - issue with how to handle multiple data type imports and what the learners are bringing to the workshop - suggestion:  work with simihttps://www.edutopia.org/groups/assessment/250941lated data and then add an episode at the end to have learners work with the other data types
    - question about using vegan, foo, phytools, hillR packages?  which tools will we be teaching? ape? (has very similar syntax to base R)
    - issue ggplot vs base R - which tool should we use?  suggestion to use base R to avoid cognitive overload of switching to ggplot (also another style of coding)
    - question - do we want to do the visualization as a separate episode or work it into the other sections? When you do the summary stats - you plot it - for example.  Suggestion: alt organization might be to split modules by data type - abundance data (load, summarize, visualize), then another data type
    - 
    - 

SMART objectives
- Specific: they should clearly describe a particular skill or ability the learner should have.
- Measurable: it should be possible to observe and ascertain when the learner has learned the skill/abilities described in the objectives.
- Attainable: the learner should realistically be able to acquire the skills or abilities in the time available in a workshop/by following the text of the lesson.
- Relevant: they should be relevant to the overall topic or domain of the lesson as a whole.
- Time-bound: they should include some timeframe within which the goal will be reached. For learning objectives, this is built into the approach described above.


https://carpentries.github.io/sandpaper-docs/component-guide.html

Homework assignment (this is optional but will be useful for tomorrow where we develop exercises to assess learners progress on an objective):
- Spend some time considering the new structure the group discussed of splitting up episodes by data type and think about how the episode objectives need to be rearranged to fit this new structure.  Which objective belong in which episode of the new structure?  Are there now objectives missing or that need to be tailored to the new episodes?


### Stay on Target

**Questions**:
- How can you measure learners’ progress towards your lesson objectives?
- Why is it important to identify misconceptions as early as possible?
- Why should we create assessments before we have written the explanatory content of our lesson?


**Objectives**:
After following this part of the training, participants should be able to...
- explain what is meant by the intended and attained curriculum of a lesson.
- describe the importance of regular assessment while a lesson is being taught.
- design assessments to identify the misconceptions learners might have during your lesson.

* Intended (planned) curriculum: the learning objectives defined for the lesson
* Implemented curriculum: the content developed to guide learners to meet those objectives
* Attained curriculum: what the learners _actually_ learned from the lesson

Recommended further reading: https://f1000research.com/documents/9-1377

*Formative assessment*- gives you a chance to pick up misconceptions and correct them during the course of teaching
- enables long-term memory of concepts
- want to implement every 15-20 minutes of learning
    - Don't need to be complex or time consuming to be effective

Having a defined, correct answer in an assessment/exercise gives learners a chance to feel like they're learning something and helps them learn more effectively.

More examples of formative assessment:
    - [21 ways to check for student understanding](https://www.opencolleges.edu.au/informed/features/21-ways-to-check-for-student-understanding/)
    - [Edutopia’s “56 Examples of Formative Assessment”](https://www.edutopia.org/groups/assessment/250941)

#### Exercise: misconceptions (5 minutes)
What are the common misconceptions learners can have about the topic of your lesson?
How might you identify that misconception in your learners while they follow your lesson?
Share your answer in the collaborative notes document.

Hint: Try thinking about related or common tools the learners might know and how applying that prior knowledge might lead to a misconception with
the topic you are teaching.

- data they have in hand is how everybody else's data look (whereas everyone's data is unique)
- "I have no idea how to do the things I don't have experience with"; "There are no connections between what I know and what I don't (yet)"
- for any existing thing they wanted to do there was already one perfect package that did it all - there is one perfect tool to do everything
- my data has to be perfect and just like example data in order to be able to do the analysis 

Pithy (mis)misconceptions:
* There is no 'perfect tool'
* There is no 'perfect data'
* There is no 'perfect model'

Strategies to identify when learners have arrived with misconceptions:
- get learners to list packages that they assume should be used for the type of data they have
- people can share their example data/formats to prove the point about data being different
- start with lightning talks on projects people were working on to help learners recognise they are not alone in the thing they are doing

#### Multiple Choice Question Example
> Q: What is 27 + 15?
> 
> a) 42
> b) 32
> c) 312
> d) 33


b) they do not understand the concept of a carry and are throwing it away completely
c) they understand the concept of a carry and know that they cannot just discard the carried ‘1’, but do not understand that it is actually a ten and needs to be added into the next column - they are treating each column of numbers as unconnected to its neighbours.
d) they understand that they need to carry ‘1’ but are adding it to the wrong column.

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


- Rilquer
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

**Key Points**:
- The goal of lesson development is to ensure that the **attained curriculum** matches the **intended curriculum** as closely as possible.
- Assessments are a way to determine whether the objectives you defined for the lesson have been reached.
- **Formative assessment** happens *during teaching* and provides feedback both to an instructor and a learner - about progress and whether learning of new concepts occurred but also about any misunderstandings and misconceptions which can hinder further learning.
- It is important to detect misconceptions as early as possible and formative assessments (such as multiple choice questions) can help us with this.

**Please give us feedback**: https://forms.gle/Af7rk8NN4v6L25C77


## [Day 3 Notes](https://codimd.carpentries.org/2022-12-08-collaborative-lesson-development-training?both)

## [Day 4 Notes](https://codimd.carpentries.org/2022-12-09-collaborative-lesson-development-training?both)