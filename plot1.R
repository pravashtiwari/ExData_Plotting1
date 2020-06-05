######Exploratory Data Analysis, Assignment 1/ Week 1 ################
rm(list=ls(all=TRUE)) ####Clean the work space#####
####Set working directory######
setwd("D:\\Coursera R\\Exploratory_data_analysis\\Assigment")
#####Extracted data is in .txt format file in as mydata########
######reading data using read.table() from R- utils package#########
data<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
####Quick look on data#####
head(data)
class(data$Date) ###Checking class (factor)###
class(data$Time)###Checking class (factor)###
####changing class of all the columns to correct classes####
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
##Since we need data only from the dates 2007-02-01 and 2007-02-02##########
#####Let's Subset our data#######
data_sub <- subset(data,Date >=('2007-02-01') & Date <= ('2007-02-02'))
#******* Important note*********#
####R as default converts character vector to factor, however to convert it to numeric,
#####One has to first convert it back to character and then to numeric, direct conversion 
#####result would be a vector of the internal level representations of the factor
###and not the original values.
#*******************************#
data_sub$Global_active_power <- as.numeric(as.character(data_sub$Global_active_power))
####Create Hist Plot for the subsetted data for Global active Power"
####Creating Graphics device for png####
png("plot1.png", width=480, height=480)
#####plotting histogram####
hist(data_sub$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off() ###Shut down open Graphic Devices#####
