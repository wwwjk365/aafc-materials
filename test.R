library (pbdMPI)
init ()
comm.set.seed (seed =1234567 , diff = TRUE )

my.N <- 1e8 %/% comm.size ()
my.X <- matrix (runif(my.N * 2) , ncol = 2)
my.r <- sum (rowSums(my.X ^2) <= 1)
r <- allreduce (my.r)
PI <- 4*r/( my.N * comm.size () )
comm.print(PI)

finalize()


typeof(allreduce (x))
x <-  "1"



init()
id <- get.jid(n)
for(i in id){
 print(runif(1,0,1))
}
finalize ()