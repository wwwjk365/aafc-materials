library(randomForest)
library(mlbench)
library(pbdMPI)

init()
data("LetterRecognition")
comm.set.seed(seed =123)
n <- nrow (LetterRecognition)

## get train data

n_train <- floor (0.8*n)
i_train <- sample.int(n , n_train) # Use 4/5 of the data to train
train <- LetterRecognition[i_train, ]
my.test_rows <- get.jid(n-n_train)
test <- LetterRecognition[my.test_rows, ]

## train random forest
comm.set.seed( seed = 1e6*runif(1), diff=TRUE)

my.k <- floor(500/comm.size())
my.rf <- randomForest(lettr ~ ., train , ntree = my.k ,norm.votes = FALSE)


rf.each <- allgather(my.rf)
rf.all <- do.call(combine, rf.each)

## predict test data
pred <- predict(rf.all, test )
correct <- allreduce(sum(pred == test$lettr ))
comm.cat(" Proportion Correct:", correct/(n - n_train) , "\n")

finalize()