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

#WEEKDAY DAYS
set.seed(1)

#Train data sets
model_feature_wdd = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                    "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
wdd_train = weekday_day[model_feature_wdd]
wdd_num = length(unique(weekday_day$Time))

#Test for best number of states
range = c(4:18)
# bicV1 = c(4:18)
bicV2 = c(4:18)
# bicV3 = c(4:18)
# aicV1 = c(1:18)
#aicV2 = c(1:18)
# aicV3 = c(1:18)

# Loop through 4-18 states
# find the optimal nstates for weekday daytime HMM
for(n in range){

  # model1 <- depmix(
  #   response = wdd_train$Global_intensity ~ 1,
  #   family = gaussian("identity"),
  #   data= wdd_train,
  #   nstates = n,
  #   #ntimes = c(rep(wdd_num, 52))
  # )

  model2 <- depmix(
    response = wdd_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wdd_train,
    nstates = n,
    #ntimes = c(rep(wdd_num, 52))
  )

  # model3 <- depmix(
  #   response = list(wdd_train$Global_intensity ~ 1,wdd_train$Global_active_power ~ 1),
  #   family = list(gaussian("identity"),gaussian("identity")),
  #   data = wdd_train,
  #   nstates = n,
  #   #ntimes = c(rep(wdd_num, 52))
  # )

  # message("Model 1 n = ",n,": ")
  # fm1 <- fit(model1)
  # message("\n")
  message("Model 2 n = ",n,": ")
  fm2 <- fit(model2)
  message("\n")
  # message("Model 3 n = ",n,": ")
  # fm3 <- fit(model3)
  # message("\n")

  # bicV1[n] = BIC(fm1)
  bicV2[n] = BIC(fm2)
  # bicV3[n] = BIC(fm3)
  # aicV1[n] = AIC(fm1)
  #aicV2[n] = AIC(fm2)
  # aicV3[n] = AIC(fm3)
}

#WEEKDAY NIGHTS
set.seed(1)

#Train data sets
model_feature_wdn = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                      "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
wdn_train = weekday_night[model_feature_wdn]
wdn_num = length(unique(weekday_night$Time))

#Test for best number of states
range = c(11:18)
bicV4 = c(11:18)

# Loop through 4-18 states
# find the optimal nstates for weekday nights HMM
for(n in range){
  
  model4 <- depmix(
    response = wdn_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wdn_train,
    nstates = n,
    #ntimes = c(rep(wdn_num, 52))
  )
  
  message("Model 4 n = ",n,": ")
  fm4 <- fit(model4)
  message("\n")
  
  bicV4[n] = BIC(fm4)
}

#WEEKEND DAYS
set.seed(1)

#Train data sets
model_feature_wed = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                      "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
wed_train = weekend_day[model_feature_wed]
wed_num = length(unique(weekend_day$Time))

#Test for best number of states
range = c(12:18)
bicV5 = c(12:18)

# Loop through 4-18 states
# find the optimal nstates for weekday nights HMM
for(n in range){
  
  model5 <- depmix(
    response = wed_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wed_train,
    nstates = n,
    #ntimes = c(rep(wdn_num, 52))
  )
  
  message("Model 5 n = ",n,": ")
  fm5 <- fit(model5)
  message("\n")
  
  bicV5[n] = BIC(fm5)
}

#WEEKEND NIGHTS
set.seed(1)

#Train data sets
model_feature_wen = c("TrueTime", "Global_active_power", "Global_reactive_power", "Voltage",
                      "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
wen_train = weekend_night[model_feature_wen]
wen_num = length(unique(weekend_night$Time))

#Test for best number of states
range = c(13:18)
bicV6 = c(13:18)

# Loop through 4-18 states
# find the optimal nstates for weekday nights HMM
for(n in range){
  
  model6 <- depmix(
    response = wen_train$Global_active_power ~ 1,
    family = gaussian("identity"),
    data = wen_train,
    nstates = n,
    #ntimes = c(rep(wdn_num, 52))
  )
  
  message("Model 6 n = ",n,": ")
  fm6 <- fit(model6)
  fm6
  message("\n")
  
  bicV6[n] = BIC(fm6)
}

