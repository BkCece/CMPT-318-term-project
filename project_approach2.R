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
# find the optimal nstates for all 4 HMMs
# for(n in range){
#   
#   #WEEKDAY DAYS - model 1
#   set.seed(1)
#   modelV1 <- depmix(
#     response = wdd_train$Global_active_power ~ 1,
#     family = gaussian("identity"),
#     data = wdd_train,
#     nstates = n,
#     #ntimes = c(rep(wdd_num, 52))
#   )
# 
#   message("Model 1: WDD n = ",n,": ")
#   fmV1 <- fit(modelV1)
#   fmV1
#   bicV1[n] = BIC(fmV1)
#   message("BIC 1: ", bicV1[n])
#   
#   message("\n")
#   
#   #WEEKDAY NIGHTS - model 2
#   set.seed(1)
#   
#   modelV2 <- depmix(
#     response = wdn_train$Global_active_power ~ 1,
#     family = gaussian("identity"),
#     data = wdn_train,
#     nstates = n,
#     #ntimes = c(rep(wdn_num, 52))
#   )
#   
#   message("Model 2 WDN n = ",n,": ")
#   fmV2 <- fit(modelV2)
#   fmV2
#   bicV2[n] = BIC(fmV2)
#   message("BIC 2: ", bicV2[n])
#   
#   message("\n")
#   
#   #WEEKEND DAYS - model 3
#   set.seed(1)
#   
#   modelV3 <- depmix(
#     response = wed_train$Global_active_power ~ 1,
#     family = gaussian("identity"),
#     data = wed_train,
#     nstates = n,
#     #ntimes = c(rep(wed_num, 52))
#   )
#   
#   message("Model 3 WED n = ",n,": ")
#   fmV3 <- fit(modelV3)
#   fmV3
#   bicV3[n] = BIC(fmV3)
#   message("BIC 3: ", bicV3[n])
#   
#   message("\n")
#   
#   #WEEKEND NIGHTS - model 4
#   set.seed(1)
#   
#   modelV4 <- depmix(
#     response = wen_train$Global_active_power ~ 1,
#     family = gaussian("identity"),
#     data = wen_train,
#     nstates = n,
#     #ntimes = c(rep(wen_num, 52))
#   )
#   
#   message("Model 4 WEN n = ",n,": ")
#   fmV4 <- fit(modelV4)
#   fmV4
#   bicV4[n] = BIC(fmV4)
#   message("BIC 4: ", bicV4[n])
#   
#   message("\n")
# }
# 
# #Plot BICs
# #Hardcoded after fitting to prevent loss of data
# bicV1_vals = c(86660.02, 98155.71, 90608.48, 77121.03, 85606.72, 69214.80, 68038.11, 60407.24, 54690.60, 44045.12, 25419.19, 39272.66)
# array_bicV1 = bicV1_vals/1000
# plot(range,array_bicV1,ylim = c(min(array_bicV1), max(array_bicV1)), col = "purple",ty="b",main = "Weekday Day BICs", ylab = "BIC (thousands)", xlab = "Number of States (n)")
# 
# bicV2_vals = c(220861.4, 207130.6, 200893.7, 191646.2, 187546.7, 176411.0, 167275.8, 160573.3, 160190.3, 150353.5, 144450.0)
# array_bicV2 = bicV2_vals/1000
# plot(range,array_bicV2,ylim = c(min(array_bicV2), max(array_bicV2)), col = "blue",ty="b",main = "Weekday Night BICs", ylab = "BIC (thousands)", xlab = "Number of States (n)")
# 
# bicV3_vals = c(37137.572, 32661.442, 31093.341, 28313.250, 24858.879, 25171.437, 21312.329, 15764.539, 16013.909, 12537.423, 9107.608)
# array_bicV3 = bicV3_vals/1000
# plot(range,array_bicV3,ylim = c(min(array_bicV3), max(array_bicV3)), col = "red",ty="b",main = "Weekend Day BICs", ylab = "BIC (thousands)", xlab = "Number of States (n)")
# 
# bicV4_vals = c(106127.82, 100741.32, 98137.13, 95384.38, 92016.07, 88654.77, 87345.01, 86616.32, 66846.57, 80883.88, 81017.85)
# array_bicV4 = bicV4_vals/1000
# plot(range,array_bicV4,ylim = c(min(array_bicV4), max(array_bicV4)), col = "green",ty="b",main = "Weekend Night BICs", ylab = "BIC (thousands)", xlab = "Number of States (n)")
# 
# #Display results
# plot(range,array_bicV1,ylim = c(min(array_bicV1, array_bicV2, array_bicV3, array_bicV4)/2, max(array_bicV1, array_bicV2, array_bicV3, array_bicV4)), xlab = "Number of states (n)",frame = FALSE,pch = "o",col = "purple",main = "BIC of 4 different HMMs with n states",ylab= "BIC (thousands)", ty="b",lty=1)
# lines(range,array_bicV2,col ="blue",ty = "b",pch = "*",lty=2)
# lines(range,array_bicV3,col ="red",ty = "b",pch = ".",lty=3)
# lines(range,array_bicV4,col ="green",ty = "b",pch = "x",lty=4)
# legend(x = "topright",legend=c("Model 1","Model 2","Model 3","Model 4"),col = c("purple","blue","red","green"),pch=c("o","*",".","x"),lty=c(1,2,3,4))
# 
# #Choosing the models based on max log likelihood and min BIC
# #n states for models 1, 2, 3 is 18 but for model 4 is 16

