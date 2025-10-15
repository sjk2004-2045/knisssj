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


kniss_wd(repo = "knisssj", folder = "code")
