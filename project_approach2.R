#Read data from text file
library("depmixS4")
library(ggplot2)

weekday_day <- read.delim(
  "weekday_day.txt",
  header = TRUE, sep = ",", dec = "."
)

weekday_night <- read.delim(
  "weekday_night.txt",
  header = TRUE, sep = ",", dec = "."
)

weekend_day <- read.delim(
  "weekend_day.txt",
  header = TRUE, sep = ",", dec = "."
)

weekend_night <- read.delim(
  "weekend_night.txt",
  header = TRUE, sep = ",", dec = "."
)

#Display to check
# head(weekday_day)
# head(weekday_night)
# head(weekend_day)
# head(weekend_night)

#Set model features for all 4 windows
model_feature = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                  "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Number of states to test: 8-18
range = c(8:18)
bicV1 = c(8:18)
bicV2 = c(8:18)
bicV3 = c(8:18)
bicV4 = c(8:18)

#Set train & num
wdd_train = weekday_day[model_feature]
wdd_num = length(unique(weekday_day$Time))

wdn_train = weekday_night[model_feature]
wdn_num = length(unique(weekday_night$Time))

wed_train = weekend_day[model_feature]
wed_num = length(unique(weekend_day$Time))

wen_train = weekend_night[model_feature]
wen_num = length(unique(weekend_night$Time))

#Test for best number of states
# Loop through 8-18 states
# find the optimal nstates for weekday daytime HMM
for(n in range){
  
  #WEEKDAY DAYS - model 1
  set.seed(1)
  modelV1 <- depmix(
    response = wdd_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wdd_train,
    nstates = n,
    #ntimes = c(rep(wdd_num, 52))
  )

  message("Model 1: WDD n = ",n,": ")
  fmV1 <- fit(modelV1)
  fmV1
  bicV1[n] = BIC(fmV1)
  message(bicV1[n])
  
  message("\n")
  
  #WEEKDAY NIGHTS - model 2
  set.seed(1)
  
  modelV2 <- depmix(
    response = wdn_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wdn_train,
    nstates = n,
    #ntimes = c(rep(wdn_num, 52))
  )
  
  message("Model 2 WDN n = ",n,": ")
  fmV2 <- fit(modelV2)
  fmV2
  bicV2[n] = BIC(fmV2)
  message(bicV2[n])
  
  message("\n")
  
  #WEEKEND DAYS - model 3
  set.seed(1)
  
  modelV3 <- depmix(
    response = wed_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wed_train,
    nstates = n,
    #ntimes = c(rep(wed_num, 52))
  )
  
  message("Model 3 WED n = ",n,": ")
  fmV3 <- fit(modelV3)
  fmV3
  bicV3[n] = BIC(fmV3)
  message(bicV3[n])
  
  message("\n")
  
  #WEEKEND NIGHTS - model 4
  set.seed(1)
  
  modelV4 <- depmix(
    response = wen_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wen_train,
    nstates = n,
    #ntimes = c(rep(wen_num, 52))
  )
  
  message("Model 4 WEN n = ",n,": ")
  fmV4 <- fit(modelV4)
  fmV4
  bicV4[n] = BIC(fmV4)
  message(bicV4[n])
  
  message("\n")
}

# plot(range,bicV1,xlab = "Number of states (n)",frame = FALSE,pch = "o",col = "red",main = "BIC of 4 different HMMs with n states",ylab= "BIC", ty="b",lty=1)
# lines(range,bicV2,col ="blue",ty = "b",pch = "*",lty=2)
# lines(range,bicV3,col ="black",ty = "b",pch = ".",lty=3)
# lines(range,bicV4,col ="green",ty = "b",pch = ".",lty=4)
# legend(x = "topright",legend=c("Model 1","Model 2","Model 3","Model 4"),col = c("red","blue","black","green"),pch=c("o","*",".","x"),lty=c(1,2,3,4))

