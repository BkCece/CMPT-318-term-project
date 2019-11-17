#Read data from text file
library("lubridate")
library("depmixS4")
library(ggplot2)

mydata <- read.delim(
  "TrainData.txt",
  header = TRUE, sep = ",", dec = "."
)

testdata <- read.delim(
  "test1.txt",
  header = TRUE, sep = ",", dec = "."
)



#Display data

head(mydata)

set.seed(1)

# get sunday morning
model_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                  "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
mydata = na.omit(mydata)
mydata$TrueTime = paste(mydata$Date, mydata$Time)
mydata$TrueTime = as.POSIXct(mydata$TrueTime, format="%d/%m/%Y %H:%M:%S")
mydata$T = as.POSIXct(mydata$Time, format="%H:%M:%S")
mydata$day<-weekdays(as.Date(mydata$Date, format="%d/%m/%Y"), abbr = TRUE)
mydata$year <- format(as.Date(mydata$Date, format = "%d/%m/%Y"), "%Y")


testdata_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                     "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

testdata = na.omit(testdata)
testdata$TrueTime = paste(testdata$Date, testdata$Time)
testdata$TrueTime = as.POSIXct(testdata$TrueTime, format="%d/%m/%Y %H:%M:%S")
testdata$T = as.POSIXct(testdata$Time, format="%H:%M:%S")
testdata$day<-weekdays(as.Date(testdata$Date, format="%d/%m/%Y"), abbr = TRUE)
testdata$year <- format(as.Date(testdata$Date, format = "%d/%m/%Y"), "%Y")


startTime = as.POSIXct("07:00:00", format="%H:%M:%S")
endTime = as.POSIXct("11:00:00", format="%H:%M:%S")
nightstart = as.POSIXct("18:00:00", format="%H:%M:%S")
nightend = as.POSIXct("23:00:00", format="%H:%M:%S")
mydata$daytime <- mydata$T>startTime & mydata$T<endTime
mydata$nighttime <- mydata$T>nightstart & mydata$T<nightend
mydata$week <- week(as.Date(mydata$Date, format = "%d/%m/%Y"))


testdata$daytime <- testdata$T>startTime & testdata$T<endTime
testdata$nighttime <- testdata$T>nightstart & testdata$T<nightend
testdata$week <- week(as.Date(testdata$Date, format = "%d/%m/%Y"))

testdata_2010 = subset(testdata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2010)))
testdata_dayTime_2010 = subset(testdata_2010, subset=(daytime==TRUE))
testdata_dayTime_2010$hour = format(as.POSIXct(testdata_dayTime_2010$Time, format = "%H:%M:%S"), "%H")


weekday_2007 = subset(mydata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2007)))
weekday_dayTime_2007 = subset(weekday_2007, subset=(daytime==TRUE))
weekday_dayTime_2007$hour = format(as.POSIXct(weekday_dayTime_2007$Time, format = "%H:%M:%S"), "%H")


testdata_2010 = subset(testdata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2010)))
testdata_night_2010 = subset(testdata_2010, subset=(nighttime==TRUE))
testdata_night_2010$hour = format(as.POSIXct(testdata_night_2010$Time, format = "%H:%M:%S"), "%H")


weekday_2007 = subset(mydata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2007)))
weekday_night_2007 = subset(weekday_2007, subset=(nighttime==TRUE))
weekday_night_2007$hour = format(as.POSIXct(weekday_night_2007$Time, format = "%H:%M:%S"), "%H")

weekend_2007 = subset(mydata, subset=((day %in% c("Sat", "Sun")) & (year == 2007)))
weekend_night_2007 = subset(weekend_2007, subset=(nighttime==TRUE))
weekend_night_2007$hour = format(as.POSIXct(weekend_night_2007$Time, format = "%H:%M:%S"), "%H")

testdata_weekend_2010 = subset(testdata, subset=((day %in% c("Sat", "Sun")) & (year == 2010)))
testdata_weekend_night_2010 = subset(testdata_weekend_2010, subset=(nighttime==TRUE))
testdata_weekend_night_2010$hour = format(as.POSIXct(testdata_weekend_night_2010$Time, format = "%H:%M:%S"), "%H")

