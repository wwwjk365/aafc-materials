suppressMessages(library(pbdDMAT))
init.grid()

if (comm.rank() == 0) { # only read on process 0
  x <- as.matrix(read.csv("diamonds.csv"))[,-1]
  y <- as.matrix(read.csv("diamonds.csv"))[,1]
} else {
  x <- NULL
  y <- NULL
}

dx <- as.ddmatrix(x)
dy <- as.ddmatrix(y)

model <- lm.fit(dx, dy)

dx.new <- as.ddmatrix(matrix(c(2,60,60,5,5,5), nrow = 1, ncol = 6))

pred <- dx.new %*% model$coefficients

comm.cat(paste("\nThe predicted diamond price is:", submatrix(pred), "\n"), quiet=T)

finalize()