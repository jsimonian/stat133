#### Midterm in Statistics 133 Lecture 1 Fall 2014
#### Tuesday October 21st 2014
#### Good Luck!

#### Note:  Please use the EXACT variable names provided in the instructions.
####        The variable name is provided within double square brackets, e.g. [[ x ]]
####        The square brackets are simply there as a visual aide, so that you can quickly find it.
  
#### Note:  Remember to save your work during the test
####        Keep a terminal window open and do a [git add .] early
####        Then do [git commit -m "message"] and [git push] at the end, and preferably once or twice during the exam.

########################################### FIRST PART
present = T
#### We will start with a few small tasks.

## In one R command, create a variable [[ x ]] which is a vector and has
## all the even numbers between 2 and 20, in increasing order.
x <- c(2:20)[c(2:20)%%2 == 0]

## In one R command, create a variable [[ y ]] which is a vector and has
## all the odd numbers between -1 and -19, in decreasing order
y <- c(-1:-19)[c(-1:-19)%%2 == 1]

## In one R command, create a variable [[ z ]] which is a vector and has
## the numbers 1 through 5, each repeated 4 times, in order (so 1 1 1 1 2 2 2 2 etc.)
z <- rep(1:5,each=4)

## In one R command, create a variable [[ m ]] that is a 3-by-4 matrix and has
## the entries 10, 20, through 120, where the numbers are entered row by row
## (so the first row is [ 10 20 30 40 ]).
m <- t(matrix(10*c(1:12), nrow=4, ncol=3))

## Create a variable [[ n ]] that is a data frame of dimension 10 x 3
## where the first column is the numbers 1-10, the second column the letters a-j and the
## third column has T/F, T if the number in column 1 is even, F if the number in column 1 is odd.
## Then add the column names :  num, lett, even
num <- c(1:10) 
lett <- c("a","b","c","d","e","f","g","h","i","j") 
even <- c(1:10)%%2 == 0
n <- data.frame(num, lett, even)

## Create a variable [[ p ]] that is a list and whose elements are x, y, z and m from above.
p <- list(x, y, z, m)

## Create a variable [[ nmat ]] that is a matrix of size 100 x 100 and whose
## elements are drawn from a Normal distribution with mean 6 and sd 2
## Do not remove the set.seed command
set.seed(42)
nmat <- matrix(rnorm(10000, mean = 6, sd = 2), nrow=100, ncol=100)

########################################### SECOND PART

## Load in the rainfall data, the file is in the same directory as this test.
## You should get two objects, rain and day.
load("rainfallCO.rda")

## Extract the type of the variable rain and store in [[ type.rain ]]
type.rain = typeof(rain)

## Extract the names of the elements in rain and store in  [[ name.stations ]]
names.stations = names(rain)

## In one R command create the variable [[ n.obs ]] , a vector which stores the number
## of observations at EACH of the stations in rain
n.obs = lapply(rain, NROW)

## In one R command create the variable [[ max.rain ]] which stores the maximum
## rainfall for each weather station.
max.rain = lapply(rain, max)

## Plot a boxplot that shows the distribution of rainfall at each station
## (hint: there should be 5 "boxes" in the boxplot)
boxplot(rain, main = "Boxplots of rainfall at each station")

## Make a scatterplot that shows the rainfall at station 1 in year 2000.
## Precipitation should go on the y-axis and day on the x-axis
## Make new labels for the x- and y-axis.
## Hint: the date information is stored in the object day.
plot(rain$st050183[day$st050183 < 2001 & day$st050183 >= 2000], xlab = "date", ylab = "rainfall", main = "Station 1 Rainfall by day in the year 2000")


########################################### THIRD PART
#### Load in the infant data
load("KaiserBabies.rda")

## Let us do a linear regression of birth weight (bwt) as a function of the length
## of the pregnancy
## make sure to keep this line:
fit <- lm(bwt ~ gestation, data=infants)

## The object fit is a list and in it you will find the coefficients of the regression
## Do a scatterplot of birthweight (on y-axis) vs. gestation (on x-axis)
## Add to the plot the line estimated in fit (hint: find the coefficients)
## Plot the line in red and put your own x- and y-axis labels on the plot.
plot(infants$gestation, infants$bw, xlab = "gestation", ylab = "birthweight", main = "Birthweight vs. Gestation of Infants")
abline(-10.0642, 0.4643, col = 'red')

## Plot a histogram of the fathers' heights (varible dht in the data frame).
hist(infants$dht, xlab = "father's height", main = "Histogram of Father's Heights")

## Create a table which tallies the education level of mothers (varible ed in the data frame)
## against the education level of the fathers (variable ded in the data frame)
table(infants$ed, infants$ded)

########################################### FOURTH PART
## Write a function that takes as input a vector x and returns a standardized vector
## (i.e. x after subtracting the mean and dividing with the sd)

standardize <- function(x){
               return((x - mean(x))/sd(x))
}