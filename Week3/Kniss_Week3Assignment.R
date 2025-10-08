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


