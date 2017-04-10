library(RCurl)
library(RSentiment)
library(stringr)

dataFrame <- data.frame(read.csv("us.csv"))
worldData <- data.frame(read.csv("world.csv"))
 
##newData <- calculate_sentiment(dataFrame[1:3000,1])
dataFrame$title <- str_replace_all(dataFrame$title, "[^[:alnum:]]", " ") #removing all special characters
worldData$title <- str_replace_all(worldData$title, "[^[:alnum:]]", " ")
dataFrame3 <-  calculate_sentiment(dataFrame$title)
write.csv(dataFrame3, file = "sentiment_title.csv")


pooop <- dataFrame$date() 
plot(dataFrame3$sentiment)
##dataFrame$sentiment_title <-  calculate_sentiment(dataFrame$title)
#dataFrame$sentiment_title.text <- null
#plot(dataFrame$sentiment_title)
