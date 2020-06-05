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
#####Changing to proper class for other column#####
data_sub$Global_active_power <- as.numeric(as.character(data_sub$Global_active_power))
#####Convert datetime class to date######
data_sub$datetime<- as.POSIXct(data_sub$datetime, format = "%Y-%m-%d %H:%M:%OS")
#####Creating Graphics device for png#######
png("plot2.png", width=480, height=480)
with(data_sub, plot(datetime, Global_active_power, type="l", 
                      xlab="Day", ylab="Global Active Power (kilowatts)"))
#####Closing all graphics device#####
dev.off()




