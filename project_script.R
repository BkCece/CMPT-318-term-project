#Read data from text file
library("lubridate")
library("depmixS4")
library(ggplot2)
library(here)

mydata <- read.delim(
  "TrainData.txt",
  header = TRUE, sep = ",", dec = "."
)

testdata <- read.delim(
  "test1.txt",
  header = TRUE, sep = ",", dec = "."
)

mydata[mydata<0] <- NA
#mydata <- mydata[mydata$Global_active_power >= 0, mydata$Global_reactive_power >= 0, mydata$Voltage >= 0]
#testdata <- testdata[testdata$Global_active_power >= 0, testdata$Global_reactive_power >= 0, testdata$Voltage >= 0]
testdata[testdata<0] <-NA

mydata = na.omit(mydata)
testdata = na.omit(testdata)
#Display data

head(mydata)


cor_active_reactive <- cor(mydata$Global_active_power, mydata$Global_reactive_power)
cor_active_Voltage <- cor(mydata$Global_active_power, mydata$Voltage)
cor_active_intensitiy <- cor(mydata$Global_active_power, mydata$Global_intensity)
cor_intensity_Voltage <- cor(mydata$Voltage, mydata$Global_intensity)

cor_active_reactive_testdata <- cor(testdata$Global_active_power, testdata$Global_reactive_power)
cor_active_Voltag_testdatae <- cor(testdata$Global_active_power, testdata$Voltage)
cor_active_intensitiy_testdata <- cor(testdata$Global_active_power, testdata$Global_intensity)
cor_intensity_Voltage_testdata <- cor(testdata$Voltage, testdata$Global_intensity)

max_active <- max(mydata$Global_active_power)
max_reactive <- max(mydata$Global_reactive_power)
max_Voltage <- max(mydata$Voltage)
max_intensity <- max(mydata$Global_intensity)

min_active <- min(mydata$Global_active_power)
min_reactive <- min(mydata$Global_reactive_power)
min_Voltage <- min(mydata$Voltage)
min_intensity <- min(mydata$Global_intensity)


max_active_testdata <- max(testdata$Global_active_power)
max_reactive_testdata <- max(testdata$Global_reactive_power)
max_Voltage_testdata <- max(testdata$Voltage)
max_intensity_testdata <- max(testdata$Global_intensity)

min_active_testdata <- min(testdata$Global_active_power)
min_reactive_testdata <- min(testdata$Global_reactive_power)
min_Voltage_testdata <- min(testdata$Voltage)
min_intensity_testdata <- min(testdata$Global_intensity)



# get sunday morning
model_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                  "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

mydata$TrueTime = paste(mydata$Date, mydata$Time)
mydata$TrueTime = as.POSIXct(mydata$TrueTime, format="%d/%m/%Y %H:%M:%S")
mydata$T = as.POSIXct(mydata$Time, format="%H:%M:%S")
mydata$day<-weekdays(as.Date(mydata$Date, format="%d/%m/%Y"), abbr = TRUE)
mydata$year <- format(as.Date(mydata$Date, format = "%d/%m/%Y"), "%Y")
mydata$hour = format(as.POSIXct(mydata$Time, format = "%H:%M:%S"), "%H")


testdata_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                     "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


testdata$TrueTime = paste(testdata$Date, testdata$Time)
testdata$TrueTime = as.POSIXct(testdata$TrueTime, format="%d/%m/%Y %H:%M:%S")
testdata$T = as.POSIXct(testdata$Time, format="%H:%M:%S")
testdata$day<-weekdays(as.Date(testdata$Date, format="%d/%m/%Y"), abbr = TRUE)
testdata$year <- format(as.Date(testdata$Date, format = "%d/%m/%Y"), "%Y")
testdata$hour = format(as.POSIXct(testdata$Time, format = "%H:%M:%S"), "%H")

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


