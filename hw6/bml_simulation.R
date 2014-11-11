#################################################################################
#### BML Simulation Study

#### Put in this file the code to run the BML simulation study for a set of input parameters.
#### Save some of the output data into an R object and use save() to save it to disk for reference
#### when you write up your results.
#### The output can e.g. be how many steps the system took until it hit gridlock or
#### how many steps you observered before concluding that it is in a free flowing state.

### These all take a very long time to run.

result.matrix.1 <- matrix(replicate(10, sapply(c(1:100), function (x) bml.sim(10, 10, x/100)[[3]])), 100, 10)
plot(c(1:100)/100, 10*apply(result.matrix.1, 1, sum), type = "l", xlab = "Density", ylab = "Percent of grids reaching lockup", main = "Density vs Chance of Gridlock")

result.matrix.2 <- matrix(replicate(10, sapply(c(1:100), function (x) bml.sim(10, 10, x/100)[[4]])), 100, 10)
plot(c(1:100)/100, apply(result.matrix.2, 1, mean, na.rm = T), type = "l", xlab = "Density", ylab = "Average steps before lockup", main = "Density vs Steps Taken Before Gridlock")

result.matrix.3 <- matrix(replicate(10, sapply(c(5:50), function (x) bml.sim(x, x, 0.5)[[3]])), 46, 10)
plot(c(5:50), 10*apply(result.matrix.3, 1, sum), type = "l", xlab = "Matrix size", ylab = "Percent of grids reaching lockup", main = "Matrix Size vs Chance of Gridlock")

