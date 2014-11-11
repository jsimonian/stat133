#################################################################################
#### Functions for BML Simulation Study

#### Initialization function.
## Input : size of grid [r and c] and probability [p]
## Output : A matrix [m] with entries 0 (no cars) 1 (red cars) or 2 (blue cars)
## that stores the state of the system (i.e. location of red and blue cars)

bml.init <- function(r, c, p){
            stopifnot(p <= 1 & p >= 0 & r > 0 & c > 0)
            m <- matrix(sample(c(0,1,2), replace = T, r*c, prob = c((1-p),p/2,p/2)), r, c)
            return(m)
}

#### Function to move the system one step (east and north)
## Input : a matrix [m] of the same type as the output from bml.init()
## Output : TWO variables, the updated [m] and a logical variable
## [grid.new] which should be TRUE if the system changed, FALSE otherwise.

## NOTE : the function should move the red cars once and the blue cars once,
## you can write extra functions that do just a step north or just a step east.

bml.step <- function(m) {
  left = matrix(c(m[,(2:ncol(m))], m[,1]), nrow(m), ncol(m))
  right = matrix(c(m[,ncol(m)], m[,(1:ncol(m)-1)]), nrow(m), ncol(m))
  m.new1 = matrix(0, nrow(m), ncol(m)) + (m == 1 & left != 0) + (right == 1 & m == 0)
  down = matrix(c(m[nrow(m),], t(m[(1:nrow(m)-1),])), nrow(m), ncol(m), byrow = T)
  up = matrix(c(t(m[(2:nrow(m)),]), m[1,]), nrow(m), ncol(m), byrow = T)
  down.new = matrix(c(m.new1[nrow(m),], t(m.new1[(1:nrow(m)-1),])), nrow(m), ncol(m), byrow = T)
  m.new2 = m.new1 + 2*((m == 2 & (down == 2 | down.new != 0)) + (up == 2 & m != 2 & m.new1 == 0))
  grid.new <- !isTRUE(all.equal(m, m.new2))
  m <- m.new2
  return(list(m, grid.new))
}

#### Function to do a simulation for a given set of input parameters
## Input : size of grid [r and c] and density [p]
## Output : *up to you* (e.g. number of steps taken, did you hit gridlock, ...)

bml.sim <- function(r, c, p){
  trial = 0
  locked = F
  mat <- bml.init(r, c, p)
  if(sum(mat) == 0) return(list(mat, 'matrix is empty', 0, NA))
  while(locked == F) {
    #image(t(apply(mat, 2, rev)), col = c('white','red','blue'))
    if(trial == 1000) return(list(mat, '1000 trials conducted, gridlock not reached', 0, NA))
    output = bml.step(mat)
    mat = output[[1]]
    locked = !output[[2]]
    trial = trial + 1
    #print(trial)
  }
  return(list(mat, sprintf("Number of trials before gridlock: %s", trial), 1, trial))
}

# (replicate function here - check lots of bml cases)

# Here lies code that didn't make it into the final cut:

# 1. bm.step.old
# Old code. Uses for loops - also, it's slightly flawed.
# Specifically, the 2s in row 1 loop to the last row "before" the 1s in the last row move.
# This is a hard to detect error - don't delete this note.

# bml.step.old <- function(m){
#   m.new <- matrix(0, nrow(m), ncol(m))
#   for(i in 1:nrow(m)) for(j in 1:ncol(m))
#     if(m[i,j] == 1 && j == ncol(m) && !m[i,1] && !m.new[i,1])
#       m.new[i,1] = 1
#   else if(m[i,j] == 1 && j != ncol(m) && !m[i,(j+1)] && !m.new[i,(j+1)]) 
#     m.new[i,j+1] = 1
#   else if(m[i,j] == 2 && i == 1 && !m[nrow(m),j] && !m.new[nrow(m),j]) 
#     m.new[nrow(m),j] = 2
#   else if(m[i,j] == 2 && i != 1 && !m[(i-1),j] && !m.new[(i-1),j]) 
#     m.new[(i-1),j] = 2 
#   else if(m[i,j] != 0) 
#     m.new[i,j] = m[i,j]
#   grid.new <- !isTRUE(all.equal(m, m.new))
#   m <- m.new
#   return(list(m, grid.new))
# }

# 2. bml.sim.beta
# For testing. Replaces the usual counter with a check of whether a grid has appeared before.
# Gets fairly slow after a few hundred iterations, useless beyond ~1000.

# bml.sim.beta <- function(r, c, p){
#   trial = 0
#   locked = F
#   mat <- bml.init(r, c, p)
#   if(sum(mat) == 0) return(list(mat, 'matrix is empty', 0))
#   original <- list(0)
#   original[[1]] <- mat
#   while(locked == F) {
#     #image(t(apply(mat, 2, rev)), col = c('white','red','blue'))
#     output = bml.step(mat)
#     mat = output[[1]]
#     locked = !output[[2]]     
#     trial = trial + 1
#     if(locked == F && list(mat) %in% original) 
#       return(list(mat, 'Reached earlier iteration: gridlock will never occur'), 0)
#     original[[(trial+1)]] = mat
#     print(trial)
#   }
#   return(list(mat, sprintf("Number of trials before gridlock: %s", trial), 1))
# }