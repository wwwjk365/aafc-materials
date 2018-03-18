library(pbdDMAT, quiet = TRUE)
init.grid()
dx <- ddmatrix(data = 0:1, nrow = 10, ncol = 10)
sm <- sum(dx)
comm.print(sm, all.rank = TRUE)
pd <- prod(dx)
comm.print(pd, all.rank = TRUE)

mn <- min(dx)
comm.print(mn, all.rank = TRUE)

mx <- max(dx)
comm.print(mx, all.rank = TRUE)

finalize()