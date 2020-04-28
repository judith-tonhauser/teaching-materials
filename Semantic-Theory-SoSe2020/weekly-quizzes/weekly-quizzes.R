setwd('/Users/elenavaiksnoraite/Downloads/')
library(ggplot2)
library(tidyverse)
library(xtable)
library(dplyr)
library(lme4)
library(grid)
library(lme4)
library(tidyr)
library(dplyr)
library(plotly)
library(reshape2)
library(lmerTest)
library(languageR)
library(tidyverse)
library(openxlsx)
library(ordinal)
source("helpers.R")

quiz = read.xlsx("Week_2_results.xlsx")
summary(quiz)

summary(quiz) 

#Create a subset that looks only at the data from the participant that completed quiz,
# i.e. answered all questions
quiz2 <- droplevels(subset(quiz, 
                      quiz$Questions.already.worked.through == quiz$Total.number.of.Questions ))
hist(quiz2$Test.Results.in.Points)  
mean(quiz2$Test.Results.in.Points)  
summary(quiz2)  


# Check how many participant got 90% or more answers correct
quiz2$ninety <- ifelse(quiz2$Test.Results.in.Points >= quiz2$Maximum.Available.Points*0.9, "Yes",
                "No")
table(quiz2$ninety)


# Check how many participant got 80% or more answers correct
quiz2$eighty <- ifelse(quiz2$Test.Results.in.Points >= quiz2$Maximum.Available.Points*0.8, "Yes",
                       "No")
table(quiz2$eighty)

# Check how many participant got 70% or more answers correct
quiz2$seventy <- ifelse(quiz2$Test.Results.in.Points >= quiz2$Maximum.Available.Points*0.7, "Yes",
                       "No")
table(quiz2$seventy)