#WEEKDAY DAYS - model 1
set.seed(1)
modelV1 <- depmix(
  response = wdd_train$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wdd_train,
  nstates = 18,
  #ntimes = c(rep(wdd_num, 52))
)
fmV1 <- fit(modelV1)
fmV1

message("\n")

#WEEKDAY NIGHTS - model 2
set.seed(1)

modelV2 <- depmix(
  response = wdn_train$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wdn_train,
  nstates = 18,
  #ntimes = c(rep(wdn_num, 52))
)
fmV2 <- fit(modelV2)
fmV2

message("\n")

#WEEKEND DAYS - model 3
set.seed(1)

modelV3 <- depmix(
  response = wed_train$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wed_train,
  nstates = 18,
  #ntimes = c(rep(wed_num, 52))
)
fmV3 <- fit(modelV3)
fmV3

message("\n")

#WEEKEND NIGHTS - model 4
set.seed(1)

modelV4 <- depmix(
  response = wen_train$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wen_train,
  nstates = 16,
  #ntimes = c(rep(wen_num, 52))
)
fmV4 <- fit(modelV4)
fmV4

message("\n")

# tutorial source: https://rdrr.io/cran/depmixS4/man/depmix.fit.html, example line 18~24
set.seed(1)
wdd_test <- read.delim(
  "weekday_test_day.txt",
  header = TRUE, sep = ",", dec = "."
)
wdd_test = wdd_test[model_feature]
wdd_num = length(unique(wdd_test$Time))
modelT1 <- depmix(
  response = wdd_test$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wdd_test,
  nstates = 18,
  #ntimes = c(rep(wdd_num, 52))
)
modelT1 <- setpars(modelT1,getpars(fmV1))
logLik(modelT1)


set.seed(1)
wdn_test <- read.delim(
  "weekday_test_night.txt",
  header = TRUE, sep = ",", dec = "."
)
wdn_test = wdn_test[model_feature]
wdn_num = length(unique(wdn_test$Time))
modelT2 <- depmix(
  response = wdn_test$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wdn_test,
  nstates = 18,
  #ntimes = c(rep(wdd_num, 52))
)
modelT2 <- setpars(modelT2,getpars(fmV2))
logLik(modelT2)


set.seed(1)
wed_test <- read.delim(
  "weekend_test.txt",
  header = TRUE, sep = ",", dec = "."
)
wed_test = wed_test[model_feature]
wed_num = length(unique(wed_test$Time))
modelT3 <- depmix(
  response = wed_test$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wed_test,
  nstates = 18,
  #ntimes = c(rep(wdd_num, 52))
)
modelT3 <- setpars(modelT3,getpars(fmV3))
logLik(modelT3)



set.seed(1)
wen_test <- read.delim(
  "weekend_test_night.txt",
  header = TRUE, sep = ",", dec = "."
)
wen_test = weekend_night[model_feature]
wen_num = length(unique(weekend_night$Time))
modelT4 <- depmix(
  response = wen_test$Global_active_power ~ 1,
  family = gaussian("identity"),
  data = wen_test,
  nstates = 16,
  #ntimes = c(rep(wdd_num, 52))
)
modelT4 <- setpars(modelT4,getpars(fmV4))
logLik(modelT4)

logLik(modelT1)
logLik(modelT2)
logLik(modelT3)
logLik(modelT4)

