suppressMessages(library(pbdDMAT, quietly = TRUE))
init.grid()

{
  if (comm.rank()==0)
    A <- matrix(1:25, 5,5)
  else
    A <- NULL
}

dA <- as.ddmatrix(A, bldim=2) # distribute

print(dA)
comm.print(submatrix(dA), all.rank = TRUE)

newA <- redistribute(dA, bldim=2, ICTXT=1)
print(newA)
comm.print(submatrix(newA), all.rank = TRUE)

finalize()