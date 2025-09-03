# Now it is time to create your own data frame using the tools we have learned this week.
# First, resave this script as: yourlastname_Week1_Assignment [1 point]
  # e.g. mine would be Wilson_Week1_Assignment


# Create 3 numeric vectors and 2 character vectors that are each 15 values in length with the following structures: [15 points; 3 each]
  # One character vector with all unique values
  # One character vector with exactly 3 unique values
  # One numeric vector with all unique values
  # One numeric vector with some repeated values (number of your choosing)
  # One numeric vector with some decimal values (of your choosing)

# Bind the vectors into a single data frame, rename the columns, and make the character vector with unique values the row names.[3 points]

# Remove the character vector with unique values from the data frame.[2 points]

# Add 1 row with unique numeric values to the data frame.[2 points]

# Export the data frame as a .csv file [2 points]

# Generate summary statistics of your data frame and copy them as text into your script under a new section heading. [2 points]

# Push your script and your .csv file to GitHub in a new "Week1" folder. [3 points]

cv1 <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o")
cv1

cv2 <- c("a","a","a","a","a","b","b","b","b","b","c","c","c","c","c")
cv2

nv1 <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
nv1

nv2 <- c(1,1,2,2,3,3,4,4,5,5,6,6,6,6,6)
nv2

nv3 <- c(1,1.1,1.2,3,4,5,6.7,7.23,8,10,11.1,13,14,14.23,15)
nv3

datask <- cbind(cv1,cv2,nv1,nv2,nv3)
datask

dfsk <- as.data.frame(datask)
dfsk  

colnames(dfsk) <- c("Letter","Repeats","Number","Category","Value")
dfsk

row.names(dfsk) <- dfsk$Letter
dfsk

dfsk.a <- dfsk[,-1]
dfsk.a

p <- data.frame("c",16,6,15.22)  
p

colnames(p) <- colnames(dfsk.a)
dfsk.r <- rbind(dfsk.a, p)
dfsk.r

row.names(dfsk.r) <- c(row.names(dfsk.a[1:15,]),"p")
dfsk.r

write.csv(dfsk.r, file = "Kniss_Week1_Assignment.csv")

summary(dfsk.r)

#     Repeats             Number            Category            Value         #### 
    # Length:16          Length:16          Length:16          Length:16         
    # Class :character   Class :character   Class :character   Class :character  
    # Mode  :character   Mode  :character   Mode  :character   Mode  :character  


