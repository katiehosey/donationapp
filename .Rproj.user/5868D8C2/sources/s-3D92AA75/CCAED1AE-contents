# Libraries 
library(dplyr)
library(caret)
library(rpart)
library(vcdExtra)
library(Epi)
library(rattle)

# Dataframes 
wildfire <- read.csv("training-data/Colorado_wildfires.csv", stringsAsFactors = FALSE)
floods <- read.csv("training-data/Alberta_floods.csv", stringsAsFactors = FALSE)
earthquake <- read.csv("training-data/bohol_earthquake.csv", stringsAsFactors = FALSE)
bombing <- read.csv("training-data/Boston_bombings.csv", stringsAsFactors = FALSE)
shooting <- read.csv("training-data/LA_shooting.csv", stringsAsFactors = FALSE)
traincrash <- read.csv("training-data/NY_train_crash.csv", stringsAsFactors = FALSE)
explosion <- read.csv("training-data/west_tx_explosion.csv", stringsAsFactors = FALSE)
random <- read.csv("training-data/iX_hackathon_random_tweets.csv", stringsAsFactors = FALSE)

# Merging 

train <- rbind(wildfire, floods, earthquake, bombing, shooting, traincrash, explosion, random)

View(train)







