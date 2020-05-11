

#
# Exploratory Data Analysis - Week 1 - Project 1 - Plot 1
#
# May 11, 2020 - Inselbuch
#    new module

rm(list=ls())

# load the data set
fn = "c:/users/frank.inselbuch/git/coursera/Data Exploration/Data/household_power_consumption.txt"

#
#  2,075,259 observations of 9 variables
#
# names(powerData)
# "Date"                  "Time"                  "Global_active_power"
# "Global_reactive_power" "Voltage"               "Global_intensity"
# "Sub_metering_1"        "Sub_metering_2"       
# "Sub_metering_3"  
#

# takes a while, so don't do it again and again
if (exists("powerData")) {
   print("Using cached data")
} else
   powerData <- read.table(fn,header=TRUE,sep=';',na.strings="?",stringsAsFactors=FALSE)

# create a timestamp with both the date and time
powerData$Timestamp = strptime(paste(powerData$Date,powerData$Time,sep=" "),
   "%d/%m/%Y %H:%M:%S")

# we only want data from 2007-02-01 and 2007-02-02
start_time <- strptime("01/31/2007 23:59:59","%m/%d/%Y %H:%M:%S")
end_time <- strptime("02/03/2007 0:00:00","%m/%d/%Y %H:%M:%S")

# subset the data to use only those two days
twoDays <- subset(powerData,Timestamp>start_time & Timestamp < end_time)

# par(mar=c(5,4,3,10))

# construct the histogram without x axis and various decoration
hist(twoDays$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
   main="Global Active Power",xlim=c(0,6),xaxt='n')

# add the custom axis
axis(side=1,at=seq(0,6,2))

# spurge it out as a png with the correct dimensions
dev.copy(png,file="plot1.png",width=480,height=480)

# close the png device
dev.off()