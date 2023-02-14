# Collaborative Lesson Development Training
:::info
**Dates**: 5&6 + 8&9 December 2022 (part 1) & TBC (part 2)
**Time**: [13:00-17:00 UTC](https://www.timeanddate.com/worldclock/fixedtime.html?msg=Collaborative+Lesson+Development+Training&iso=20221205T13&p1=1440&ah=4)
**Zoom link**: https://carpentries.zoom.us/j/98047502268?pwd=V0E4Zmt2ZmhZajdxN3grUmF1d2hadz09
**Code of Conduct**: https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html
**Curriculum**: https://carpentries.github.io/lesson-development-training/
**Shared Timer**: https://cuckoo.team/carpentries-lessondev-training
**Day 2 Notes**: https://codimd.carpentries.org/2022-12-06-cldt-trainer-notes?edit
**Day 3 Notes**: https://codimd.carpentries.org/2022-12-08-collaborative-lesson-development-training?both
**Day 4 Notes**: 
https://codimd.carpentries.org/2022-12-09-collaborative-lesson-development-training?both

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

## [Day 3 Notes](https://codimd.carpentries.org/2022-12-08-collaborative-lesson-development-training?both)

## Day 4 Notes

#### Exercise: Examples Before Exercises (10 minutes)
Looking back at one of the exercises you designed before: what examples could you include in your narrative to teach learners the skills they will need to apply to complete the formative assessments you have designed?

Examples: 
In the Software Carpentry Plotting and Programming with Python Lesson:
Exercise to load and inspect americas csv -> In the lesson, load the oceania data table and explore the values with a few different functions.
In the Python Interactive Data Visualization Lesson in the Incubator:
Exercise to find the correct widget (a slider widget) for an action and modify the script to use it -> In the lesson the instructor introduces the cheatsheet and documentation and then creates a dropdown widget for the application.

**Outline one of these examples in your episode file.**


**Connor**:  
Exercise: Create a barplot of the rank species abundance distribution, using the `barplot` function.  

Example: Demonstrate how to read in a CSV file and order the data in R, using an example abundance data set. 

**Isaac:**  
Exercise: "Coloring branches based on trait values"
Example: Introduce the idea that you can modify the phylogeny to display more information by coloring branches. Show the syntax for coloring branches based on abundance.

**Jacob**
A diversity index is a single value measure that describes how diverse a dataset is. 
Hill numbers are a unified set of these indices where the Q value, an exponent “order” starting at 0, defines what it means. In the hill_taxa function, the first parameter is teh dataset of interest and the second parameter is the Q order. When q is 0, the Hill number is equivalent to richness. 
(not an outline, oops)


**Renata**
 Intro/refresher on different common summary statistics for species abundance

  - Why do we use summary stats?
  - What do richness, diversity, evenness capture
  - Link to references for further reading, equations

 Tour of calculating these metrics with `vegan`

  - Loading the `vegan` package
  - Looking at `diversity` and its arguments
  - Live-coded example calculating Shannon diversity, Simpson, invSimpson by changing arguments



### How to Write a Lesson

**Questions**:
- Why do we write explanatory content last?
- How can I avoid demotivating learners?
- How can I prioritise what to keep and what to cut when a lesson is too long?


**Objectives**:
After following this part of the training, participants should be able to...
- estimate the time required to teach a lesson.
- summarise the content of a lesson as a set of questions and key points.
- connect the examples and exercises in a lesson with its learning objectives.

#### Group Discussion
- At what point is a lesson too long?
- How might you prioritise what to keep if you have to cut it down?


#### Length Considerations
- What is essential to include?
- What can be left out if needed?
- Are there checkpoints where the lesson could end if needed?
- Can important concepts be moved up earlier to ensure they are covered?

[Template for notes on pilot workshops](https://codimd.carpentries.org/lesson-pilot-observation-notes-template#)

#### Review Your Text for Demotivations

- dismissive language - e.g. ‘simply’, ‘just’
- use of stereotypes - check learner profiles for stereotypes too
- expert awareness gaps, i.e. places where you may be assuming the learners know more than they actually do
- fluid representations, i.e. using different terms with the same meaning interchangeably
    - This one is definitely confusing and avoidable and rampant.
    - "directory" <- :) Good example though.
- unexplained or unnecessary jargon/terminology
- unexplained assumptions
- sudden jumps in difficulty/complexity

The episode of Instructor Training about motivation and demotivation is also well worth a read, if you haven’t attended that training https://preview.carpentries.org/instructor-training/08-motivation.html

#### Review Your Text for Accessibliity
- Avoiding regional/cultural references and idioms that will not translate across borders/cultures
- Avoiding contractions i.e. don’t, can’t, won’t etc.
- Checking that all figures/images have [well written alternative text](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81), including writing ~~altnerative~~ text for data visualizations.
    - 'alternative'
- Checking the header hierarchy - no h1 headers in the lesson body, no skipped levels
- Using descriptive link text - no “click here” or “this page”, etc.
- Checking the text and foreground contrast for images

[Workbench docs for adding alt text](https://carpentries.github.io/sandpaper-docs/episodes.html#figures)

#### Exercise: Alternative Text for Images (5 minutes)
Which of the following is a good alt-text option for the image below?

![Atmospheric Carbon Dioxide at Mauna Loa Observatory](https://gml.noaa.gov/webdata/ccgg/trends/co2_data_mlo.png)

1. Graph of data
2. Graph with increasing lines
3. Line graph of increasing carbon dioxide in ppm at the Mauna Loa Observatory from 1958 to present
4. Line graph of increasing carbon dioxide in ppm at the Mauna Loa Observatory, Hawaii, United States, from 1959 to present including values from each year. Red line shows variation in each year and black line is average for each year. 1959 = 315.90 ppm, 1960 = 316.91, 1961 = 317.64 ...

[Writing Alt Text for Data Visualization](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)

[Glosario](https://glosario.carpentries.org/) - a (Carpentries) community supported multilingual glossary for computing and data science terms


#### Exercise: Completing Episode Metadata (5 minutes)
Add key points and questions to your episode.

To check the formatting requirements, see the Introduction Episode example in your lesson or [the Workbench Documentation](https://carpentries.github.io/sandpaper-docs/episodes.html#questions-objectives-keypoints)

[Checklist for lesson reviews in the Carpentries Lab](https://github.com/carpentries-lab/reviews/blob/main/docs/reviewer_guide.md#reviewer-checklist)

**Key Points**:
- The objectives and assessments provide a good outline for an episode and then the text fills in the gaps to support anyone learning or teaching from the lesson.
- It is important to review your lesson for demotivating language, cognitive load, and accessibility. 
- To reduce cognitive load and ensure there is enough time for for the materials, consider which lesson objectives are not needed and remove related content and assessments. 

### How We Operate

**Questions**:
- What does The Carpentries lesson development ecosystem look like?
- What are the important milestones in the development of a new lesson?
- How can The Carpentries lesson development community help me complete my lesson?

**Objectives**:
After following this part of the training, participants should be able to...
- describe the life cycle of a lesson.
- summarise the path a new lesson can take through The Carpentries Incubator and Lab.
- connect with other members of the community.

#### The Carpentries Curriculum Community

- https://carpentries-incubator.org/ | https://github.com/carpentries-incubator/
- https://carpentries-lab.org/       | https://github.com/carpentries-lab/

|                                       | Incubator          | Lab                |
| ------------------------------------- | ------------------ | ------------------ |
| lesson under development              | :heavy_check_mark: | :x:                |
| lesson stable                         | :heavy_check_mark: | :heavy_check_mark: |
| lesson has passed peer review         | :x:                | :heavy_check_mark: |
| lesson owned by community             | :heavy_check_mark: | :heavy_check_mark: |
| CC-BY license                         | :heavy_check_mark: | :heavy_check_mark: |
| The Carpentries Code of Conduct       | :heavy_check_mark: | :heavy_check_mark: |
| The Carpentries lesson infrastructure | :heavy_check_mark: | :heavy_check_mark: |


#### Lesson Life Cycle

- `pre-alpha`: first draft of lesson is being created
- `alpha`: lesson is being taught by authors
- `beta`: lesson is ready to be taught by other instructors
- `stable`: lesson has been tested by other instructors and improved based on feedback. Major changes and updates are relatively infrequent.

Can also publish to the [Journal of Open Source Education](https://openjournals.readthedocs.io/en/jose/) when you submit to the Lab.
You can also submit to a journal of your choice if you'd prefer.  As long as the lesson itself gets reviewed, we can talk about that being equivelant as the JOSE process.


[Lesson pilot notes template](https://codimd.carpentries.org/lesson-pilot-observation-notes-template#)

[Guidance for pilot workshops](https://docs.carpentries.org/topic_folders/lesson_development/lesson_pilots.html)

#### Connecting with the community

- Slack:
    - [join The Carpentries Slack workspace](https://swc-slack-invite.herokuapp.com/)
    - [`#lesson-dev` channel on The Carpentries Slack workspace](https://swcarpentry.slack.com/archives/C3KUTT5V3)
    - Browse existing channels
    - Create a Slack channel for your lesson
- Join monthly co-working sessions
    - listed on [The Carpentries Community Calendar](https://carpentries.org/community/#community-events)
- [`incubator-developers` mailing list](https://carpentries.topicbox.com/groups/incubator-developers)

Spotlight your lesson to get more Carpentries Community development - [Example Deep Learning post](https://carpentries.org/blog/2022/05/incubator-lesson-spotlight-deep-learning/) which includes a paragraph about submitting your lesson at the bottom.


#### Exercise: join relevant channels (5 minutes)
Use this time to explore the options listed above and join/subscribe to any communication channels that you find interesting.

**Key Points**:
- New lessons are developed in The Carpentries Incubator and reviewed in The Carpentries Lab.
- Teaching a lesson for the first time is an essential intermediate step in the lesson development process.
- The Carpentries lesson developer community shares their experience on multiple communication channels.

### Preparing to Teach

**Questions**:
- What can I do to prepare to teach my lesson for the first time?
- How should I communicate lesson setup instructions to learners?
- What information should be recorded for instructors teaching a lesson?
- How should information be collected as part of the feedback process?


**Objectives**:
After following this part of the training, participants should be able to...
- summarise lesson content as a teaching plan.
- add Setup Instructions and Instructor Notes to the lesson site.
- create a feedback collection plan.

#### Exercise: Prepare a teaching plan (15 minutes)
Create a bullet point list or brief notes describing what you will say and do when teaching the episodes you have been focussing on during this training.


**Andy teaching plan for Abundance Data**

- pre-lesson setup:
    - make sure R script runs with most recent package versions
    - make sure data are on hand
    - make a blank doc for live demos
    - have slides read for 
        - visualizations
        - abundance data formats
- motivation:
    - start with a vizualization of SAD responding to something (e.g. chronosequence in Hawai\`i)
    - go into how to quantify that response (covered by Renata!)
- data import and cleaning:
    - live demo of `read.csv`
    - schematic vizualization of different formats for abundance data
    - live demo of cleaning taxonomy
    - live demo of aggregating data
    - live demo of putting it all together
    - *Data Import Challenge*
    


**Renata teaching plan for (part of) Diversity Indices**

- Pre-lesson setup: Make sure necessary packages (tbd :P) are installed
- Motivation/framing: 
    - How many folks are familiar with diversity indices and use them in their own work? How do you use them? 
    - (Somewhat depending on responses there) Discussion of why we use diversity indices (RMD Is fond of the "Here's 30 SADs in a timeseries, what can we draw from this? Consternation!" example, but there are others)
- Discussion of different DIs and their idiosyncracies
    - Show DI as a way of condensing information over time - return ot previous example only this time we can see trends instead of consternation
    - Show plots of 1 or 2 example SADs and how they compare in different DI's
- Livecoding calculating DIs
- Outstanding q's
    - This'll depend some on the slicing of the topics (domain by domain or step by step in the pipeline) as discussed earlier this week


**Isaac teaching plan (for visualization)**
* Setup: Ensure that everyone has the rstudio cloud environment open and functioning.
* Checkpoints following each exercise
* Planned activity to have a group discussion about interpreting each type of figure, bringing in examples from empirical systems
* Provide resources for how participants can go from the simple plots we have to 'publication ready' figures, e.g. plot styling and multi-panel figures (things we won't have time to cover in the episode but that nonetheless people will want to know)

**Jacob teaching points for Hill ns**
- motivation: wouldn’t it be great if we had a way of getting different kinds of diversity indices within one framework? 
- demonstration of how different data types fit into the Hill number framework
- have students plot Hill numbers of different orders in an exploratory way, just to see what happens, how are they different and what might they represent? 


**Rilquer teaching plan (importing and visualizing trait data)** - thinking already of an episode/lesson per data type

- Start with explaining what we mean by trait data, i.e., what kinds of biodiversity information are interpreted as trait, in a way to help people visualize how their own data connects to what we are naming "trait". This will help them visualize how they can combine their info with other biological dimensions (phylogeny, intraspecific GD, etc.)

- Then discuss how trait information usually is (or can be) collected and stored: by individual, time-series, average per species. Discuss the implications of this: how do we want the data to look like when combining with other dimensions of biodiversity? And how can we get our data to look like that (conceptually first, not going into coding)

- Present the simulated trait data we will be using, and then go through steps to import that data and visualize it in the R environment.
	* Show functions to import data (mostly `read.csv`)
	* Live demo of how to wrangle our trait data towards the format we want (e.g., mean per species with SD)
	* Explain how to plot a histogram of trait value distribution
	* (If we have covered phylogenies already) - Show how to map trait info into a phylogeny

**Connor teaching plan**  
Brain spew:  
*Note* we are splitting plotting among the different modules, so I imagine the first high-level intro to plotting to go in the first module that involves making a plot
* There are a multitude of options for visualizing biodiversity data
* Some are more appropriate than others
* Visualizing the same data in multiple ways helps you interpret the data from new perspectives
* We are going to give you the basics of visualizing typical biodiversity data types 
* * R has a robust built-in library for plotting
* Functions like `plot()`, `barplot()`, and `hist()` (among others) facilitate plotting and are highly customizable
* Histograms are useful for visualizing the distribution of a single variable
    * *example plot*
    * Exercise
* Barplots are useful for visualizing data that has some sort of order
    * *example plot*
    * Exercises
* Phylogenetic trees are useful for visualizing evolutionary relationships, and can visualize multiple data dimensions on a single plot
    * *example plots*
    * Exercises
* Scatterplots are useful for visualizing the relationship between two data axes
    * *example plots* 
    * Exercises
* Adding other plot components like color, shape, and transparency allows you to visualize two, three, or more dimensions of data at the same time
    * *example scatterplot. maybe make it a little ridiculous for humor*


#### Exercise: Add Setup Instructions (5 minutes)
Add Setup Instructions (in the `learners/setup.md` file) with a list of software/tools/data needed by participants to follow your lesson and links on how to obtain and install them.


#### Exercise: Add Instructor Notes (5 minutes)
Add Instructor Notes (in the `instructors/instructor-notes.md` file) with an initial list of points that will help you and other instructors deliver the lesson.


**Help Toby schedule part 2 of this training**: http://whenisgood.net/2022-12-05-cldt-part2
Update: looks like part 2 will take place on Tue 21 & Wed 22 March 2023. Toby will send calendar invitations.

Feed back collection methods and templates:
[pilot notes template](https://codimd.carpentries.org/lesson-pilot-observation-notes-template#)
[minute card template](https://docs.google.com/forms/d/1p7iOV5HNvy4POS4g6eottY8RSfKq4kaoKz1-jIFYTMI/template/preview)
[template post-workshop survey for lesson pilots](https://docs.google.com/forms/d/1OGCQBotD2nOJkc7KpFZLhFfb3EBcxEDwHz_3p48qz3U/template/preview) 






### Homework
The final part of this training will focus on the skills needed to collaborate effectively. Before that there will be a break, during which we would like you to complete the following three tasks:

1. Teach one episode of your lesson (probably the one you have been working on in these two days). See the [Lesson Trial Runs](https://carpentries.github.io/lesson-development-training/trial-runs.html) page for full details.
2. After your trial run has concluded (immediately after, or when you have reviewed any feedback you collected from learners), note down your answers to the following questions:
   - What worked?
   - What did not?
   - What will you do differently next time?
   - What will you change in your material you taught?
We will refer to these notes when we reconvene for the last episode of this training.
3. Based on your experience teaching the material and the feedback you received from your learners and helpers, make a list of issues you have identified with the material you prepared, e.g.:
   - examples that did not work as expected,
   - improvements that could be made to exercises,
   - parts that learners found particularly challenging,
   - unexpected questions or misconceptions that came up during the trial run.
  
We will return to these notes during the final training session. So please make sure you save them somewhere you will be able to find them again easily when the time comes.
    


 [Lesson Trial Runs Information](https://carpentries.github.io/lesson-development-training/instructor/trial-runs.html)


**Key Points**:
- Spending time on preparing your teaching and feedback collection will make you and your participants get the most out of your workshop pilot.
- Creating clear setup instructions as part of your lesson and circulating them ahead of the pilot is time well-invested and will give you more time when teaching the lesson.
- Instructor Notes are teaching tips that you should include with your lesson to help you (a few months down the line) and other instructors, who have the relevant topic knowledge but have not been involved in the lesson design and development, deliver your lesson more successfully. 


### Wrap-up

#### What will be covered in part 2?

1. Reflecting on trial runs
2. Collaboration skills
3. Overall wrap-up, planning for the future


#### Where can you go for help?

- send us an email
    - [Toby](tobyhodges@carpentries.org) - you can also tag me on GitHub (@tobyhodges)
    - [Sarah](mailto:sarah.stevens@wisc.edu) - on GitHub I'm [@sstevens2](https://github.com/sstevens2)
    - [Aleks](mailto:a.nenadic@manchester.ac.uk) - on GitHub :octopus: I'm [@anenadic](https://github.com/anenadic)
- send us a message on Slack:
    - on the `#lesson-dev` channel, tag us with "@" and start typing our names
    - by direct message
- for questions about how to use the lesson infrastructure, check out [the documentation for The Carpentries Workbench](https://carpentries.github.io/sandpaper-docs/).


#### Feedback!

**Please give us feedback** https://forms.gle/Af7rk8NN4v6L25C77


##### End of Part 1 Survey

:point_right: https://forms.gle/Psax4SAwQ3V1oN1Q7 :point_left: 
A slightly longer survey than the others. 
**Please** fill it in, ~10-15 mins.
Toby will also email this link to you, along with links to homework info, etc.


#### Organise Your Knowledge (10-15 min)

Take some time to think back on what has been covered so far, then make some notes on the most important points and actions you want to take away from that. The Trainers and other participants will not look at this - it is only for you.

If you do not know where to start, consider the following list for a starting point:

- draw a concept map, connecting the material
- draw pictures or a comic depicting one or more of the concepts
- write an outline of the topics we covered
- write a paragraph or “journal” entry about your experience of the training today
- write down one thing that struck you the most
- the reflection exercise below

#### Reflection Exercise
Map out the relationships between the lesson objectives (LOs), the learning experiences via which they will be delivered and those specific items of content 
e.g., 
> item A supports LO 1, \& will be delivered using a lecture  

OR more specifically  

> The read CSV and inspect demo supports Objective 2 (Use Pandas to load a simple CSV data set) and will be delivered using a lecture.

- Is there any piece of content that doesn't support any learning objectives?
- Is there at least one piece of content for each learning objective?
- Is there at least one learning experience for each piece of content?

What do you still need to add/work on? What can you remove/consider removing?
What diagram or other visual aids could you add to supplement your text?


**Andy's Reflection** [*thinking about abundances*](https://role-model.github.io/multidim-biodiv-data/instructor/abundance-data.html)

LO 1--3: data import and cleaning are covered by 
1. discussion of data formats for abundance
2. worked example of import and cleaning
3. Parsons problem challenge exsercise on import and cleaning

LO 4--5: Hill numbers are covered by
1. Hill number discussion
2. Hill number demo
3. Hill number challenge exsercise 

LO 6--8: Visualization and interpretation is covered by
1. intro and figures showing SAD viz
2. discussion of SAD viz
3. challenge exsercise in making a viz
4. lecture and discussion about connecting viz to Hill numbers


We could likely use more challenge exsercises 


