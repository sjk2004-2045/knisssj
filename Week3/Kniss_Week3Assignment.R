kniss_wd <- function (repo, folder=NULL) {
  if(missing(folder))
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("/Users/sylviakniss/Documents/GitHub")} else ("for Linux run: setwd('/home/[INSERT YOUR USERNAME]/GitHub')")
    },"/",repo, sep = "")))}
  else 
    
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("/Users/sylviakniss/Documents/GitHub")} else ("for Linux run: setwd('/home/[INSERT YOUR USERNAME]/GitHub')")
    },"/",repo, "/", folder, sep = "")))}
}


kniss_wd(repo = "knisssj", folder = "Week3")



# (1) Approximately how many hours ahead of Sunbury was the peak flow in Lewisburg during the 2011 flood? (2 pt)
          # 17:00 9/8/11 in Lewisburg
          # 00:45 9/9/11 in Sunbury
    # ----> 7 hours and 45 mins ahead

# (2) Give one reason why information on the time between peak flow events up- and downstream could be valuable information? (4 pts)
          # This could be valuable information because it can be used to calculate the maximum discharge of the river during the storm.


# Package scavenger hunt! (12 pts each)

## (3) Using Google and ONLY packages from GitHub or CRAN:
# Find a package that contains at least one function specifically designed to measure genetic drift.
# Copy-paste into your script - and run - an example from the reference manual for a function within this package related to a measure of genetic drift. 
# Depending on the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
# After running the function example, manipulate a parameter within the function to create a new result. 
# Common options might be allele frequency, population size, fitness level, etc. 
# Add the results of this manipulation to your script (if in the console) or upload the new plot.

# By manipulating these parameters you can see how it impacts the results.
# This type of manipulation is one example of how theoretical ecology and modelling are used to predict patterns in nature.

            # Citation for package: Revell L. J. (2019). learnPopGen: An R package for population genetic simulation and numerical analysis. Ecology and evolution, 9(14), 7896–7902. https://doi.org/10.1002/ece3.5412

install.packages("learnPopGen")
library(learnPopGen)
genetic.drift(p0 = 0.1, Ne = 120, nrep = 4, time = 100, show = "p", pause = 0.01)

pdf(file = "Kniss_packageplot1.pdf", width = 6, height = 6)
genetic.drift(p0 = 0.1, Ne = 120, nrep = 4, time = 100, show = "p", pause = 0.01)
dev.off()

pdf(file = "Kniss_packageplot2.pdf", width = 6, height = 6)
genetic.drift(p0 = 0.1, Ne = 200, nrep = 4, time = 100, show = "p", pause = 0.01)
dev.off()

## (4) Using Google and ONLY packages from GitHub or CRAN:
# Find a package that will generate standard diversity metrics for community ecology, specifically Simpson's Diversity Index.
# Copy-paste into your script - and run - an example from the reference manual for a function to calculate Simpson's diversity. 
# Depending on the example usage of the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
# After running the function example, modify your script to generate another diversity metric that is NOT part of the example. 
# If there are multiple diversity metrics in the example script, none of these will count as the modified script.
# Hint: If the function can "only" calculate Simpson's diversity, the inverse of Simpson's diversity is another common metric. 
# Add the results of this manipulation to your script (if in the console) or upload the new plot.
# Diversity metrics are frequently used in community ecology for reasons ranging from a quick comparison between sites to understanding community stability.
# Their calculation can be very tedious by hand - and very fast with a package designed for the operation.


install.packages("vegan")
library(vegan)

data(BCI, BCI.env)
H <- diversity(BCI)
simp <- diversity(BCI, "simpson")
invsimp <- diversity(BCI, "inv")
## Unbiased Simpson
unbias.simp <- simpson.unb(BCI)
unbias.simp

print(unbias.simp)

#1         2         3         4         5         6         7         8         9        10        11        12        13        14        15 
#0.9768097 0.9705705 0.9666957 0.9735281 0.9697470 0.9650982 0.9695320 0.9694491 0.9557625 0.9683857 0.9682544 0.9576765 0.9715830 0.9740865 0.9730118 
#16        17        18        19        20        21        22        23        24        25        26        27        28        29        30 
#0.9708815 0.9570245 0.9704653 0.9678171 0.9771366 0.9709857 0.9571214 0.9752212 0.9719062 0.9748207 0.9733482 0.9693207 0.9523905 0.9507160 0.9622918 
#31        32        33        34        35        36        37        38        39        40        41        42        43        44        45 
#0.9658749 0.9586152 0.9608984 0.9629418 0.7997282 0.9671058 0.9587054 0.9386142 0.9382332 0.9155855 0.9755710 0.9755413 0.9593203 0.9602210 0.9550363 
#46        47        48        49        50 
#0.9669215 0.9694895 0.9699785 0.9632110 0.9702243 



x <- c(1,2,3,4,5,17,21,32)
groups <- c(1,2,1,2,1,2,1,2)
df <- cbind(x,groups)
df

diversity(df, index = "invsimpson", groups, equalize.groups = FALSE, MARGIN = 1, base = exp(1))

#1        2 
#1.262009 1.284882 



