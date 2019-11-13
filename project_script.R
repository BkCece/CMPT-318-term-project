#Read data from text file
library("depmixS4")
library(ggplot2)

mydata <- read.delim(
  "Dataset.txt",
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
startTime = as.POSIXct("08:00:00", format="%H:%M:%S")
endTime = as.POSIXct("11:00:00", format="%H:%M:%S")
mydata$morning <- mydata$T>startTime & mydata$T<endTime
mydata$day<-weekdays(as.Date(mydata$Date, format="%d/%m/%Y"), abbr = TRUE)
sunday = subset(mydata, subset=(day %in% c("Sun")))
sunday_morning = subset(sunday, subset=(morning==TRUE))

sunday_morning_train = sunday_morning[model_feature]
num_day = length(unique(sunday_morning$Time))