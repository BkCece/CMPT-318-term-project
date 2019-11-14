#Read data from text file
library("depmixS4")
library(ggplot2)

mydata <- read.delim(
  "TrainData.txt",
  header = TRUE, sep = ",", dec = "."
)

#Display data

head(mydata)

set.seed(1)

# get sunday morning
model_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                  "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
mydata$TrueTime = paste(mydata$Date, mydata$Time)
mydata$TrueTime = as.POSIXct(mydata$TrueTime, format="%d/%m/%Y %H:%M:%S")
mydata$T = as.POSIXct(mydata$Time, format="%H:%M:%S")
mydata$day<-weekdays(as.Date(mydata$Date, format="%d/%m/%Y"), abbr = TRUE)

# startTime = as.POSIXct("06:00:00", format="%H:%M:%S")
# endTime = as.POSIXct("12:00:00", format="%H:%M:%S")
# mydata$morning <- mydata$T>startTime & mydata$T<endTime

# sunday = subset(mydata, subset=(day %in% c("Sun")))
# sunday_morning = subset(sunday, subset=(morning==TRUE))
# 
# sunday_morning_train = sunday_morning[model_feature]
# num_day = length(unique(sunday_morning$Time))

days = unique(mydata$day)

avgvolt = rep(0, 7*24)

index = 1
for(i in 1:7){
  current_day = subset(mydata, subset=(day %in% c(days[i])))
  for(j in 1:24){
    endTime = as.POSIXct(toString(j), format="%H")
    startTime = as.POSIXct(toString(j-1), format="%H")
    current_day$inFrame <- current_day$T>startTime & current_day$T<endTime
    tmp = subset(current_day, subset=(inFrame == TRUE))
    validVol = subset(tmp$Voltage, subset=(tmp$Voltage>-1))
    avgvolt[index] = mean(validVol)
    index = index+1
  }
}
plot(c(1:length(avgvolt)),
     xaxt = "n",
     avgvolt,
     ty="b")
l = c()
for(i in 1:7){
  l = c(l, rep(i,24))
}
axis(1, at = c(1:length(avgvolt)), labels = l)