weekday = subset(mydata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri"))))
weekday_day = subset(weekday, subset=(daytime==TRUE))
weekday_day$hour = format(as.POSIXct(weekday_day$Time, format = "%H:%M:%S"), "%H")
write.table(weekday_day, here("weekday_day.txt"), sep = ",")


weekday_test = subset(testdata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri"))))
weekday_test_day = subset(weekday_test, subset=(daytime==TRUE))
weekday_test_day$hour = format(as.POSIXct(weekday_test_day$Time, format = "%H:%M:%S"), "%H")
write.table(weekday_test_day, here("weekday_test_day.txt"), sep = ",")


weekday_night = subset(weekday, subset=(nighttime==TRUE))
weekday_night$hour = format(as.POSIXct(weekday_night$Time, format = "%H:%M:%S"), "%H")
write.table(weekday_night, here("weekday_night.txt"), sep = ",")


weekday_test_night = subset(weekday_test, subset=(nighttime==TRUE))
weekday_test_night$hour = format(as.POSIXct(weekday_test_night$Time, format = "%H:%M:%S"), "%H")
write.table(weekday_test_night, here("weekday_test_night.txt"), sep = ",")


weekend = subset(mydata, subset=((day %in% c("Sat", "Sun"))))
weekend_day = subset(weekend, subset=(daytime==TRUE))
weekend_day$hour = format(as.POSIXct(weekend_day$Time, format = "%H:%M:%S"), "%H")
write.table(weekend_day, here("weekend_day.txt"), sep = ",")


weekend_test = subset(testdata, subset=((day %in% c("Sat", "Sun"))))
weekend_test_day = subset(weekend_test, subset=(daytime==TRUE))
weekend_test_day$hour = format(as.POSIXct(weekend_test_day$Time, format = "%H:%M:%S"), "%H")
write.table(weekend_test, here("weekend_test.txt"), sep = ",")


weekend_night = subset(weekend, subset=(nighttime==TRUE))
weekend_night$hour = format(as.POSIXct(weekend_night$Time, format = "%H:%M:%S"), "%H")
write.table(weekend_night, here("weekend_night.txt"), sep = ",")

weekend_test_night = subset(weekend_test, subset=(nighttime==TRUE))
weekend_test_night$hour = format(as.POSIXct(weekend_test_night$Time, format = "%H:%M:%S"), "%H")
write.table(weekend_test_night, here("weekend_test_night.txt"), sep = ",")


testdata_2010 = subset(testdata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2009)))
testdata_dayTime_2010 = subset(testdata_2010, subset=(daytime==TRUE))
testdata_dayTime_2010$hour = format(as.POSIXct(testdata_dayTime_2010$Time, format = "%H:%M:%S"), "%H")


weekday_2007 = subset(mydata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2008)))
weekday_dayTime_2007 = subset(weekday_2007, subset=(daytime==TRUE))
weekday_dayTime_2007$hour = format(as.POSIXct(weekday_dayTime_2007$Time, format = "%H:%M:%S"), "%H")


testdata_2010 = subset(testdata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2009)))
testdata_night_2010 = subset(testdata_2010, subset=(nighttime==TRUE))
testdata_night_2010$hour = format(as.POSIXct(testdata_night_2010$Time, format = "%H:%M:%S"), "%H")


weekday_2007 = subset(mydata, subset=((day %in% c("Mon", "Tue", "Wed", "Thu", "Fri")) & (year == 2008)))
weekday_night_2007 = subset(weekday_2007, subset=(nighttime==TRUE))
weekday_night_2007$hour = format(as.POSIXct(weekday_night_2007$Time, format = "%H:%M:%S"), "%H")

weekend_2007 = subset(mydata, subset=((day %in% c("Sat", "Sun")) & (year == 2008)))
weekend_night_2007 = subset(weekend_2007, subset=(nighttime==TRUE))
weekend_night_2007$hour = format(as.POSIXct(weekend_night_2007$Time, format = "%H:%M:%S"), "%H")

testdata_weekend_2010 = subset(testdata, subset=((day %in% c("Sat", "Sun")) & (year == 2009)))
testdata_weekend_night_2010 = subset(testdata_weekend_2010, subset=(nighttime==TRUE))
testdata_weekend_night_2010$hour = format(as.POSIXct(testdata_weekend_night_2010$Time, format = "%H:%M:%S"), "%H")

