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




#Initial Honors data run

read.csv("Honors/YCOM8_publicdata.csv")

df <- read.csv("Honors/YCOM8_publicdata.csv", header = TRUE)
df

colnames(df)

df.Qs <- df[,6:95]
df.demog <- df[,2:5]

contrend <- lm(df.Qs$consensus ~ df.demog$Income)
contrend

plot(df.Qs$consensus ~ df.demog$Income, ylim = c(40,75), xlab = "Personal Income in 2023 ($)", ylab = "Percent Belief in Scientific Consensus in 2024 (%)", main = "Personal Income vs. Consensus Belief By State", cex.axis=0.9, 
     cex.main = 1.5, cex.lab = 1, pch=16, col = "gray40", cex = 1)
abline(contrend)
summary(contrend)

littrend <- lm(df.Qs$consensus ~ df.demog$Avg.Literacy.Score)
littrend

plot(df.Qs$consensus ~ df.demog$Avg.Literacy.Score, ylim = c(40,75), xlab = "Average Literacy Score", ylab = "Percent Belief in Scientific Consensus (%)", main = "Average Literacy Score vs. Consensus Belief By State in 2024", cex.axis=0.9, 
     cex.main = 1.5, cex.lab = 1, pch=16, col = "gray40", cex = 1)
abline(littrend)
summary(littrend)

BStrend <- lm(df.Qs$consensus ~ df.demog$Attained.BS.or.higher)
BStrend

plot(df.Qs$consensus ~ df.demog$Attained.BS.or.higher, ylim = c(40,75), xlab = "Attained a BS Degree or Higher in 2023 (%)", ylab = "Percent Belief in Scientific Consensus in 2024 (%)", main = "Degree Attained vs. Consensus Belief By State", cex.axis=0.9, 
     cex.main = 1.5, cex.lab = 1, pch=16, col = "gray40", cex = 1)
abline(BStrend)
summary(BStrend)

poptoplot <- subset(df, df$population<100000000)
poptoplot
poptrend <- lm(df.Qs$consensus ~ poptoplot$population)
poptrend

plot(df.Qs$consensus ~ poptoplot$population, ylim = c(40,75), xlab = "Population (# of people)", ylab = "Percent Belief in Scientific Consensus (%)", main = "Population vs. Consensus Belief By State in 2024", cex.axis=0.9, 
     cex.main = 1.5, cex.lab = 1, pch=16, col = "gray40", cex = 1)
abline(poptrend)
summary(poptrend)
