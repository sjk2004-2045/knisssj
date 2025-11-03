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
#read.csv("C:/GitHub/knisssj/Honors/YCOM8_publicdata.csv")


df <- read.csv("C:/GitHub/knisssj/Honors/YCOM8_publicdata.csv", header = TRUE)
df

colnames(df)

df.Qs <- df[,6:95]
df.demog <- df[,2:5]

rownames(df.Qs) <- df[,1]
rownames(df.demog) <- df[,1]

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
poptrend <- lm(poptoplot$consensus ~ poptoplot$population)
poptrend

plot(poptoplot$consensus ~ poptoplot$population, ylim = c(40,75), xlab = "Population (# of people)", ylab = "Percent Belief in Scientific Consensus (%)", main = "Population vs. Consensus Belief By State in 2024", cex.axis=0.9, 
     cex.main = 1.5, cex.lab = 1, pch=16, col = "gray40", cex = 1)
abline(poptrend)
summary(poptrend)




library(vegan)
ord <- rda(df.Qs)
plot(ord)

plot(ord, type="n", display = "sites")
text(ord, display="sites", labels = as.character(rownames(df.Qs)))
text(ord, display="species", labels = as.character(colnames(df.Qs)), col = "red", cex = 0.5)
summary(ord)

df.demog <- as.data.frame(df.demog)
orddemo <- rda(df.Qs ~ Income, data = df.demog)
plot(orddemo)
summary(orddemo)
anova(orddemo)

colnames(df.demog)
orddemo2 <- rda(df.Qs[-1,] ~ Income*Attained.BS.or.higher+Avg.Literacy.Score+population, data = df.demog[-1,])
plot(orddemo2)
summary(orddemo2)
anova(orddemo2)

plot(orddemo2, add = TRUE, col = "blue")
plot(orddemo2, display = c("sp","bp"))




# Positive questions data plotting
read.csv("Honors/POS_question_dataset_copy.csv")

Pdf <- read.csv("Honors/POS_question_dataset_copy.csv", header = TRUE)
Pdf
#Pdf <- read.csv("C:/GitHub/knisssj/Honors/POS_question_dataset_copy.csv", header = TRUE)

colnames(Pdf)

Pdf.Qs <- Pdf[,6:50]
Pdf.demog <- Pdf[,2:5]

rownames(Pdf.Qs) <- Pdf[,1]
rownames(Pdf.demog) <- Pdf[,1]


library(vegan)
Pord <- rda(Pdf.Qs)
plot(Pord)

plot(Pord, type="n", display = "sites")
text(Pord, display="sites", labels = as.character(rownames(Pdf.Qs)))
text(Pord, display="species", labels = as.character(colnames(Pdf.Qs)), col = "red", cex = 0.5)
summary(Pord)

Pdf.demog <- as.data.frame(Pdf.demog)
Porddemo <- rda(Pdf.Qs ~ Income, data = Pdf.demog)
plot(Porddemo)
summary(Porddemo)
anova(Porddemo)

colnames(Pdf.demog)
Porddemo2 <- rda(Pdf.Qs[-1,] ~ Income*Attained.BS.or.higher+Avg.Literacy.Score+population, data = Pdf.demog[-1,])
plot(Porddemo2)
summary(Porddemo2)
anova(Porddemo2)

plot(Porddemo2, add = TRUE, col = "blue")
plot(Porddemo2, display = c("sp","bp"))

Pdf.Qs[-1,]


#Plot axis and question scores:
State_scores <- as.data.frame(Porddemo2$CCA$u)
plot(State_scores$RDA1~Pdf.Qs$consensus[-1])
plot(State_scores$RDA2~Pdf.Qs$consensus[-1])

plot(State_scores$RDA1~Pdf.Qs$drilloffshore[-1])

plot(State_scores$RDA1~Pdf.Qs$generaterenewable[-1])

plot(State_scores$RDA2~Pdf.demog$population[-1])


# Oppose questions data plotting
read.csv("Honors/R_data_OPP_copy.csv")

Odf <- read.csv("Honors/R_data_OPP_copy.csv", header = TRUE)
Odf
#Odf <- read.csv("C:/GitHub/knisssj/Honors/R_data_OPP_copy.csv", header = TRUE)


colnames(Odf)

Odf.Qs <- Odf[,6:50]
Odf.demog <- Odf[,2:5]

rownames(Odf.Qs) <- Pdf[,1]
rownames(Odf.demog) <- Pdf[,1]


library(vegan)
Oord <- rda(Odf.Qs)
plot(Oord)

plot(Oord, type="n", display = "sites")
text(Oord, display="sites", labels = as.character(rownames(Odf.Qs)))
text(Oord, display="species", labels = as.character(colnames(Odf.Qs)), col = "red", cex = 0.5)
summary(Oord)

Odf.demog <- as.data.frame(Odf.demog)
Oorddemo <- rda(Odf.Qs ~ Income, data = Odf.demog)
plot(Oorddemo)
summary(Oorddemo)
anova(Oorddemo)

colnames(Odf.demog)
Oorddemo2 <- rda(Odf.Qs[-1,] ~ Income*Attained.BS.or.higher+Avg.Literacy.Score+population, data = Odf.demog[-1,])
plot(Oorddemo2)
summary(Oorddemo2)
anova(Oorddemo2)

plot(Oorddemo2, add = TRUE, col = "blue")
plot(Oorddemo2, display = c("sp","bp"))

