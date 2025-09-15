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



# With the data frame you created last week you will:

# Create a barplot for one numeric column, grouped by the character vector with 3 unique values (10 points)
  # Add error bars with mean and standard deviation to the plot
  # Change the x and y labels and add a title
  # Export the plot as a PDF that is 4 inches wide and 7 inches tall.

# Create a scatter plot between two of your numeric columns. (10 points)
  # Change the point shape and color to something NOT used in the example.
  # Change the x and y labels and add a title
  # Export the plot as a JPEG by using the "Export" button in the plotting pane.

# Upload both plots with the script used to create them to GitHub. (5 points)
  # Follow the same file naming format as last week for the script.
  # Name plots as Lastname_barplot or Lastname_scatterplot. Save them to your "plots" folder. (5 points)

cv1 <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o") #Letter
cv1
cv2 <- c("a","a","a","a","a","b","b","b","b","b","c","c","c","c","c") #Repeats
cv2
nv1 <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) #Number
nv1
nv2 <- c(1,1,2,2,3,3,4,4,5,5,6,6,6,6,6) #Category
nv2
nv3 <- c(1,1.1,1.2,3,4,5,6.7,7.23,8,10,11.1,13,14,14.23,15) #Value
nv3
datask <- cbind(cv1,cv2,nv1,nv2,nv3)
datask
dfsk <- as.data.frame(datask)
dfsk  
colnames(dfsk) <- c("Letter","Repeats","Number","Category","Value")
dfsk
row.names(dfsk) <- dfsk$Letter
dfsk
dfsk$Number <- as.numeric(as.character(dfsk$Number))
dfsk$Category <- as.numeric(as.character(dfsk$Category))
dfsk$Value <- as.numeric(as.character(dfsk$Value))
p <- data.frame("p","c",16,6,15.22)  
p
colnames(p) <- colnames(dfsk)
dfsk.r <- rbind(dfsk, p)
dfsk.r
row.names(dfsk.r) <- c(row.names(dfsk[1:15,]),"p")
dfsk.r
row.names(dfsk.r) <- dfsk.r$Letter
dfsk.r


df.mean <- aggregate(dfsk.r$Category ~dfsk.r$, FUN = "mean")
df.mean

colnames(df.mean) <- c("Factor","Mean")
df.mean

barplot(df.mean$Mean, names.arg = df.mean$Factor)

df.sd <- aggregate(dfsk.r$Category ~dfsk.r$Repeats, FUN = "sd")



colnames(df.sd) <- c("Factor","StanDev")
df.sd

b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor)


arrows(b.plot, df.mean$Mean-df.sd$StanDev,
       b.plot, df.mean$Mean+df.sd$StanDev,angle=90,code=3)


