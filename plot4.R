######Exploratory Data Analysis, Assignment 1/ Week 1 ################
rm(list=ls(all=TRUE)) ####Clean the work space#####
####load Library####
library(tidyr)
####Set working directory######
setwd("D:\\Coursera R\\Exploratory_data_analysis\\Assigment")
#####Extracted data is in .txt format file in as mydata########
######reading data using read.table() from R- utils package#########
data<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
class(data$Date) ##factor###
######Convert into date class#####
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
#####Since we need data only from the dates 2007-02-01 and 2007-02-02###### 
data_sub <- subset(data,Date >=('2007-02-01') & Date <= ('2007-02-02'))
#####Combining Date and Time column to new datetime column############ 
data_sub<- data_sub %>% unite("datetime", Date:Time, remove = FALSE, sep = " ")
class(data_sub$datetime)
#####Convert datetime class to PoSIX**, calender dates/time######
data_sub$datetime<- as.POSIXct(data_sub$datetime, format = "%Y-%m-%d %H:%M:%OS")
####Check class of all columns####
sapply(data_sub,class)
###########Convert class of rest of  columns(factor) to proper class(numeric)#######
data_sub$Global_active_power<- as.numeric(as.character(data_sub$Global_active_power))
data_sub$Global_reactive_power<- as.numeric(as.character(data_sub$Global_reactive_power))
data_sub$Voltage<- as.numeric(as.character(data_sub$Voltage))
data_sub$Global_intensity<- as.numeric(as.character(data_sub$Global_intensity))
data_sub$Sub_metering_1 <- as.numeric(as.character(data_sub$Sub_metering_1))
data_sub$Sub_metering_2 <- as.numeric(as.character(data_sub$Sub_metering_2))
data_sub$Sub_metering_3 <- as.numeric(as.character(data_sub$Sub_metering_3))#already numeric##
####Check class of columns######
sapply(data_sub,class)

## plot the 4 graphs in 2 row 2 columns####
#####Creating Graphics device for png#######
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))####2 rows with 2 columns####
with(data_sub, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(data_sub, plot(datetime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(data_sub, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(data_sub$datetime, data_sub$Sub_metering_2,type="l", col= "red")
lines(data_sub$datetime, data_sub$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(data_sub, plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()




