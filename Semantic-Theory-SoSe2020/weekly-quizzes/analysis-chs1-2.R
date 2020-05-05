# set working directory to directory of script
this.dir <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(this.dir)

#source('helpers.R')

# load required packages
library(tidyverse)
library(forcats)
library(dichromat)
theme_set(theme_bw())

# load data
d <- read.csv(file="../data/chs1-and-2.csv", header=TRUE, sep=";")
nrow(d) #29
View(d)

summary(d)

# how many students took the quiz?
length(d$Name) #29 of 44

# how many students answered all the questions?
d$Total.number.of.Questions #12 questions total

table(d$Questions.already.worked.through)
# 27 answered all the questions

# remove students who did not answer all questions
d <- droplevels(subset(d, d$Questions.already.worked.through == d$Total.number.of.Questions))
nrow(d) #27

# how many students passed?
table(d$Test.Results.in.Marks) # all 27 (but 50% was erroneously enough)

# how many participants got how many % correct?
# create column for % correct 
d$percent.correct = d$Test.Results.in.Points / d$Maximum.Available.Points
table(d$percent.correct)

# 91,5% = 1,3 or better
length(d[d$percent.correct >= 0.915,]$Name) #1

# 79,5% = 2,3 or better
length(d[d$percent.correct >= 0.795,]$Name) #12

# 71,5% = 3,3 or better
length(d[d$percent.correct >= 0.715,]$Name) #20

# which questions were difficult, i.e., received many wrong answers?
# create data that only has names and points for each question

# columns with questions
questions <- c(20:31)

d2 = d %>%
  select(Name,questions)
View(d2)

# make the data long  
q = gather(d2, question, points, What.is.sociolinguistics. : Influence.of.Labov.1963, factor_key = TRUE)
View(q)

# aggregate data (not so useful)
question.means = q %>%
  group_by(question) %>%
  summarize(Mean = mean(points), Max = max(points), Min = min(points))
question.means

# make histogram to see how many people got how many points per question
ggplot(q, aes(points)) +
  geom_histogram() +
  facet_wrap(~ question)




