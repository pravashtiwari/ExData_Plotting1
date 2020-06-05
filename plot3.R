######Exploratory Data Analysis, Assignment 1/ Week 1 ################
rm(list=ls(all=TRUE)) ####Clean the work space#####
####load Library####
library(tidyr)
####Set working directory######
setwd("D:\\Coursera R\\Exploratory_data_analysis\\Assigment")
#####Extracted data is in .txt format file in as mydata########
######reading data using read.table() from R- utils package#########
data<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
######Convert into date class#####
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
#####Since we need data only from the dates 2007-02-01 and 2007-02-02###### 
data_sub <- subset(data,Date >=('2007-02-01') & Date <= ('2007-02-02'))
#####Combining Date and Time column to new datetime column############ 
data_sub<- data_sub %>% unite("datetime", Date:Time, remove = FALSE, sep = " ")
class(data_sub$datetime)
#####Convert datetime class to date######
data_sub$datetime<- as.POSIXct(data_sub$datetime, format = "%Y-%m-%d %H:%M:%OS")
###########Convert columns to proper class#######
data_sub$Sub_metering_1 <- as.numeric(as.character(data_sub$Sub_metering_1))
data_sub$Sub_metering_2 <- as.numeric(as.character(data_sub$Sub_metering_2))
data_sub$Sub_metering_3 <- as.numeric(as.character(data_sub$Sub_metering_3))
#####Creating Graphics devce for png#######
png("plot3.png", width=480, height=480)
with(data_sub, plot(datetime, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering",
                    ylim = c(0,40)))
lines(data_sub$datetime, data_sub$Sub_metering_2,type="l", col= "red")
lines(data_sub$datetime, data_sub$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()
