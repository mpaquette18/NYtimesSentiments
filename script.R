library(RCurl)
library(RSentiment)
library(stringr)

#read in csv data
dataFrame <- data.frame(read.csv("us.csv"))
worldData <- data.frame(read.csv("world.csv"))
 
#replace all special character for use with calculate sentiment
dataFrame$title <- str_replace_all(dataFrame$title, "[^[:alnum:]]", " ") #removing all special characters
worldData$title <- str_replace_all(worldData$title, "[^[:alnum:]]", " ")

#calculate sentiments of headlines and store them in new dataframe
dataFrame3 <-  calculate_sentiment(dataFrame$title)
dataframe4 <- calculate_sentiment(worldData$title)

#output new data frames as csv
write.csv(dataFrame3, file = "us_sentiment_title.csv")
write.csv(dataframe4, file="world_sentiment_title.csv")

#plot the headline sentiment data
plot(dataFrame3$sentiment)
plot(dataframe4$sentiment)