weekend_2007 = subset(mydata, subset=((day %in% c("Sat", "Sun")) & (year == 2008)))
weekend_day_2007 = subset(weekend_2007, subset=(daytime==TRUE))
weekend_day_2007$hour = format(as.POSIXct(weekend_day_2007$Time, format = "%H:%M:%S"), "%H")

testdata_weekend_2010 = subset(testdata, subset=((day %in% c("Sat", "Sun")) & (year == 2009)))
testdata_weekend_day_2010 = subset(testdata_weekend_2010, subset=(daytime==TRUE))
testdata_weekend_day_2010$hour = format(as.POSIXct(testdata_weekend_day_2010$Time, format = "%H:%M:%S"), "%H")

write.table(weekday_dayTime_2007, here("weekday_dayTime_2008.txt"), sep = ",")
write.table(testdata_dayTime_2010, here("testdata_dayTime_2009.txt"), sep = ",")
write.table(weekday_night_2007, here("weekday_night_2008.txt"), sep = ",")
write.table(testdata_night_2010, here("testdata_night_2009.txt"), sep = ",")

write.table(weekend_night_2007, here("weekend_night_2008.txt"), sep = ",")
write.table(testdata_weekend_night_2010, here("testdata_weekend_night_2009.txt"), sep = ",")
write.table(weekend_day_2007, here("weekend_day_2008.txt"), sep = ",")
write.table(testdata_weekend_day_2010, here("testdata_weekend_day_2009.txt"), sep = ",")


#Phase 2: Anomaly Detection Approach

#Approach 1: Finding Point Anomalies. 
#Part I: Out of range: Choosing "Global active power" and "Voltage" to make comparision
# Find min and max Voltage per 1 hour window and compare to Voltage of testdata

anonfeature = mydata[c("Date", "Time","TrueTime", "Voltage","Global_active_power")]
start = as.POSIXct("00:00:00", format="%H:%M:%S")
end = as.POSIXct("01:00:00", format="%H:%M:%S")
count = 0
for(i in 0:23){
  # Slice the data in 1 hour time window
  dataSlice = mydata[ mydata$T > start & mydata$T < end,]
  testSlice = testdata[testdata$T > start & testdata$T < end,]
  
  #Check for out of range in the time window
  if(length(testSlice$Voltage) > 0){
    minVol = min(dataSlice$Voltage)
    maxVol = max(dataSlice$Voltage)
    #minAct = min(dataSlice$Global_active_power)
    #maxAct = max(dataSlice$Global_active_power)
    outOfRangeV = testSlice[testSlice$Voltage<minVol | testSlice$Voltage>maxVol,]
    len = length(outOfRangeV$Vol)
    minV = 1:len
    maxV = 1:len
    minV[1:len] = minVol
    maxV[1:len] = maxVol
    #If there is out of range point plot it
    if(len > 0){
      
      if(count == 0){
        plot(outOfRangeV$Time,outOfRangeV$Vol,main = "Out of Range Voltage with 1 hour time slide",type = "p", ylim=range(220,260))
        lines(outOfRangeV$Time,minV, col ="blue",ty = "b",pch = "*")
        lines(outOfRangeV$Time,maxV, col ="red",ty = "b",pch = "*")
        count = count + 1
      }
      else{
        lines(outOfRangeV$Time,outOfRangeV$Vol,type = "p")
        lines(outOfRangeV$Time,minV, col ="blue",ty = "b",pch = "*")
        lines(outOfRangeV$Time,maxV, col ="red",ty = "b",pch = "*")

      }
      legend(x = "topright",legend=c("Min","Max","Anomaly"),col = c("blue","red","black"),pch = c(8,8,8))
    }
  }
  # Move the time window
  start = start + hours(1)
  end = end + hours(1)
}
#Plot
attach(mtcars)
plot(anonTest$Time,anonTest$Voltage)
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

