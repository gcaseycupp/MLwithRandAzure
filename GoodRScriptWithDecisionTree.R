install.packages('caret')
install.packages('randomForest')

library(caret)
library(randomForest)

origData <- read.csv2('C:\\Users\\ccupp.PETROWEB\\Documents\\SalesTemp\\ALL_GroupedOffenses_without_traffic_With_External_Less_HolidayName4.csv', sep=",", header=TRUE, stringsAsFactors=FALSE)

origData$minTemp <- as.double(origData$minTemp)
origData$maxTemp <- as.double(origData$maxTemp)
origData$precip <- as.double(origData$precip)
origData$Unemployment <- as.double(origData$Unemployment)


#not required, but interesting

cor(origData[c("offense_count","minTemp")])
cor(origData[c("offense_count","maxTemp")])
cor(origData[c("offense_count","precip")])
cor(origData[c("offense_count","WeekDay")])
cor(origData[c("offense_count","HolidayName")])
cor(origData[c("offense_count","Week")])
cor(origData[c("offense_count","DayofYear")])

set.seed(12345)

largeFeatureCols <- c("offense_count","WeekDay","Week","crime_date","Holiday","HolidayName","Unemployment", "minTemp","maxTemp","precip")
crimeDataFilteredLarge <- origData[,largeFeatureCols]

inTrainRows <- createDataPartition(crimeDataFilteredLarge$offense_count, p=0.70, list=FALSE)
trainDataFiltered <- crimeDataFilteredLarge[inTrainRows,]
testDataFiltered <- crimeDataFilteredLarge[-inTrainRows,]

lmFit <- train(offense_count ~., data=trainDataFiltered, method="lm")
#approx 1 min wait  
lmFit #Rsquared - .03

#dtreefit <- train(offense_count ~., data = trainDataFiltered, method = "rpart",trControl = testDataFiltered,tuneLength = 10)
#can't get to work


Modelfit <- train(offense_count ~., data = trainDataFiltered, method="rf")
# approx 20 min wait 
Modelfit #Rsquared - .3


