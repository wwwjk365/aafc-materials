
library(pbdDMAT, quiet=TRUE)

# Demonstrating distribution/undistributing of matrices, 
# matrix-matrix product, inverting a matrix, and solving a system
# of equations with 2 "right hand sides".

# This script generates a square random normal matrix with 
# specified dimension, mean, and sd, and then generates a 
# vector of 2 "right hand sides" to solve against. Next, 
# the inverse of the product t(x) %*% x is found, and then this
# matrix is used as the "left hand side" for solve().

# Finally, the same computations are performed locally using native
# R, the pbd solutions are un-distributed, and the two solutions 
# are compared using all.equal(). Two 'TRUE' statements should be 
# printed to the terminal if everything worked.

# New users are encouraged to experiment with different processor
# grid shapes (vid nprow= and npcol= in init.grid()), blocking 
# factors, and matrix sizes.

# ---------------------------------------------
# Setup
# ---------------------------------------------

init.grid() 

# Number of rows and columns to generate
nrows <- 5e3
ncols <- 5e3

mn <- 10
sdd <- 100

# ScaLAPACK blocking dimension
bldim <- c(4, 4)

# Generate data on process 0, then distribute to the others
if (comm.rank()==0) {
  x <- matrix(rnorm(n=nrows*ncols, mean=mn, sd=sdd), nrow=nrows, ncol=ncols)
  b <- matrix(rnorm(n=ncols*2, mean=mn, sd=sdd), nrow=ncols, ncol=2)
} else {
  x <- NULL  
  b <- NULL
}

dx <- as.ddmatrix(x=x, bldim=bldim)
db <- as.ddmatrix(x=b, bldim=bldim)

# Computations in parallel
dx_inv <- solve( t(dx) %*% dx )
solns <- solve(dx_inv, db)



# shut down the MPI communicators
finalize()

