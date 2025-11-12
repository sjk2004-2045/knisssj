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


kniss_wd(repo = "knisssj")


# https://www.usgs.gov/publications/waterdata-r-package-retrieval-analysis-and-anomaly-calculation-daily-hydrologic-time
# https://doi-usgs.github.io/dataRetrieval/articles/read_waterdata_functions.html



# https://rdocumentation.org/packages/riverdist/versions/0.17.0
install.packages("riverdist")
library(riverdist)

# I need to import a shape file in the happy place to do anything with this package