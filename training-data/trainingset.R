# Libraries 
library(dplyr)
library(tm)
library(e1071)
library(caret)

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

fulldata <- rbind(wildfire, floods, earthquake, bombing, shooting, traincrash, explosion, random) %>%
  mutate(
    target = ifelse(target == 1, "tragedy", "normal") %>% factor(labels = c("tragedy", "normal"))
  )


# Create the corpus.
#
(corpus <- Corpus(VectorSource(fulldata$tweet)))

# Clean up the corpus.
#
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

#
as.character(corpus[[1]])

# Stem the documents.
#
corpus <- tm_map(corpus, stemDocument)
#
as.character(corpus[[1]])

dtm <- DocumentTermMatrix(corpus)
#
dtm <- as.data.frame(as.matrix(dtm))

# Only retain terms that occur in more than five documents. This threshold is entirely arbitrary but necessary to
# reduce the size of the data.
#
dtm = dtm[, sapply(dtm, function(column) sum(column > 0)) > 5]

# Remove highly correlated terms.
#
dtm <- dtm[, -findCorrelation(cor(dtm), cutoff = 0.65, verbose = TRUE, exact = TRUE)]

# Add in label column.
#
dtm$tragedy <- factor(fulldata$target == "tragedy", levels = c(T, F))
#
dim(dtm)
dim(fulldata)

# TRAIN/TEST SPLIT ----------------------------------------------------------------------------------------------------

index <- createDataPartition(y = dtm$tragedy, p = 0.8)[[1]]

dtm_train <- dtm[index,]
dtm_test  <- dtm[-index,]

# CREATE MODEL: LOGISTIC REGRESSION -----------------------------------------------------------------------------------

fit <- glm(tragedy ~ tweet, data = dtm_train, family = binomial)

mean((predict(fit, dtm_test, type = "response") < 0.5) == dtm_test$tragedy)
#
# Is this result meaningful?
#
table(dtm_test$tragedy)
#
# Q. Check the model coefficients.
summary(dtm_test$tragedy)

nrow(fulldata)
nrow(dtm_train)
nrow(is.na(dtm_train))