weekend_2007 = subset(mydata, subset=((day %in% c("Sat", "Sun")) & (year == 2007)))
weekend_day_2007 = subset(weekend_2007, subset=(daytime==TRUE))
weekend_day_2007$hour = format(as.POSIXct(weekend_day_2007$Time, format = "%H:%M:%S"), "%H")

testdata_weekend_2010 = subset(testdata, subset=((day %in% c("Sat", "Sun")) & (year == 2010)))
testdata_weekend_day_2010 = subset(testdata_weekend_2010, subset=(daytime==TRUE))
testdata_weekend_day_2010$hour = format(as.POSIXct(testdata_weekend_day_2010$Time, format = "%H:%M:%S"), "%H")

write.table(weekday_dayTime_2007, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/weekday_dayTime_2007.txt", sep = ",")
write.table(testdata_dayTime_2010, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/testdata_dayTime_2010.txt", sep = ",")
write.table(weekday_night_2007, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/weekday_night_2007.txt", sep = ",")
write.table(testdata_night_2010, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/testdata_night_2010.txt", sep = ",")

write.table(weekend_night_2007, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/weekend_night_2007.txt", sep = ",")
write.table(testdata_weekend_night_2010, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/testdata_weekend_night_2010.txt", sep = ",")
write.table(weekend_day_2007, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/weekend_day_2007.txt", sep = ",")
write.table(testdata_weekend_day_2010, "D:/My Documents/Fall 2019/318/Project/CMPT-318-term-project/testdata_weekend_day_2010.txt", sep = ",")


#mean_aggdata <- aggregate(weekday_dayTime_2007, by = list(weekday_dayTime_2007$date, weekday_dayTime_2007$Voltage), FUN = mean, na.rm = TRUE)

# Power_perHour <- c()
# Volt_perHour <- c()
# intensity_perHour <- c()
# index <- 1

# for(w in 1:53){
#   curr = subset(weekday_dayTime_2007, subset=(weekday_dayTime_2007$week == w))
#   for(d in c("Mon", "Tue", "Wed", "Thu", "Fri")){
#     curr = subset(curr, subset=(curr$day == d))
#     print(curr$day == d)
#     for(h in 7:11){
#       curr = subset(curr, subset=(curr$hour == h)) 
#       #curr = na.omit(curr)
#       Power_perHour[index] = mean(curr$Global_active_power)
#       Volt_perHour[index] = mean(curr$Voltage)
#       intensity_perHour[index] = mean(curr$Global_intensity)
#       index = index + 1
#     }
#   }
#   
# }

# avgvolt = rep(0, (nrow(weekday_dayTime)/60) * ncol(weekday_dayTime))

# index = 1
# for(i in 1:5){
#   #current_day = subset(mydata, subset=(day %in% c(weekday_dayTime[i])))
#   for(j in 8:12){
#     endTime = as.POSIXct(toString(j), format="%H")
#     startTime = as.POSIXct(toString(j-1), format="%H")
#     current_day$inFrame <- current_day$TrueTime>startTime & current_day$TrueTime<endTime
#     tmp = subset(current_day, subset=(inFrame == TRUE))
#     validVol = subset(tmp$Voltage, subset=(tmp$Voltage>=0))
#     avgvolt[index] = mean(validVol)
#     index = index+1
#   }
# }


# plot(x = c(1:length(avgvolt)),
#      y = avgvolt,
#      xaxt = "n",
#      ty="b")
# l = c()
# for(i in 1:7){
#   l = c(l, rep(i,24))
# }
# axis(1, at = c(1:length(avgvolt)), labels = l)


# startTime = as.POSIXct("06:00:00", format="%H:%M:%S")
# endTime = as.POSIXct("12:00:00", format="%H:%M:%S")
# mydata$morning <- mydata$T>startTime & mydata$T<endTime

# sunday = subset(mydata, subset=(day %in% c("Sun")))
# sunday_morning = subset(sunday, subset=(morning==TRUE))
# 
# sunday_morning_train = sunday_morning[model_feature]
# num_day = length(unique(sunday_morning$Time))

# days = unique(mydata$day)

